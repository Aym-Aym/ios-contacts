import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Basic
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15

import "../components/ContactList"
import "../components/customs"
import "../models"

Item {
    id: contactListPages

    // set default properties
    property int maxHeaderHeight: 30
    property double headerHeight: textFieldActive? 0: maxHeaderHeight - contentY
    property double contentY: listView.contentY < 0? 0: listView.contentY > maxHeaderHeight? maxHeaderHeight: listView.contentY
    property color topColor: root.color
    property bool textFieldActive: false
    property double listViewContentY: 0

    // properties animations
    states: [
        State {
            name: "scroll_off"
            when: listView.contentY < maxHeaderHeight + 5

            PropertyChanges {
                target: contactListPages
                topColor: root.mainColor
            }
        },
        State {
            name: "light_scroll_on"
            when: !root.darkmode && listView.contentY >= maxHeaderHeight + 5

            PropertyChanges {
                target: contactListPages
                topColor: "#F2F2F6"
            }
        },
        State {
            name: "dark_scroll_on"
            when: root.darkmode && listView.contentY >= maxHeaderHeight + 5

            PropertyChanges {
                target: contactListPages
                topColor: "#121213"
            }
        }
    ]

    transitions: [
        Transition {
            ColorAnimation {
                target: contactListPages
                properties: "topColor"
                duration: 150
            }
        }
    ]

    // contact list page
    Item {
        id: contactListPage

        property color pageColor: root.mainColor

        width: root.width
        height: root.height

        // top title
        Rectangle {
            id: topTitle

            states: [
                State {
                    name: "search_on"
                    when: textFieldActive === true

                    PropertyChanges {
                        target: topTitle
                        opacity: 0
                    }

                    PropertyChanges {
                        target: topTitle
                        height: 0
                    }
                },
                State {
                    name: "search_off"
                    when: textFieldActive === false

                    PropertyChanges {
                        target: topTitle
                        opacity: 1
                    }

                    PropertyChanges {
                        target: topTitle
                        height: 30
                    }
                }
            ]

            transitions: [
                Transition {
                    NumberAnimation {
                        target: topTitle
                        properties: "opacity"
                        duration: 150
                    }

                    NumberAnimation {
                        target: topTitle
                        properties: "height"
                        duration: 150
                    }
                }
            ]

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
            height: 30

            color: contactListPages.topColor

            Behavior on height {
                NumberAnimation {
                    properties: "height"
                    duration: 100
                }
            }

            Text {
                id: topTitleText

                anchors{
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }

                text: "Contacts"
                color: root.mainTextColor
                font.weight: Font.Bold
                opacity: 0

                states: [
                    State {
                        name: "off"
                        when: listView < maxHeaderHeight - 6

                        PropertyChanges {
                            target: topTitleText
                            opacity: 0
                        }
                    },
                    State {
                        name: "on"
                        when: listView.contentY >= maxHeaderHeight - 6

                        PropertyChanges {
                            target: topTitleText
                            opacity: 1
                        }
                    }
                ]

                transitions: Transition {
                    NumberAnimation {
                        properties: "opacity"
                        duration: 150
                    }
                }
            }

            RoundButton {
                anchors {
                    right: parent.right
                    rightMargin: 10
                    verticalCenter: parent.verticalCenter
                }

                contentItem: Text {
                        text: "+"
                        color: "#007AFF"
                        font {
                            pointSize: 30
                            weight: Font.Light
                        }
                    }

                background: Rectangle {
                    color: "#00000000"
                }

                onReleased: {
                    readSignal.search_signal("_")
                    newContactPopup.open()
                }
            }
        }

        Rectangle {
            id: contactTitle

            states: [
                State {
                    name: "search_on"
                    when: textFieldActive === true

                    PropertyChanges {
                        target: contactTitle
                        opacity: 0
                    }
                },
                State {
                    name: "search_off"
                    when: textFieldActive === false

                    PropertyChanges {
                        target: contactTitle
                        opacity: 1
                    }
                }
            ]

            transitions: [
                Transition {
                    NumberAnimation {
                        target: contactTitle
                        properties: "opacity"
                        duration: 50
                    }
                    NumberAnimation {
                        target: contactTitle
                        properties: "height"
                        duration: 150
                    }
                }
            ]

            anchors {
                top: topTitle.bottom
                left: parent.left
                right: parent.right
            }
            height: headerHeight

            Behavior on height {
                NumberAnimation {
                    properties: "height"
                    duration: 100
                }
            }

            clip: true

            color: contactListPages.topColor

            Text {
                anchors {
                    bottom: parent.bottom
                    left: parent.left
                    leftMargin: 15
                }

                font {
                    pointSize: 30
                    weight: Font.Bold
                }
                color: root.darkmode? "#FFF": "#000"
                text: "Contacts"
            }
        }

        // search bar
        Rectangle {
            id: searchField

            states: [
                State {
                    name: "search_on"
                    when: textFieldActive === true

                    PropertyChanges {
                        target: cancelSearchBtn
                        opacity: 1
                    }
                    PropertyChanges {
                        target: textfield
                        anchors.rightMargin: 70
                    }
                },
                State {
                    name: "search_off"
                    when: textFieldActive === false

                    PropertyChanges {
                        target: cancelSearchBtn
                        opacity: 0
                    }
                    PropertyChanges {
                        target: textfield
                        anchors.rightMargin: 15
                    }
                }
            ]

            transitions: [
                Transition {
                    NumberAnimation {
                        target: cancelSearchBtn
                        properties: "opacity"
                        duration: 50
                    }
                    NumberAnimation {
                        target: textfield
                        properties: "anchors.rightMargin"
                        duration: 150
                    }
                }
            ]

            anchors {
                top: contactTitle.bottom
                left: parent.left
                right: parent.right
            }

            implicitHeight: childrenRect.height + 10

            color: contactListPages.topColor

            SearchTextField {
                id: textfield

                leftPadding: 30
                anchors {
                    left: parent.left
                    leftMargin: 15
                    right: parent.right
                    rightMargin: 15
                    top: parent.top
                    topMargin: 10
                }

                onActiveFocusChanged: {
                    textFieldActive = true
                }

                Keys.onReleased: {
                    readSignal.search_signal(textfield.text)
                }
            }

            Button {
                id: cancelSearchBtn

                anchors {
                    right: parent.right
                    rightMargin: 8
                    verticalCenter: textfield.verticalCenter
                }

                contentItem: Text {
                    text: "Cancel"
                    color: root.mainButtonColor
                }

                background: Rectangle {
                    color: "#00000000"
                }

                opacity: 0

                onReleased: {
                    textfield.focus = false
                    textFieldActive = false
                    textfield.text = ""
                    readSignal.search_signal(textfield.text)
                }
            }

            Rectangle {
                id: searchFieledSplitter
                height: 1

                anchors {
                    left: parent.left
                    leftMargin: listView.contentY > 30? 0: 15
                    right: parent.right
                    rightMargin: listView.contentY > 30? 0: 15
                    top: textfield.bottom
                    topMargin: 10
                }

                color: root.splitterColor
            }
        }

        // contact list
        ListView {
            id: listView

            anchors {
                left: parent.left
                top: searchField.bottom
                right: parent.right
                bottom: parent.bottom
            }

            clip: true
            model: contactsModel
            delegate: ListItemDelegate {
                firstName: modelData.firstname
                lastName: modelData.lastname
                height: 25

                onDeleteClicked: {
                    listView.model.remove(index)
                }

                onOpened: {
                    let updated_contact_info = modelData.contact_infos
                    let spacer1 = {
                        "type": "spacer",
                        "spacerHeight": 270
                    }
                    let button1 = {
                        "type": "button",
                        "data": {
                            "button1": "Send Message",
                            "button2": "Share Contact",
                            "button3": "Add to Favorites"
                        }
                    }
                    let button2 = {
                        "type": "button",
                        "data": {
                            "button1": "Add to Emergency Contacts"
                        }
                    }
                    let button3 = {
                        "type": "button",
                        "data": {
                            "button1": "Block Caller"
                        }
                    }
                    let spacer2 = {
                        "type": "spacer",
                        "spacerHeight": 0
                    }
                    let index1 = 0

                    updated_contact_info.splice(index1, 0, spacer1)
                    updated_contact_info.push(button1, button2, button3, spacer2)

                    stackView.push(
                        Qt.resolvedUrl("ViewContact.qml"),
                        {
                            "firstName": modelData.firstname,
                            "lastName": modelData.lastname,
                            "sourcePicture": modelData.picture,
                            "jsonModel": updated_contact_info
                        }
                    )
                }
            }

            section.delegate: SectionDelegate {}
            section.property: "lastname"
            section.criteria: ViewSection.FirstCharacter
            section.labelPositioning: ViewSection.InlineLabels + ViewSection.CurrentLabelAtStart
        }
    }

    // new contact page
    NewContact {
        id: newContactPopup

        property int windowY: 30

        // page transition animation
        enter:  Transition {
            NumberAnimation {
                property: "y"; from: height - newContactPopup.windowY; to: newContactPopup.windowY; duration: 150;
            }
            NumberAnimation {
                target: contactListPage; property: "scale"; from: 1; to: 0.93; duration: 150;
            }
            NumberAnimation {
                target: topTitle; property: "radius"; from: 0; to: 8; duration: 50;
            }
            ColorAnimation {
                target: contactListPages; property: "topColor"; from: "#00000000"; to: "#141416"; duration: 150;
            }
        }

        exit: Transition {
            NumberAnimation {
                property: "y"; from: newContactPopup.windowY; to: height - newContactPopup.windowY; duration: 50;
            }
            NumberAnimation {
                target: contactListPage; property: "scale"; from: 0.93; to: 1; duration: 50;
            }
            NumberAnimation {
                target: topTitle; property: "radius"; from: 8; to: 0; duration: 50;
            }
            ColorAnimation {
                target: contactListPages; property: "topColor"; from: "#141416"; to: "#00000000"; duration: 100;
            }
        }

        onClosed: {
            readSignal.search_signal("")
        }
    }
}
