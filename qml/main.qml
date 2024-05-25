import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    id: root

    // declare defaults properties
    property bool darkmode: true
    property color mainColor: darkmode? "#000": "#FFF"
    property color secondaryColor: darkmode? "#000": "#F3F2F8"
    property color mainTextColor: darkmode? "#FFF": "#000"
    property color mainButtonColor: "#0B83FF"
    property color splitterColor: darkmode? "#3D3C41": "#D8D8D8"
    property bool test: false
    property int maxHeaderHeight: 100

    // set window properties
    width: 400
    height: 600
    visible: true
    title: qsTr("iOS Contact")
    color: root.mainColor

    // pages
    StackView {
        id: stackView
        anchors.fill: parent

        // set default page
        Component.onCompleted: stackView.push(Qt.resolvedUrl("./screens/ContactList.qml"))

        // page change transitions
        pushEnter: Transition {
            PropertyAnimation {
                property: "x"
                from: root.width
                to: 0
                duration: 200
            }
        }

        pushExit: Transition {
            PropertyAnimation {
                property: "x"
                from: 0
                to: -root.width
                duration: 800
            }
        }

        popEnter: Transition {
            PropertyAnimation {
                property: "x"
                from: -(root.width/2)
                to: 0
                duration: 250
            }
        }

        popExit: Transition {
            PropertyAnimation {
                property: "x"
                from: 0
                to: root.width
                duration: 200
            }
        }
    }
}
