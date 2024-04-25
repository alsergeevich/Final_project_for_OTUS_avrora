import QtQuick 2.0
import Sailfish.Silica 1.0

//страница входа

Page {
    id: mainPage
    objectName: "mainPage"
    allowedOrientations: Orientation.All
    backNavigation: false    

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        spacing: Theme.paddingLarge
        PageHeader {
            id: pheader
            title: qsTr("Vault entrance")
        }

        PasswordField {
            id: txtfield
            showEchoModeToggle: true
            placeholderText: qsTr("enter password")
        }

        Label {
            id: lblError
            anchors.horizontalCenter: parent.horizontalCenter
            height: txtfield.height
            font.pixelSize: Theme.fontSizeLarge
            color: "red"
            text: ""
        }
        Button {
            id: btn
            anchors.horizontalCenter: parent.horizontalCenter
            preferredWidth: Theme.buttonWidthMedium
            text: qsTr("sign in")

            onClicked: {

                if(passwordManager.comparePasswords(txtfield.text)) {
                    lblError.text = ""
                    pageStack.push(Qt.resolvedUrl("ListNotesPage.qml"))
                }
                else {
                    lblError.text = qsTr("Incorrect password")
                }
            }
        }
    }
}
