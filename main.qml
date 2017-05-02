import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick 2.5
import QtQuick.Dialogs 1.0
import QtMultimedia 5.6
import QtWebEngine 1.0
import QtQuick.Controls 1.2

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    /* global properties */
    property int whichOne: 0;
    property int howMany: 2;

    /* global functions*/
    Component.onCompleted:{
        console.log("window completed")
        var flag = 2;
        /*
          0 = dialog,
          1 = mac,
          2 = ajp windows
          */
        switch(flag)
        {
        case 2:
            fileDialog.stem = "file:///C:/Users/AJP/Documents/germanbook/hungerkunstler/";
            setup();
            break;
        default:
            fileDialog.open();
            break;
        }
    }
    function textToTime(text)
    {
        console.log("textToTime: text="+text);
        return Number(text);
    }
    function setup()
    {
        webView1.url = fileDialog.stem + "text1.html";
        webView2.url = fileDialog.stem + "text2.html";

        playMusic1.source = fileDialog.stem + "sound1.mp3";
        playMusic2.source = fileDialog.stem + "sound2.mp3";
        timer.canStart = true;
    }

    FileDialog {
        id: fileDialog
        property string stem : ""
        title: "Please choose a file"
        folder: shortcuts.home
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)
            var s = fileDialog.fileUrl.toString();
            console.log("res: "+s);
            stem = s.substring(0,s.lastIndexOf('/'))
            stem += "/";
            console.log("stem: "+stem);
            setup();
            //Qt.quit()
        }
        onRejected: {
            console.log("Canceled")
            Qt.quit()
        }
    }
    Audio{
        id: playMusic1
        source: "hungerkunstler/sound1.mp3"
    }
    Audio{
        id: playMusic2
        source: "hungerkunstler/sound1.mp3"
    }
Column{
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    spacing: 5
    WebEngineView {
        property double stopTime: -1.0;
        width: 640
        property int phase: 0
        height: 200
        id: webView1
        url: "hungerkunstler/text1.html"
        onLoadingChanged:
        {
            if(loading==false && timer.canStart)
                this.runJavaScript("startTime()", function(result) { playMusic1.seek(1000*textToTime(result)); });
        }
        function nextPhase()
        {
            /*
            myButton.text =  (playMusic.position / 1000.0) + "/" + stopTime+"("+phase+")"+ "/" + (playMusic.duration / 1000.0);

            if( stopTime>0 && playMusic.position/1000.0 >= stopTime)
            {
                playMusic.pause();
                myButton.isOnStart = true;
            }
              */
        }
    }
    WebEngineView {
        property double stopTime: -1.0;
        property int phase: 0
        width: 640
        height: 200
        id: webView2
        url: "hungerkunstler/text1.html"
        onLoadingChanged:
        {
            if(loading==false && timer.canStart)
                this.runJavaScript("startTime()", function(result) { playMusic2.seek(1000*textToTime(result)); });
        }
        function nextPhase()
        {
            /*
            myButton.text =  (playMusic.position / 1000.0) + "/" + stopTime+"("+phase+")"+ "/" + (playMusic.duration / 1000.0);

            if( stopTime>0 && playMusic.position/1000.0 >= stopTime)
            {
                playMusic.pause();
                myButton.isOnStart = true;
            }
              */
        }
        function buttonClick()
        {
            //TODO
        }
        function update()
        {
            //TODO
        }
    }
    Button{
        id: myButton
        text: "Click Me!"
        anchors.horizontalCenter: parent.horizontalCenter
        property bool isOnStart: true;
        property double startTime: 0
        onClicked:
        {
            switch(whichOne)
            {
            case 0:
                webView1.buttonClick();
                break;
            case 1:
                webView2.buttonClick();
                break;
            }

            /*if(isOnStart)
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
            }*/
        }
    }
}
    Timer{
        property bool canStart : false;
        id: timer
        interval: 50
        repeat: true
        running: true

        onTriggered:
        {
            if(!canStart) return;
            webView1.update();
            webView2.update();
            /*
            switch(whichOne)
            {
            case 0:
                webView1.nextPhase();
                break;
            case 1:
                webView2.nextPhase();
                break;
            }

            whichOne = (whichOne+1) % howMany;*/
        }
    }
}
