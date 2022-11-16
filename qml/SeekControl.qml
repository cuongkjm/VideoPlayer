import QtQuick 2.15

Item
{
    id: seek_control

    property int duration: 0
    property int playing_position: 0

    QtObject
    {
        id: private_properties
        property bool seeking: false
    }

    signal seek(var new_position)

    Rectangle
    {
        id: rectangle_full_bar
        anchors.fill: parent
        radius: height/10
        color: "gray"
    }

    Rectangle
    {
        id: rectangle_progress_bar
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        color: "black"
        radius: rectangle_full_bar.radius
        width: duration == 0 ? 0 : playing_position/duration * rectangle_full_bar.width
    }

    Rectangle
    {
        id: rectangle_progress_handler
        height: rectangle_full_bar.height
        width: height/2
        color: "yellow"
        x: rectangle_progress_bar.width

        MouseArea
        {
            anchors.fill: parent
            drag.target: parent
            drag.axis: Drag.XAxis
            drag.minimumX: 0
            drag.maximumX: rectangle_full_bar.width
            onReleased:
            {
                private_properties.seeking = false
            }
            onPressed:
            {
                private_properties.seeking = true
            }
        }
    }

    Timer
    {
        running: private_properties.seeking
        repeat: true
        interval: 100
        onTriggered:
        {
            var new_position = (rectangle_progress_handler.x/rectangle_full_bar.width) * duration
            seek(new_position)
        }
    }
}
