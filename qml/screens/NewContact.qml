import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

import "../models/"
import "../components/NewContact/"

Popup {
    id: newContact

    width: root.width
    height: root.height - windowY
    y: windowY
    closePolicy: Popup.NoAutoClose

    background: Rectangle {
        id: popupBg
        color: "#1C1C1E"
        radius: 8
        anchors.fill: parent
    }

    contentItem: Item {
        anchors.fill: parent

        Rectangle {
            id: top

            states: [
                State {
                    name: "scroll_on"
                    when: listView.contentY >= 1

                    PropertyChanges {
                        target: top
                        color: "#282828"
                    }
                }
            ]

            transitions: Transition {
                ColorAnimation {
                    target: top
                    properties: "color"
                    duration: 50
                }
            }

            width: root.width
            height: 50
            radius: 8

            color: "#1C1C1E"

            Rectangle {
                id: topBottom

                states: [
                    State {
                        name: "scroll_on"
                        when: listView.contentY >= 1

                        PropertyChanges {
                            target: topBottom
                            color: "#282828"
                        }
                    }
                ]

                transitions: Transition {
                    ColorAnimation {
                        target: topBottom
                        properties: "color"
                        duration: 50
                    }
                }

                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
                height: 9

                color: "#1C1C1E"
            }

            Rectangle {
                id: splitter
                anchors {
                    bottom: parent.bottom
                }

                width: root.width
                height: 1

                color: "#00000000"

                states: [
                    State {
                        name: "scroll_on"
                        when: listView.contentY >= 1

                        PropertyChanges {
                            target: splitter
                            color: "#3C3C3E"
                        }
                    }
                ]

                transitions: Transition {
                    ColorAnimation {
                        target: splitter
                        properties: "color"
                        duration: 50
                    }
                }
            }

            Text {
                id: topTitle
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }

                text: "New Contact"
                color: root.mainTextColor
                font.weight: Font.Bold
            }

            Button {
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 10
                }

                contentItem: Text {
                    text: "Cancel"
                    color: root.mainButtonColor
                }

                background: Rectangle {
                    color: "#00000000"
                }

                onReleased: {
                    newContact.close()
                }
            }

            Button {
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: 10
                }

                enabled: false

                contentItem: Text {
                    text: "Done"
                    color: enabled? root.mainButtonColor: "#404042"
                }

                background: Rectangle {
                    color: "#00000000"
                }

                onReleased: {
                    newContact.close()
                }
            }
        }

        Item {
            anchors {
                top: top.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }

            clip: true

            ListView {
               id: listView

               anchors {
                   fill: parent
               }
               spacing: 40

               model: NewContactModel {
               }

               delegate: ListItemDelegate {
               }
           }
        }
    }
}
