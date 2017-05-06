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
    property string stem : ""

    /* global functions*/
    Action {
        shortcut: "Space"
        onTriggered: {
            buttonClick();
        }
    }
    Component.onCompleted:
    {
        var flag = 1;
        /*
          0 = dialog,
          1 = mac,
          2 = ajp windows
          */
        switch(flag)
        {
        case 1:
            stem = "file:///Users/nailbiter/forqt/germanbook/hungerkunstler/";
            setup();
            break;
        case 2:
            stem = "file:///C:/Users/AJP/Documents/germanbook/hungerkunstler/";
            setup();
            break;
        default:
            fileDialog.open();
            break;
        }
    }
    function buttonClick()
    {
            switch(whichOne)
            {
            case 0:
                if(view1.getPlaybackState()==1)
                    view1.pause();
                else
                    view1.play();
                break;
            case 1:
                if(view2.getPlaybackState()==1)
                    view2.pause();
                else
                    view2.play();
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

    function setup()
    {
        whichOne = 0;
        view1.setup(stem + "text1.html", stem + "sound1.mp3",0);
        view2.setup(stem + "text2.html", stem + "sound2.mp3",1);
        timer.canStart = true;
    }

    FileDialog {
        id: fileDialog
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
        }
        onRejected: {
            console.log("Canceled")
            Qt.quit()
        }
    }
Column{
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    spacing: 5
    Karaoke{
        id: view1
    }
    Karaoke{
        id: view2
    }

    Button{
        id: myButton
        text: "pause/play"
        anchors.horizontalCenter: parent.horizontalCenter
        property bool isOnStart: true;
        property double startTime: 0
        onClicked: buttonClick()
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
            var transitionRequest;
            switch(whichOne)
            {
            case 0:
                transitionRequest = view1.update(whichOne);
                break;
            case 1:
                transitionRequest = view2.update(whichOne);
                break;
            }
            if(transitionRequest)
                whichOne = (whichOne+1) % howMany;
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
