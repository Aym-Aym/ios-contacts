import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

TextField {
    id: newContactTextField

    property bool bottomSplitter: false
    property bool topSplitter: false
    property string type: "null"
    property var currentValidator: null

    function formatPhoneNumber(text) {
        if (text !== "") {
            var sanitizedInput = text.replace(/\D/g, '');
            var formattedInput = "";

            for (var i = 0; i < sanitizedInput.length && i < 10; i++) {
                if (i == 0) {
                    formattedInput += "(" + sanitizedInput[i];
                } else if (i == 3) {
                    formattedInput += ") " + sanitizedInput[i];
                } else if (i == 6) {
                    formattedInput += "-" + sanitizedInput[i];
                } else {
                    formattedInput += sanitizedInput[i];
                }
            }

            return formattedInput;
        }
    }

    anchors {
        left: parent.left
        leftMargin: 10
        right: parent.right
    }

    background: Rectangle {
        color: "#00000000"
    }

    placeholderTextColor: "#9E9EA5"
    validator: currentValidator
    maximumLength: 14

    Keys.onReleased: (event)=> {
        if (type == "phone") {
            if (event.key >= Qt.Key_0 && event.key <= Qt.Key_9) {
                text = formatPhoneNumber(text);
            }
        }
    }

    Splitter {
        id: splitterTop

        anchors {
            top: parent.top
            left: parent.left
            leftMargin: 10
            right: parent.right
        }

        visible: topSplitter
    }

    Splitter {
        id: splitterBottom

        anchors {
            bottom: parent.bottom
            left: parent.left
            leftMargin: 10
            right: parent.right
        }

        visible: bottomSplitter
    }
}
