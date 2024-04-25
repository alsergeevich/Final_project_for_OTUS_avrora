import QtQuick 2.0
import Sailfish.Silica 1.0
import passwordmanager 1.0
//страница для установки пароля для входа и он же используется как ключ шифрования
Page {
    id: passwPage
    objectName: "passwPage"
    allowedOrientations: Orientation.All

    PasswordManager {
        id: passwordManager
    }

    Column {
        width: parent.width
        spacing: Theme.paddingLarge
        PageHeader {
            id: pheader
            title: qsTr("Set a password and remember it")
        }

        TextField {
            id: txtFieldPassw

            placeholderText: qsTr("enter password")
        }

        Button {
            id: btn1
            anchors.horizontalCenter: parent.horizontalCenter
            preferredWidth: Theme.buttonWidthMedium
            text: qsTr("Save")
            enabled: txtFieldPassw.text.length >= 6

            onClicked: {
                 passwordManager.saveEncryptionKey(txtFieldPassw.text)
                 pageStack.push(Qt.resolvedUrl("MainPage.qml"))
            }
        }

    }


}

