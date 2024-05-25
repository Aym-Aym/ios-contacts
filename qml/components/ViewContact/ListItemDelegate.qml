import QtQuick 2.15
import Qt.labs.qmlmodels

DelegateChooser {
    role: "type"

    property color containerBgColor: root.darkmode? "#1C1C1E": "#FFF"

    DelegateChoice {
        roleValue: "contact"

        Rectangle {
            id: contactDelegate

            property int dictSize: Object.keys(modelData.data).length

            width: root.width - 20
            x: 10
            height: childrenRect.height
            radius: 5
            color: index == 0? "#00000000": containerBgColor

            Column {
                padding: 5

                Repeater {
                    model: dictSize

                    Column {
                        required property int index

                        leftPadding: 10

                        Rectangle {
                            color: "#00000000"
                            width: contactDelegate.width - 15
                            height: 10
                            visible: index == 0? 0: 1

                            Rectangle {
                                color: root.splitterColor
                                height: 1
                                width: parent.width
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        Text {
                            text: Object.keys(modelData.data)[index]
                            color: root.mainTextColor
                            height: 20
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: Object.values(modelData.data)[index]
                            color: "#0B83FF"
                            height: 20
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }
        }
    }

    // Address delegate
    DelegateChoice {
        roleValue: "address"

        Rectangle {
            id: addressDelegate

            property int dictSize: Object.keys(modelData.data).length

            width: root.width - 20
            x: 10
            height: childrenRect.height
            radius: 5
            color: index == 0? "#00000000": containerBgColor

            Column {
                padding: 10

                Repeater {
                    model: dictSize

                    Column {
                        required property int index

                        function formatAddress(address) {
                            var address_list = address.split(", ")

                            return `${address_list[0]}\n${address_list.slice(1, address_list.length - 1).join(" ")}\n${address_list[address_list.length - 1]}`
                        }

                        leftPadding: 5
                        spacing: 7

                        Text {
                            text: Object.keys(modelData.data)[index]
                            color: root.mainTextColor
                        }

                        Text {
                            text: formatAddress(Object.values(modelData.data)[index])
                            color: root.mainTextColor
                        }
                    }
                }
            }
        }
    }

    // Other delegate
    DelegateChoice {
        roleValue: "other"

        Rectangle {
            id: otherDelegate

            property int dictSize: Object.keys(modelData.data).length

            width: root.width - 20
            x: 10
            height: childrenRect.height
            radius: 5
            color: index == 0? "#00000000": containerBgColor


            Column {
                padding: 10

                Repeater {
                    model: dictSize

                    Column {
                        required property int index

                        leftPadding: 5
                        spacing: 5

                        Rectangle {
                            color: root.splitterColor
                            height: 1
                            width: otherDelegate.width - 15
                            visible: index == 0? 0: 1
                        }

                        Text {
                            text: Object.keys(modelData.data)[index]
                            color: root.mainTextColor
                            height: 20
                            verticalAlignment: Text.AlignVCenter
                        }

                        Text {
                            text: Object.values(modelData.data)[index]
                            color: root.mainTextColor
                        }
                    }
                }
            }
        }
    }

    // Button delegate
    DelegateChoice {
        roleValue: "button"

        Rectangle {
            id: buttonDelegate

            property int dictSize: Object.keys(modelData.data).length

            width: root.width - 20
            x: 10
            height: childrenRect.height
            radius: 5
            color: index == 0? "#00000000": containerBgColor

            Column {
                padding: 5

                Repeater {
                    model: dictSize

                    Column {
                        required property int index

                        leftPadding: 10

                        Rectangle {
                            color: "#00000000"
                            width: buttonDelegate.width - 15
                            height: 10
                            visible: index == 0? 0: 1

                            Rectangle {
                                color: root.splitterColor
                                height: 1
                                width: parent.width
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        Text {
                            property string value: Object.values(modelData.data)[index]

                            text: value
                            color: value == "Block Caller"? "#FF0000": "#0B83FF"
                            height: 20
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }
        }
    }

    // Spacer delegate
    DelegateChoice {
        roleValue: "spacer"

        Rectangle {
            height: modelData.spacerHeight
        }
    }
}
