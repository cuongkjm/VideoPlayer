#ifndef APPLICATIONWINDOW_H
#define APPLICATIONWINDOW_H

#include <QObject>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QThread>

class ApplicationWindow : public QObject
{
    Q_OBJECT
public:
    static ApplicationWindow *instance();
    void initialize();
    QObject *rootObject() const;
    ~ApplicationWindow();

private:
    explicit ApplicationWindow(QObject *parent = nullptr);

    void qml_register_type();

signals:

private:
    static ApplicationWindow *m_instance;

    /*Load main.qml*/
    QQmlApplicationEngine m_engine;

    /* SetProperties*/
    QObject* m_rootObject;
};

#endif // APPLICATIONWINDOW_H
