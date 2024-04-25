#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>

class Backend : public QObject
{
    Q_OBJECT
public:
    explicit Backend(QObject *parent = nullptr);
    ~Backend();
    Q_INVOKABLE QString hash    (const QString& data);                                  //метод для хэширования пароля
    Q_INVOKABLE QString encrypt(const QString& data, const QString& key);  //метод для шифрования пароля перед созранением в БД
    Q_INVOKABLE QString decrypt(const QString& data, const QString& key);  //метод для расшифровки пароля для отображения

};

#endif // BACKEND_H
