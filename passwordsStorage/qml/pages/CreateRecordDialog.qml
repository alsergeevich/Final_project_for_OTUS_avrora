import QtQuick 2.0
import Sailfish.Silica 1.0

//страница для создания и редактирования записи
Dialog {
    id: dialogCreate
    allowedOrientations: Orientation.All
    forwardNavigation: txtResurs.length > 0 && txtLogin.length > 0 && txtPassword.length > 0

    property string url
    property string login
    property string password

    Column {
        anchors.fill: parent
        spacing: 5
        DialogHeader {
            acceptText: qsTr("Save")
            cancelText: qsTr("Cancel")
        }

        TextField {
            id: txtResurs
            width: parent.width
            maximumLength: 22
            text: url
            placeholderText: qsTr("resource name")
        }
        TextField {
            id: txtLogin
            width: parent.width
            maximumLength: 22
            text: login
            placeholderText: qsTr("login")
        }
        TextField {
            id: txtPassword
            width: parent.width
            maximumLength: 22
            text: password
            placeholderText: qsTr("password")
        }
    }
    onAccepted: {
        url = txtResurs.text
        login = txtLogin.text
        password = txtPassword.text
    }
}
