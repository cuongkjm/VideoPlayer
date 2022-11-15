#ifndef FILEEXPLORER_H
#define FILEEXPLORER_H

#include <QObject>
#include <QStack>
#include <QStorageInfo>
#include <QFileInfo>
#include <QDir>
#include "ListFileModel.h"

class FileExplorer : public QObject
{
    Q_OBJECT
public:
    explicit FileExplorer(QObject *parent = nullptr);

    Q_INVOKABLE void update_model(QString folder_name);

    Q_INVOKABLE QVariant get_file_model();

private:
    QStack<QString> m_directories;
    ListFileModel* m_file_model = nullptr;
};

#endif // FILEEXPLORER_H
