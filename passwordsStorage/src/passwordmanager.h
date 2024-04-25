#ifndef PASSWORDMANAGER_H
#define PASSWORDMANAGER_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQueryModel>
#include "backend.h"
#include <QAbstractListModel>


class PasswordModel : public QObject
{
    Q_OBJECT

public:
    explicit PasswordModel(QObject *parent = nullptr);
    ~PasswordModel();


    QList<QVariant>& setQuery(QSqlQuery &query); //создаёт модель данных из базы для модели в QML
    void clearModel();                                                //очищает модель

private:
    QList<QVariant> m_data;                                      //модель данных
};



class PasswordManager : public QObject
{
    Q_OBJECT


public:
    explicit PasswordManager(QObject *parent = nullptr);
    ~PasswordManager();

    Q_INVOKABLE bool insertRecord(const QString &url, const QString &login, const QString &password);             //вставка записи в БД
    Q_INVOKABLE bool updateRecord(int id, const QString &url, const QString &login, const QString &password);  //обновление записи в БД
    Q_INVOKABLE bool deleteRecord(int id);                                                                                                           //удаление записи из БД
    Q_INVOKABLE QList<QVariant> getRecords();                                                                                                  //получение всех записей из БД
    Q_INVOKABLE QList<QVariant> searchRecords(const QString &searchTerm);                                                  //поиск в БД
    Q_INVOKABLE bool saveEncryptionKey(const QString &key);                                                                          //сохранение ключа шифрования в БД
    Q_INVOKABLE QString getEncryptionKey();                                                                                                    //извлечение ключа шифрования из БД
    Q_INVOKABLE bool isFirstRun();                                                                                                                      //проверка на момент впервые ли запущено приложение
    Q_INVOKABLE void dropTable();                                                                                                                       //удаление таблиц из БД
    Q_INVOKABLE bool comparePasswords(QString passw);                                                                                 //сравнение введённого пароля и заданного
    Q_INVOKABLE QString getDecriptionPassword(QString password, QString key);                                             //расшифровка пароля для отображения


private:
     QSqlDatabase db;
     void createTables();
     Backend* backend;
     QString dbDirPath;
     QString dbaseName;
     const QString DBNAME = "passwords.db";
     PasswordModel m_model;


signals:
     void modelChanged();                                                                                                                                     //сигнал об изменении модели
};

#endif // PASSWORDMANAGER_H
