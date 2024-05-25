import QtQuick
import Qt.labs.qmlmodels

DelegateChooser {
    role: "type"

    DelegateChoice {
        roleValue: "Rectangle"; Rectangle {
            id: rectangle

            property int elementIndex: index

            // anchors {
            //     left: parent.left
            //     leftMargin: 20
            //     right: parent.right
            //     rightMargin: 20
            // }

            width: window.width
            anchors.leftMargin: 20
            height: childrenRect.height
            color: model.color

            radius: 5

            property int dict_size: Object.keys(model.array).length

            Column {
                Repeater {
                    model: dict_size

                    Column {

                        required property int index

                        Rectangle {
                            color: "#FFFFFF"
                            height: 1
                            width: rectangle.width
                            visible: index == 0? 0: 1
                        }

                        Text {
                            property string value: Object.values(model.array)[index]
                            text: value
                        }

                    }
                }
            }
        }
    }

    DelegateChoice {
        roleValue: "Text"; Text {
            text: model.array.ok
        }
    }

    DelegateChoice {
        roleValue: "Spacer"; Rectangle {
            height: 100
        }
    }
}
