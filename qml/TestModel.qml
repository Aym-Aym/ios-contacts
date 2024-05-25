import QtQuick

ListModel {
    // id: testModel
    // dynamicRoles: true // Set dynamicRoles to true

    Component.onCompleted: {
        for (var i = 0; i < jsonObject.length; ++i) {
            append(jsonObject[i]);
        }
    }
}
