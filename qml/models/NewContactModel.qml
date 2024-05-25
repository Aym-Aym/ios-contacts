import QtQuick 2.15

ListModel {
    id: newContactModel

    ListElement {
        type: "photo"
    }

    ListElement {
        type: "names"
    }

    ListElement {
        type: "add"
        name: "phone"
    }

    ListElement {
        type: "add"
        name: "email"
    }

    ListElement {
        type: "add"
        name: "address"
    }

    ListElement {
        type: "notes"
    }
}
