import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick 2.5
import QtMultimedia 5.6

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Text {
        text: "Click Me!";
        font.pointSize: 24;
        width: 150; height: 50;

        Audio{
            id: playMusic
            source: "hungerkunstler/sound1.mp3"
        }
        Button{
            id: playArea
            anchors.fill: parent
            onClicked:
            {
                var times = [100, 500];
                console.log(playMusic.playbackState);
                if(playMusic.playbackState==1)
                    playMusic.pause();
                else
                    playMusic.play()
                console.log("mousearea");
            }
        }
    }

    Text {
        id: timeText
        x: 10
        y: 30
        text: Qt.formatTime(new Date(),"hh:mm:ss")
    }
    Text {
        id: timeText2
        x: 10
        y: 50
        text: Qt.formatTime(new Date(),"hh:mm:ss")
    }

    Timer {
        property int phase: 0
        property var times: [0.5, 100.6, 30.8]
        id: timer
        interval: 500
        repeat: true
        running: true

        onTriggered:
        {
            timeText.text =  playMusic.position / 1000.0;
            timeText2.text = times[2];
        }
    }
}
