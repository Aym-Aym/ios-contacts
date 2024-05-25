import QtQuick
import QtQuick.Controls
import Qt.labs.qmlmodels
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import "../models"
import "../components/ViewContact"

Rectangle {
    // set default properties
    property string lastName: ""
    property string firstName: ""
    property string sourcePicture: ""
    property int headerMaxHeight: 270
    property int headerMinHeight: 100
    property var jsonModel: []
    property color titleGradientColor0: darkmode? "#4D4E53": "#BDBEC2"
    property color titleGradientColor1: darkmode? "#272A33": "#A1A4B0"

    implicitWidth: root.width
    implicitHeight: root.height

    color: root.secondaryColor

    // list of contact informations
    ListView {
        id: listView

        anchors.fill: parent

        spacing: 13
        model: jsonModel

        delegate: ListItemDelegate {
        }
    }

    // header
    Rectangle {
        width: parent.width
        height: headerMaxHeight
        y: - listView.contentY < -headerMinHeight? -headerMinHeight: - listView.contentY > 0? 0: - listView.contentY

        gradient: Gradient {
            GradientStop {
                position: 0; color: titleGradientColor0
            }

            GradientStop {
                position: 1; color: titleGradientColor1
            }
        }

        Rectangle {
            id: circleInitials

            width: - listView.contentY < -headerMinHeight? 40: 90
            height: - listView.contentY < -headerMinHeight? 40: 90

            anchors {
                top: parent.top
                topMargin: - listView.contentY < -headerMinHeight? 118: 50
                horizontalCenter: parent.horizontalCenter
            }

            radius: - listView.contentY < -headerMinHeight? 20: 45
            gradient: Gradient {
                GradientStop {
                    position: 0; color: sourcePicture? "#00000000": root.darkmode? "#A6ACBA": "#A5ABB9"
                }

                GradientStop {
                    position: 1; color: sourcePicture? "#00000000":  root.darkmode? "#848893": "#858994"
                }
            }

            Text {
                anchors.centerIn: parent
                text: `${firstName.charAt(0)}${lastName.charAt(0)}`
                color: "#FFF"
                font.pointSize: - listView.contentY < -headerMinHeight? 12: 40
            }

            Image {
                id: picture
                source: sourcePicture
                width: parent.width
                height: parent.height
                containmentMask: circleInitials
                visible: false
            }

            Image {
                id: mask
                anchors.fill: parent
                source: "../../assets/images/circle.fill.svg"
                visible: false
            }

            OpacityMask {
                anchors.fill: parent
                source: picture
                maskSource: mask
            }
        }

        Text {
            anchors {
                top: circleInitials.bottom
                topMargin: - listView.contentY < -headerMinHeight? 6: 10
                horizontalCenter: parent.horizontalCenter
            }
            text: `${firstName} ${lastName}`
            font.pointSize: - listView.contentY < -headerMinHeight? 15: 30
            color: "#FFF"
        }

        RowLayout {
            id: menu
            height: childrenRect.height

            anchors {
                left: parent.left
                leftMargin: 10
                right: parent.right
                rightMargin: 10
                bottom: parent.bottom
                bottomMargin: 15
            }

            spacing: 10

            Rectangle {
                Layout.fillWidth: true
                height: 52
                radius: 8

                gradient: Gradient {
                    GradientStop {
                        position: 0; color: root.darkmode? "#3F414D": "#808394"
                    }

                    GradientStop {
                        position: 1; color: root.darkmode? "#373A41": "#808394"
                    }
                }

                Item {
                    anchors.centerIn: parent
                    implicitWidth: 70
                    implicitHeight: childrenRect.height

                    Image {
                        id: messageLogo

                        width: 20
                        height: 19
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "../../assets/images/message.fill.svg"
                    }

                    Text {
                        id: messageText

                        anchors {
                            top: messageLogo.bottom
                            topMargin: 3
                            horizontalCenter: parent.horizontalCenter
                        }
                        color: "#FFF"
                        text: "message"
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                height: 52
                radius: 8

                gradient: Gradient {
                    GradientStop {
                        position: 0; color: root.darkmode? "#3F414D": "#808394"
                    }

                    GradientStop {
                        position: 1; color: root.darkmode? "#373A41": "#808394"
                    }
                }

                Item {
                    anchors.centerIn: parent
                    implicitWidth: 70
                    implicitHeight: childrenRect.height

                    Image {
                        id: callLogo

                        width: 20
                        height: 19
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "../../assets/images/phone.fill.svg"
                    }

                    Text {
                        anchors {
                            top: callLogo.bottom
                            topMargin: 3
                            horizontalCenter: parent.horizontalCenter
                        }
                        color: "#FFF"
                        text: "call"
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                height: 52

                radius: 8

                gradient: Gradient {
                    GradientStop {
                        position: 0; color: root.darkmode? "#3F414D": "#808394"
                    }

                    GradientStop {
                        position: 1; color: root.darkmode? "#373A41": "#808394"
                    }
                }

                Item {
                    anchors.centerIn: parent
                    implicitWidth: 70
                    implicitHeight: childrenRect.height
                    anchors.verticalCenter: parent.verticalCenter

                    Image {
                        id: videoLogo

                        width: 22
                        height: 15
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "../../assets/images/video.fill.svg"
                        opacity: 0.4
                    }

                    Text {
                        anchors {
                            top: videoLogo.bottom
                            topMargin: 3
                            horizontalCenter: parent.horizontalCenter
                        }
                        color: "#FFF"
                        text: "video"
                        opacity: 0.4
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                height: 52
                radius: 8

                gradient: Gradient {
                    GradientStop {
                        position: 0; color: root.darkmode? "#3F414D": "#808394"
                    }

                    GradientStop {
                        position: 1; color: root.darkmode? "#373A41": "#808394"
                    }
                }

                Item {
                    anchors.centerIn: parent
                    implicitWidth: 70
                    implicitHeight: childrenRect.height

                    Image {
                        id: mailLogo

                        width: 20
                        height: 15
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "../../assets/images/envelope.fill.svg"
                    }

                    Text {
                        anchors {
                            top: mailLogo.bottom
                            topMargin: 3
                            horizontalCenter: parent.horizontalCenter
                        }
                        color: "#FFF"
                        text: "mail"
                    }
                }
            }
        }
    }

    // top buttons
    RoundButton {
        anchors {
            left: parent.left
            leftMargin: 10
            top: parent.top
            topMargin: 20
        }

        height: 30
        width: 30

        background: Rectangle {
            anchors.fill: parent
            radius: 15
            color: "#10FFFFFF"
        }


        text: "<"

        onClicked: {
            stackView.pop()
        }
        z: 2
    }

    RoundButton {
        anchors {
            right: parent.right
            rightMargin: 10
            top: parent.top
            topMargin: 20
        }

        implicitHeight: 30
        width: 60

        background: Rectangle {
            anchors.fill: parent
            radius: 15
            color: "#10FFFFFF"
        }


        text: "Edit"

        onClicked: {
        }
        z: 2
    }
}
