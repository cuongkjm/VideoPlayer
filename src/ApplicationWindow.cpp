#include "ApplicationWindow.h"
#include <QDebug>

ApplicationWindow* ApplicationWindow::m_instance = nullptr;

ApplicationWindow *ApplicationWindow::instance()
{
    if(!m_instance)
    {
        m_instance = new ApplicationWindow();
    }
    return m_instance;
}

void ApplicationWindow::initialize()
{
    m_engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
}

ApplicationWindow::~ApplicationWindow()
{
}

ApplicationWindow::ApplicationWindow(QObject *parent) : QObject(parent)
{

}
