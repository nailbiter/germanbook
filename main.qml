import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick 2.5
import QtMultimedia 5.6
import QtWebEngine 1.0
import QtQuick.Controls 1.2

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

Audio{
    id: playMusic
    source: "hungerkunstler/sound1.mp3"
}
Button{
    id: myButton
    anchors.fill: parent
    text: "Click Me!"
    anchors.rightMargin: 190
    anchors.bottomMargin: 25
    anchors.leftMargin: 190
    anchors.topMargin: 387
    property bool isOnStart: true;
    property double startTime: 0;
    onClicked:
    {
        if(isOnStart)
        {
            isOnStart = false;
            console.log("seekable="+playMusic.seekable);
            timer.phase++;
            webView.runJavaScript("cb(\""+ timer.phase + "\")", function(result) {
                if(String(result).localeCompare("eof") != 0)
                    timer.stopTime = textToTime(result);
                else
                {
                    //FIXME: "initialize" function
                    playMusic.stop();
                    timer.phase = 0;
                    timer.stopTime = -1.0;
                }
            });
            playMusic.play()
        }
        else
        {
            if(playMusic.playbackState==1)
                playMusic.pause();
            else
                playMusic.play()
        }
    }
}
function textToTime(text)
{
    console.log("textToTime: text="+text);
    return Number(text);
}

    WebEngineView {
        width: 640
        height: 200
        anchors.rightMargin: 21
        anchors.bottomMargin: 110
        anchors.leftMargin: 21
        anchors.topMargin: 11
        id: webView
        anchors.fill: parent
        url: "hungerkunstler/text1.html"
        /*javaScriptConsoleMessage:
        {

        }*/

        onLoadingChanged:
        {
            if(loading==false)
                webView.runJavaScript("startTime()", function(result) { playMusic.seek(1000*textToTime(result)); });
        }
    }

    Timer{
        property int phase: 0
        property double stopTime: -1.0;
        id: timer
        interval: 50
        repeat: true
        running: true

        onTriggered:
        {
            myButton.text =  (playMusic.position / 1000.0) + "/" + stopTime+"("+phase+")"+ "/" + (playMusic.duration / 1000.0);

            if( stopTime>0 && playMusic.position/1000.0 >= stopTime)
            {
                playMusic.pause();
                myButton.isOnStart = true;
            }

        }
    }
}
