import QtQuick 2.15

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
                }

                Button
                {
                    id: button_cancel
                    text: "Cancel"
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked: loader.sourceComponent = undefined
                }
            }
        }
    }
}
