import QtQuick 2.0
import Sailfish.Silica 1.0


//страница для отображения записей и работы с ними


Page {
    id: page
    objectName: "mainPage"
    allowedOrientations: Orientation.All
    property string count_records
    backNavigation: false

        SilicaListView {
            id: noteList
            clip: true
            anchors.top: btn2.bottom
            anchors.margins: 10
            width: parent.width
            spacing: 20
            anchors.bottom: parent.bottom
            model: ListModel {id: listmodel }
            delegate: ListItem {
                anchors.left: parent.left
                anchors.right: parent.right
                height:  150 + (contextmenu.visible ? contextmenu.height : 20)
                anchors.margins: 20
                menu: ContextMenu {
                    id: contextmenu
                    MenuItem {
                        text: qsTr("edit")
                        onClicked: {
                            var dialog = pageStack.push(Qt.resolvedUrl("CreateRecordDialog.qml"))
                            var id = parseInt(rowid)
                            dialog.url = url
                            dialog.login = login
                            dialog.password = passwordManager.getDecriptionPassword(password, passwordManager.getEncryptionKey());
                            dialog.onAccepted.connect(function () { passwordManager.updateRecord(id, dialog.url, dialog.login, dialog.password)})
                        }
                    }
                    MenuItem {
                        text: qsTr("delete")
                        onClicked: {
                            var id = parseInt(rowid)
                            console.log("id = " + id)
                            if(passwordManager.deleteRecord(id)) {
                                console.log("Deleting success")
                            }
                            else {
                                console.log("Error deleting record")
                            }
                        }
                    }
                }


                Rectangle {
                        id: rect
                        color: "transparent" // Прозрачный фон
                        border.color: Theme.secondaryColor
                        border.width: 1
                        radius: 10

                        width: parent.width
                        height: txt1.height * 3 + 20

                        Rectangle {
                                color: "transparent"
                                width: parent.width - 20  // Учитываем отступы
                                 height: parent.height - 20  // Учитываем отступы
                                 anchors.centerIn: parent

                    Column {

                        anchors.left: parent.left
                        anchors.right: parent.right

                        spacing: 1


                        Label {
                            id: txt1

                            text: qsTr("Url:                 ") + url
                            font.pixelSize: Theme.fontSizeMedium
                            color: Theme.primaryColor
                        }

                        Label {
                            id: txt2

                            text: qsTr("Login:            ") + login
                            font.pixelSize: Theme.fontSizeMedium
                            color: Theme.primaryColor

                        }

                        Label {
                            id: txt3

                            text: qsTr("Password:   ") + passwordManager.getDecriptionPassword(password, passwordManager.getEncryptionKey());
                            font.pixelSize: Theme.fontSizeMedium
                            color: Theme.primaryColor

                        }
                    }
                 }
             }

            }


            Connections {
                target: passwordManager
                onModelChanged: {
                    if(txtSearch.length > 0) {
                        readSearch()
                    }
                    else {
                        readAll()
                    }
                }
            }

            VerticalScrollDecorator { }

        }
        PageHeader {
            id: pheader

        }
        SearchField {
                id: txtSearch
                anchors.top: pheader.bottom
                anchors.topMargin: 5
                placeholderText: qsTr("search by login or url")
                onTextChanged: {
                    if(txtSearch.length > 0) {                       
                        readSearch()
                    }
                    else {
                        readAll()
                    }
                }

            }
        IconButton {
            id: btn1
            enabled: txtSearch.length > 0 ? false : true
            anchors.top: txtSearch.bottom
            anchors.left: parent.left
            anchors.topMargin: 5
            icon.source: "qrc:/image/add.png"
            icon.scale: 0.4
            onClicked: {
                var dialog = pageStack.push(Qt.resolvedUrl("CreateRecordDialog.qml"))
                dialog.onAccepted.connect(function () { passwordManager.insertRecord(dialog.url, dialog.login, dialog.password)})
            }
        }

        IconButton {
            id: btn2
            anchors.top: txtSearch.bottom
            anchors.right: parent.right
            anchors.topMargin: 5
            icon.source: "qrc:/image/exit2.png"
            icon.scale: 0.5
            onClicked: {
                var dialog = pageStack.push(Qt.resolvedUrl("MainPage.qml"))

            }
        }

        IconButton {
            id: btn3
            anchors.right: btn2.left
            anchors.rightMargin: 20
            anchors.top: txtSearch.bottom
            anchors.topMargin: 5
            icon.source: "qrc:/image/set.png"
            icon.scale: 0.4
            onClicked: {
                var dialog = pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))

            }
        }

    function readAll() {
        var record = passwordManager.getRecords()
        count_records = String(record.length)
        pheader.title = qsTr("Total records: ") + count_records
        listmodel.clear()
        for(var i = 0; i < record.length; ++i) {
            listmodel.append({"rowid": record[i][0], "url": record[i][1], "login": record[i][2], "password": record[i][3] });
        }
    }

    function readSearch() {
        var record = passwordManager.searchRecords(txtSearch.text)
        count_records = String(record.length)
        pheader.title = qsTr("Records found: ") + count_records
        listmodel.clear()
        for(var i = 0; i < record.length; ++i) {
            listmodel.append({"rowid": record[i][0], "url": record[i][1], "login": record[i][2], "password": record[i][3] });
        }
    }

    Component.onCompleted: {
        readAll()
    }

}


