#include "FileItem.h"

FileItem::FileItem()
{

}

void FileItem::set_is_folder(bool is_folder)
{
    m_is_folder = is_folder;
}

bool FileItem::is_folder() const
{
    return m_is_folder;
}

const QString &FileItem::name() const
{
    return m_name;
}

void FileItem::set_name(const QString &name)
{
    m_name = name;
}

const QString &FileItem::absolute_path() const
{
    return m_absolute_path;
}

void FileItem::set_absolute_path(const QString &absolute_path)
{
    m_absolute_path = absolute_path;
}
