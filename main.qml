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
    onClicked:
    {
        playMusic.play()
        /*var times = [100, 500];
        console.log(playMusic.playbackState);
        if(playMusic.playbackState==1)
        playMusic.pause();
        else
        playMusic.play()
        console.log("mousearea");*/
    }
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
    }

    Timer{
        property int phase: 0
        property var times: [5.8, 10.6]
        id: timer
        interval: 50
        repeat: true
        running: true

        onTriggered:
        {
            myButton.text =  (playMusic.position / 1000.0) + "/" + times[phase] + "/" + (playMusic.duration / 1000.0);

            if( playMusic.position/1000.0 >= times[phase])
            {
                playMusic.pause();
                phase++;
            }

        }
    }
}
