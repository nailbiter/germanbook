import QtQuick 2.6

Rectangle {
    property alias textEdit: textEdit

    width: 360
    height: 360

    TextEdit {
        id: textEdit
        text: qsTr("Enter some text...")
        verticalAlignment: Text.AlignVCenter
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 20
    }

    Button {
        id: button
        x: 103
        y: 63
        width: 154
        height: 75
    }
}
