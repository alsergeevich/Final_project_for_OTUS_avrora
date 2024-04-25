#include <auroraapp.h>
#include <QtQuick>
#include "passwordmanager.h"
#include <memory>

int main(int argc, char *argv[])
{
    qmlRegisterType<PasswordManager>("passwordmanager", 1, 0, "PasswordManager"); //таким способом на каждой странице будет создаваться экземпляр каждый раз

    QScopedPointer<QGuiApplication> application(Aurora::Application::application(argc, argv));
    application->setOrganizationName(QStringLiteral("ru.home"));
    application->setApplicationName(QStringLiteral("passwordsStorage"));

    auto passwordManager = std::make_shared<PasswordManager>(); //создаём умный указатель на наш класс

    QScopedPointer<QQuickView> view(Aurora::Application::createView());

    view->rootContext()->setContextProperty("passwordManager", passwordManager.get()); //прокидываем указатель на наш класс в QML

    view->setSource(Aurora::Application::pathTo(QStringLiteral("qml/passwordsStorage.qml")));
    view->show();

    return application->exec();
}
