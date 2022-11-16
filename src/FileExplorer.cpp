#include "FileExplorer.h"
#include <QDebug>
#ifdef Q_OS_ANDROID
#include <QtAndroid>
#endif

FileExplorer::FileExplorer(QObject *parent)
    : QObject{parent}
{
    m_file_model = new ListFileModel(this);
}

void FileExplorer::update_model(QString folder_name)
{
    if (request_permission("WRITE_EXTERNAL_STORAGE") == false)
    {
        return;
    }
    m_file_model->clear();
    if (m_directories.empty())
    {
        m_directories.push("");
        for (const auto& storage_info : QStorageInfo::mountedVolumes())
        {
            FileItem file;
            file.set_is_folder(QFileInfo(storage_info.rootPath()).isDir());
            file.set_name(storage_info.rootPath());
            file.set_absolute_path(storage_info.rootPath());
            m_file_model->add_file(file);
        }
    }
    else
    {
        auto current_dir = m_directories.top();
        QString loading_dir;
        if (current_dir.isEmpty() || current_dir.endsWith("/"))
        {
            loading_dir += (current_dir + folder_name);
        }
        else
        {
            loading_dir += (current_dir + "/" + folder_name);
        }
        m_directories.push(loading_dir);
        QDirIterator dir_iterator(loading_dir);
        while (dir_iterator.hasNext()) {
            auto dir = dir_iterator.next();
            QFileInfo file(dir);
            if (file.fileName() == "." || file.fileName() == "..")
                continue;
            FileItem file_item;
            file_item.set_is_folder(file.isDir());
            file_item.set_name(file.fileName());
            file_item.set_absolute_path(file.absoluteFilePath());
            m_file_model->add_file(file_item);
        }
    }
    emit current_dir_changed();
}

QVariant FileExplorer::get_file_model()
{
    return QVariant::fromValue(m_file_model);
}

void FileExplorer::back()
{
    if (request_permission("WRITE_EXTERNAL_STORAGE") == false)
    {
        return;
    }
    if (m_directories.size() == 1)
    {
        return;
    }
    m_file_model->clear();
    m_directories.pop();
    auto current_dir = m_directories.top();

    if (current_dir.isEmpty())
    {
        for (const auto& storage_info : QStorageInfo::mountedVolumes())
        {
            FileItem file;
            file.set_is_folder(QFileInfo(storage_info.rootPath()).isDir());
            file.set_name(storage_info.rootPath());
            file.set_absolute_path(storage_info.rootPath());
            m_file_model->add_file(file);
        }
    }
    else
    {
        QDirIterator dir_iterator(current_dir);
        while (dir_iterator.hasNext()) {
            auto dir = dir_iterator.next();
            QFileInfo file(dir);
            if (file.fileName() == "." || file.fileName() == "..")
                continue;
            FileItem file_item;
            file_item.set_is_folder(file.isDir());
            file_item.set_name(file.fileName());
            file_item.set_absolute_path(file.absoluteFilePath());
            m_file_model->add_file(file_item);
        }
    }

    emit current_dir_changed();
}

QString FileExplorer::current_dir()
{
    if (m_directories.empty())
    {
        return "";
    }
    else
    {
        return m_directories.top();
    }
}

bool FileExplorer::request_permission(const QString &permission)
{
#ifdef Q_OS_ANDROID
    QString permission_string = "";
    if (permission == "WRITE_EXTERNAL_STORAGE")
    {
        permission_string = "android.permission.WRITE_EXTERNAL_STORAGE";
    }
    QtAndroid::PermissionResult result = QtAndroid::checkPermission(permission_string);
    if(result == QtAndroid::PermissionResult::Denied){
        QHash<QString, QtAndroid::PermissionResult> resultHash = QtAndroid::requestPermissionsSync(QStringList({permission_string}));
        if(resultHash[permission_string] == QtAndroid::PermissionResult::Denied)
            return false;
    }
    return true;
#else
    Q_UNUSED(permission)
    return true;
#endif
}
