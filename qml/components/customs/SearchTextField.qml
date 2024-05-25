import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects

TextField {
    id: customTextField

    states: [
        State {
            name: "textOn"; when: customTextField.text !== ""
            PropertyChanges { target: emptyBtn; opacity: 1 }
            PropertyChanges { target: emptyBtn; visible: true }
        }
    ]

    transitions: [
        Transition {
            NumberAnimation {
                target: emptyBtn
                properties: "opacity"
                duration: 200
            }
        }
    ]

    placeholderText: "Search"
    placeholderTextColor: root.darkmode? "#98989F": "#848389"
    color: root.mainTextColor

    background: Rectangle {
        color: root.darkmode? "#1C1C1E": "#EEEEF0"
        radius: 10

        Image {
            id: searchLogo
            width: 12
            height: 12

            anchors {
                left: parent.left
                leftMargin: 10
                verticalCenter: parent.verticalCenter
            }

            source: "../../../assets/images/magnifyingglass.svg"
        }

        ColorOverlay {
            anchors.fill: searchLogo
            source: searchLogo
            color: "#98989F"
        }
    }

    RoundButton {
        id: emptyBtn
        anchors {
            right: parent.right
            rightMargin: 8
            verticalCenter: parent.verticalCenter
        }

        width: 13
        height: 13
        radius: 7
        opacity: 0
        visible: false

        background: Item {
            Image {
                id: emptyImg
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }
                width: 13
                height: 13

                source: "../../../assets/images/xmark.circle.fill.svg"
            }

            ColorOverlay {
                anchors.fill: emptyImg
                source: emptyImg
                color: "#98989F"
            }
        }

        onReleased: {
            customTextField.text = ""
            readSignal.search_signal(textfield.text)
        }
    }
}
