import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick 2.5
import QtMultimedia 5.6

/*Item {
    width: 1024
    height: 600

    MediaPlayer {
        id: player
        source: "trailer_400p.ogg"
    }

    VideoOutput {
        anchors.fill: parent
        source: player
    }

    Component.onCompleted: {
        player.play();
    }
}*/

/*Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    MainForm {
        anchors.fill: parent
        mouseArea.onClicked: {
            console.log(qsTr('Clicked on background. Text: "' + textEdit.text + '"'))
        }
        //some comment
    }
}*/

/*Text {
    text: "Click Me!";
    font.pointSize: 24;
    width: 150; height: 50;

    MediaPlayer {
        id: playMusic
        source: "../germanbook/hungerkunstler/sound1.mp3"
    }
    MouseArea {
        id: playArea
        anchors.fill: parent
        onPressed:  { playMusic.play() }
    }
}*/
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
            source: "../germanbook/hungerkunstler/sound1.wav"
        }
        MouseArea {
            id: playArea
            anchors.fill: parent
            onPressed:  { playMusic.play();
            console.log("mousearea");
            console.log(playMusic.duration);}
        }
}
}
