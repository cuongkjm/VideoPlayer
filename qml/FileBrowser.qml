import QtQuick 2.15
import FileExplorer 1.0

Rectangle
{
    id: file_browser
    signal open_file(string file_path);

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

            ListView
            {
                id: listview_directory
                anchors.fill: parent
                header: Row
                {
                    spacing: 5

                    Button
                    {
                        id: button_cancel
                        text: "Cancel"
                        onClicked: loader.sourceComponent = undefined
                    }
                    Button
                    {
                        id: button_back
                        text: "<"
                        onClicked: file_explorer.back();
                    }
                    Rectangle
                    {
                        width: listview_directory.width - button_back.width
                        height: childrenRect.height
                        Text
                        {
                            id: text_current_dir
                            text: file_explorer.current_dir
                            padding: 20
                        }
                    }
                }

                model: file_explorer.get_file_model()
                delegate: Rectangle
                {
                    width: listview_directory.width
                    height: childrenRect.height
                    color: mousearea.pressed ? "#b5b9bd" : "white"

                    border.color: "gray"

                    Text
                    {
                        text: NAME
                        padding: 20
                    }

                    MouseArea
                    {
                        id: mousearea
                        anchors.fill: parent
                        onClicked:
                        {
                            if (IS_FOLDER)
                            {
                                file_explorer.update_model(NAME)
                            }
                            else
                            {

                            }
                        }
                    }
                }

                Component.onCompleted: file_explorer.update_model("")
            }

            FileExplorer
            {
                id: file_explorer
            }
        }
    }
}
