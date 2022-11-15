#ifndef LISTFILEMODEL_H
#define LISTFILEMODEL_H

#include <QAbstractListModel>
#include <QList>
#include <QObject>
#include "FileItem.h"

class ListFileModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum FileItemRoles
    {
        FIR_IS_FOLDER = Qt::UserRole + 1,
        FIR_NAME,
    };
    ListFileModel(QObject* parent);

    void clear();
    void add_file(const FileItem& file);

    // QAbstractItemModel interface
public:
    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

protected:
    virtual QHash<int, QByteArray> roleNames() const override;

private:
    QList<FileItem> m_files;
};

#endif // LISTFILEMODEL_H
