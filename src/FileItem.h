#ifndef FILEITEM_H
#define FILEITEM_H

#include <QString>

class FileItem
{
public:
    FileItem();

    void set_is_folder(bool is_folder);
    bool is_folder() const;

    const QString &name() const;
    void set_name(const QString &name);

    const QString &absolute_path() const;
    void set_absolute_path(const QString &newAbsolute_path);

private:
    bool m_is_folder = false;
    QString m_name = "";
    QString m_absolute_path = "";
};

#endif // FILEITEM_H
