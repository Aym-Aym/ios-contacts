import QtQuick
import QtQuick.Controls
import Qt.labs.qmlmodels
import Qt5Compat.GraphicalEffects

import "../customs/"

DelegateChooser {
    role: "type"

    DelegateChoice {
        roleValue: "add"

        Rectangle {
            anchors {
                left: parent.left
                right: parent.right
            }

            implicitHeight: childrenRect.height

            color: "#2C2C2E"

            Rectangle {
                id: addSplitterTop

                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
                height: 0.5

                color: "#444349"
            }

            ListView {
                id: addListView

                anchors {
                    left: parent.left
                    right: parent.right
                }

                height: contentHeight

                add: Transition {
                    NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 1000 }
                }

                // displaced: Transition {
                //     NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 1000 }
                // }

                // addDisplaced:  Transition {
                //     NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 1000 }
                // }

                model: ListModel {
                           id: myModel
                           ListElement { name: "" }
                       }

                verticalLayoutDirection: ListView.BottomToTop
                interactive: false

                delegate: AddComponent {

                }
            }

            Rectangle {
                id: addSplitterBottom

                anchors {
                    bottom: addListView.bottom
                    left: parent.left
                    right: parent.right
                }
                height: 0.5

                color: "#444349"
            }
        }
    }

    DelegateChoice {
        roleValue: "names"

        Rectangle {
            anchors {
                left: parent.left
                right: parent.right
            }

            implicitHeight: childrenRect.height

            color: "#2C2C2E"

            Splitter {
                id: splitterTop

                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
                height: 0.5
            }

            NewContactTextField {
                id: firstname

                height: 40
                placeholderText: "First name"
                bottomSplitter: true
            }

            NewContactTextField {
                id: lasttname

                anchors.top: firstname.bottom
                height: 40
                placeholderText: "Last name"
            }

            Splitter {
                id: splitterBottom

                anchors {
                    bottom: lasttname.bottom
                    left: parent.left
                    right: parent.right
                }
                height: 0.5
            }
        }
    }

    DelegateChoice {
        roleValue: "photo"

        Item {
            width: root.width
            height: childrenRect.height

            Rectangle {
                id: circleInitials

                width: 100
                height: 100

                anchors {
                    top: parent.top
                    topMargin: 20
                    horizontalCenter: parent.horizontalCenter
                }

                radius: 50
                gradient: Gradient {
                    GradientStop {
                        position: 0; color: ""? "#00000000": root.darkmode? "#A6ACBA": "#A5ABB9"
                    }

                    GradientStop {
                        position: 1; color: ""? "#00000000":  root.darkmode? "#848893": "#858994"
                    }
                }

                // Text {
                //     anchors.centerIn: parent
                //     text: `${firstName.charAt(0)}${lastName.charAt(0)}`
                //     color: "#FFF"
                //     font.pointSize: - listView.contentY < -headerMinHeight? 12: 40
                // }
            }

            Item {
                id: charLogo

                anchors {
                    top: parent.top
                    topMargin: 20
                    horizontalCenter: parent.horizontalCenter
                }
                width: 100
                height: 100

                Image {
                    anchors {
                        top: parent.top
                        topMargin: 1
                        horizontalCenter: parent.horizontalCenter
                    }

                    width: 98
                    height: 98

                    source: "../../../assets/images/circle.fill.svg"
                }

                LinearGradient {
                    anchors.fill: picture
                    source: picture

                    gradient: Gradient {
                        GradientStop {
                            position: 0; color: ""? "#00000000": root.darkmode? "#A6ACBA": "#A5ABB9"
                        }

                        GradientStop {
                            position: 1; color: ""? "#00000000":  root.darkmode? "#848893": "#858994"
                        }
                    }

                }

                Image {
                    id: picture
                    anchors.fill: parent

                    source: "../../../assets/images/person.crop.circle.fill.svg"
                    visible: false
                }
            }

            RoundButton {
                anchors {
                    top: charLogo.bottom
                    topMargin: 10
                    horizontalCenter: parent.horizontalCenter
                }

                background: Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 100
                    radius: 20
                    color: "#313035"
                }

                contentItem: Text {
                    text: "Add Photo"
                    font.weight: Font.Bold
                    color: root.mainTextColor
                }
            }
        }
    }

    DelegateChoice {
        roleValue: "notes"

        Text {
            text: "notes"
        }
    }
}
