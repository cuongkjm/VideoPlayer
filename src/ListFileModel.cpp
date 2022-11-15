#include "ListFileModel.h"

ListFileModel::ListFileModel(QObject *parent) : QAbstractListModel{parent}
{

}

void ListFileModel::clear()
{
    if (rowCount() > 0)
    {
        beginResetModel();
        m_files.clear();
        endResetModel();
    }
}

void ListFileModel::add_file(const FileItem &file)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_files << file;
    endInsertRows();
}

int ListFileModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_files.count();
}

QVariant ListFileModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= m_files.count())
        return QVariant();
    const auto& item = m_files[index.row()];
    switch (role)
    {
    case FIR_IS_FOLDER:
        return item.is_folder();
    case FIR_NAME:
        return item.name();
    }
    return QVariant();
}

QHash<int, QByteArray> ListFileModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[FIR_IS_FOLDER] = "IS_FOLDER";
    roles[FIR_NAME] = "NAME";
    return roles;
}
