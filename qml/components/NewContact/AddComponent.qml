import QtQuick
import QtQuick.Controls

import "../customs"

Rectangle {
    id: confirmDeletion

    width: root.width
    height: 40

    color: "#00000000"

    RoundButton {
        id: deleteButton

        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
        }

        width: 80

        background: Rectangle {
            color: "#00000000"
        }

        contentItem: Text {
            anchors {
                right: parent.right
            }

            text: "Delete"
            color: mainTextColor
        }

        visible: false
    }

    Rectangle {
        id: addComponent

        property bool minus: index > 0? true: false
        property bool addEnabled: true

        width: root.width
        height: 40

        color: "#2C2C2E"

        RoundButton {
            id: button

            anchors {
                left: parent.left
                leftMargin: 20
                verticalCenter: parent.verticalCenter
            }

            width: 20
            height: 20

            radius: 10

            background: Image {
                source: addComponent.minus? "../../../assets/images/minus.circle.fill.svg": parent.enabled? "../../../assets/images/plus.circle.fill.enabled.svg": "../../../assets/images/plus.circle.fill.disabled.svg"
            }

            enabled: addComponent.addEnabled

            onReleased: {
                console.log(index)
                if (index == 0) {
                    addListView.model.insert(1, { name: "" })
                }
                else {
                    // addListView.model.remove(index)
                    addComponent.x = -80
                    confirmDeletion.color = "#FF0000"
                    deleteButton.visible = true
                }
            }
        }

        Text {
            anchors {
                left: button.right
                leftMargin: 17
                verticalCenter: parent.verticalCenter
            }
            color: mainTextColor
            text: "add phone" + index

            visible: index == 0? true: false
        }

        RoundButton {
            id: selectButton

            anchors {
                left: button.right
                leftMargin: 10
                verticalCenter: parent.verticalCenter
            }

            contentItem: Text {
                color: "#007AFF"
                text: "mobile"
            }

            background: Rectangle {
                color: "#00000000"
            }

            visible: index > 0? true: false
        }

        Splitter {
            width: 0.5
            height: 0

            anchors {
                top: parent.top
                bottom: parent.bottom
                left: selectButton.right
            }

            visible: index > 0? true: false
        }

        NewContactTextField {
            type: "phone"
            validator: IntValidator {}

            anchors {
                left: selectButton.right
                // leftMargin: 15
                verticalCenter: parent.verticalCenter
            }

            placeholderText: "Phone " + index

            visible: index > 0? true: false
        }

        Splitter {
            anchors {
                left: parent.left
                leftMargin: 56
                right: parent.right
                bottom: parent.bottom
            }

            visible: index > 0? true: false
        }
    }
}
