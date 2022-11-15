import QtQuick 2.15
import FileExplorer 1.0

Rectangle
{
    color: "transparent"

    function show()
    {
        loader.sourceComponent = component_file_browser
    }

    Loader
    {
        id: loader
        anchors.fill: parent
    }

    Component
    {
        id: component_file_browser
        Rectangle
        {
            id: rectangle_background
            anchors.fill: parent

            Column
            {
                anchors.fill: parent
                spacing: 5

                ListView
                {
                    width: parent.width
                    height: parent.height - button_cancel.height
                    model: file_explorer.get_file_model()
                    delegate: Rectangle
                    {
                        width: childrenRect.height
                        height: childrenRect.width

                        Text
                        {
                            text: NAME
                            padding: 20

                            MouseArea
                            {
                                anchors.fill: parent
                                onClicked:
                                {
                                    if (IS_FOLDER)
                                    {
                                        file_explorer.update_model(NAME)
                                    }
                                }
                            }
                        }
                    }

                    Component.onCompleted: file_explorer.update_model("")
                }

                Button
                {
                    id: button_cancel
                    text: "Cancel"
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked: loader.sourceComponent = undefined
                }
            }

            FileExplorer
            {
                id: file_explorer
            }
        }
    }
}
