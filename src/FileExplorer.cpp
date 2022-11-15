#include "FileExplorer.h"

FileExplorer::FileExplorer(QObject *parent)
    : QObject{parent}
{
    m_file_model = new ListFileModel(this);
}

void FileExplorer::update_model(QString folder_name)
{
    m_file_model->clear();
    if (m_directories.empty())
    {
        m_directories.push("");
        for (const auto& storage_info : QStorageInfo::mountedVolumes())
        {
            FileItem file;
            file.set_is_folder(QFileInfo(storage_info.rootPath()).isDir());
            file.set_name(storage_info.rootPath());
            m_file_model->add_file(file);
        }
    }
    else
    {
        auto current_dir = m_directories.top();
        QString loading_dir;
        if (current_dir.isEmpty() || current_dir.endsWith("/"))
        {
            loading_dir += current_dir;
        }
        else
        {
            loading_dir += ("/" + folder_name);
        }
        m_directories.push(loading_dir);
        QDir dir;
        dir.absoluteFilePath((loading_dir));
        for (const auto& file_info : dir.entryInfoList())
        {
            FileItem file;
            file.set_is_folder(file_info.isDir());
            file.set_name(file_info.fileName());
            m_file_model->add_file(file);
        }
    }
}

QVariant FileExplorer::get_file_model()
{
    return QVariant::fromValue(m_file_model);
}
