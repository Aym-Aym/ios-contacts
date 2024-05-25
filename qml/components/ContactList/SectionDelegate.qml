import QtQuick

Rectangle {
    id: sectionDelegate

    width: parent.width
    height: 25

    color: listView.currentSection == section ? contactListPages.topColor : root.darkmode ? "#000" : "#FFF"

    transitions: Transition {
        ColorAnimation {
            duration: 150
        }
    }

    Text {
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 15
        }

        text: section
        font.bold: true
        color: root.mainTextColor
    }

    Rectangle {
        id: searchFieldSplitter
        height: 1

        anchors {
            left: parent.left
            leftMargin: 15
            right: parent.right
            rightMargin: 15
            top: parent.top
        }

        color: root.splitterColor

        visible: listView.currentSection == section ? false : true
    }
}
