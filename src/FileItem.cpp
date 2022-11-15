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
