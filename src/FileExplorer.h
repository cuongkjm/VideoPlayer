#ifndef FILEEXPLORER_H
#define FILEEXPLORER_H

#include <QObject>
#include <QStack>
#include <QStorageInfo>
#include <QFileInfo>
#include <QDir>
#include <QDirIterator>
#include "ListFileModel.h"

class FileExplorer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString current_dir READ current_dir NOTIFY current_dir_changed)
public:
    explicit FileExplorer(QObject *parent = nullptr);

    Q_INVOKABLE void update_model(QString folder_name);
    Q_INVOKABLE QVariant get_file_model();
    Q_INVOKABLE void back();

    QString current_dir();

signals:
    void current_dir_changed();

private:
    QStack<QString> m_directories;
    ListFileModel* m_file_model = nullptr;
};

#endif // FILEEXPLORER_H
