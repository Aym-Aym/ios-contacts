import QtQuick
import QtQuick.Controls 2.15

Item {
    id: listItemDelegate

    // set default properties
    property string firstName: "John"
    property string lastName: "Doe"

    property int deleteMinimum: 0
    property int deleteMaximum: 100
    property int deleteMinimumSnap: 40
    property int deleteMaximumSnap: 60

    signal deleteClicked
    signal opened

    width: parent ? parent.width : 0
    height: 50

    RoundButton {
        id: deleteButton

        implicitWidth: parent.width
        implicitHeight: parent.height - 2
        y: 1

        anchors.left: parent.left

        background: Rectangle {
            color: "#ff0000"
        }

        Text {
            text: qsTr("Delete")
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.verticalCenter: parent.verticalCenter
            color: "#fff"
        }

        onClicked: {
            deleteClicked()
        }
    }

    Rectangle {
        id: slider

        implicitWidth: listItemDelegate.width
        implicitHeight: listItemDelegate.height
        color: root.color

        RoundButton {
            anchors.fill: parent

            contentItem: Item {
                Text {
                    id: firstNameText
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    text: qsTr(listItemDelegate.firstName)
                    color: root.mainTextColor
                }

                Text {
                    anchors.left: firstNameText.right
                    anchors.leftMargin: 5
                    font.weight: Font.Bold
                    text: qsTr(listItemDelegate.lastName)
                    color: root.mainTextColor
                }
            }

            background: Rectangle {
                anchors.fill: parent
                color: root.mainColor
            }

            onClicked: {
                opened()
            }
        }

        DragHandler {
            property real old_value: 0
            property string direction: "none"

            yAxis.enabled: false
            xAxis.minimum: listItemDelegate.deleteMinimum

            xAxis.onActiveValueChanged: {
                if (old_value > parent.x) {
                    direction = "left"
                } else if (old_value < parent.x) {
                    direction = "right"
                }

                old_value = parent.x
            }

            onActiveChanged: {
                if (!active && direction == "left"
                        && parent.x < listItemDelegate.deleteMaximumSnap) {
                    parent.x = listItemDelegate.deleteMinimum
                } else if (!active && direction == "left"
                           && parent.x >= listItemDelegate.deleteMaximumSnap) {
                    parent.x = listItemDelegate.deleteMaximum
                } else if (!active && direction == "right"
                           && parent.x > listItemDelegate.deleteMinimumSnap) {
                    parent.x = listItemDelegate.deleteMaximum
                } else if (!active && direction == "right"
                           && parent.x <= listItemDelegate.deleteMinimumSnap) {
                    parent.x = listItemDelegate.deleteMinimum
                }
            }
        }
    }

    Rectangle {
        anchors.top: slider.top
        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.right: parent.right
        anchors.rightMargin: 15

        height: 1
        color: root.splitterColor
    }
}
