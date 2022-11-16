import QtQuick 2.15
import QtMultimedia 5.15

Column
{
    property alias video_source: video_player.source
    signal open_video_button_clicked()

    function play()
    {
        video_player.play()
    }

    function pause()
    {
        video_player.pause()
    }

    Rectangle
    {
        id: rectangle_background
        width: parent.width
        height: parent.height - row_buttons.height
        color: "black"
        clip: true

        Video
        {
            id: video_player
            width: parent.width
            height: parent.height
            source: ""
        }

        Text
        {
            id: text_status
            visible: video_player.error !== MediaPlayer.NoError
            anchors.centerIn: parent
            text: "Could not load this media file : " + video_player.source
            color: "white"
        }

        PinchArea
        {
            anchors.fill: parent
            pinch.target: video_player
            pinch.minimumRotation: -360
            pinch.maximumRotation: 360
            pinch.minimumScale: 0.1
            pinch.maximumScale: 10
            pinch.dragAxis: Pinch.XAndYAxis
            property real zRestore: 0
            onSmartZoom: {
                if (pinch.scale > 0) {
                    video_player.rotation = 0;
                    video_player.scale = Math.min(root.width, root.height) / Math.max(animatedimage.sourceSize.width, animatedimage.sourceSize.height) * 0.85
                    zRestore = video_player.z
                    video_player.z = ++root.highestZ;
                } else {
                    video_player.rotation = pinch.previousAngle
                    video_player.scale = pinch.previousScale
                    video_player.x = pinch.previousCenter.x - video_player.width / 2
                    video_player.y = pinch.previousCenter.y - video_player.height / 2
                    video_player.z = zRestore
                    --root.highestZ
                }
            }

            MouseArea {
                id: dragArea
                hoverEnabled: true
                anchors.fill: parent
                drag.target: video_player
                scrollGestureEnabled: true
                onWheel:
                {
                    if (wheel.modifiers & Qt.ControlModifier)
                    {
                        video_player.rotation += wheel.angleDelta.y / 120 * 5;
                        if (Math.abs(video_player.rotation) < 4)
                        {
                            video_player.rotation = 0;
                        }
                    }
                    else
                    {
                        video_player.rotation += wheel.angleDelta.x / 120;
                        if (Math.abs(video_player.rotation) < 0.6)
                        {
                            video_player.rotation = 0;
                        }
                        var scaleBefore = video_player.scale;
                        video_player.scale += video_player.scale * wheel.angleDelta.y / 120 / 10;
                    }
                }
            }
        }
    }

    Row
    {
        id: row_buttons
        height:
        {
            var childrenHeights = []
            for (var i = 0; i < children.length; ++i)
            {
                childrenHeights.push(children[i].height)
            }
            return Math.max(...childrenHeights)
        }

        width: parent.width
        spacing: 5
        Button
        {
            id: button_open_video
            text: "Open Video"
            onClicked: open_video_button_clicked()
        }

        Button
        {
            id: button_play
            text: "Play"
            onClicked: play()
        }

        Button
        {
            id: button_pause
            text: "Pause"
            onClicked: pause()
        }

        Button
        {
            id: button_reset
            text: "Reset"
            onClicked:
            {
                video_player.width = rectangle_background.width
                video_player.height = rectangle_background.height
                video_player.rotation = 0
                video_player.scale = 1
                video_player.x = 0
                video_player.y = 0
            }
        }

        SeekControl
        {
            id: seekcontrol
            width: get_width()
            height: 20
            anchors.verticalCenter: row_buttons.verticalCenter
            duration: video_player.duration
            playing_position: video_player.position

            onSeek:
            {
                video_player.seek(new_position)
            }

            function get_width()
            {
                var child_width = 0;
                for (var i = 0; i < row_buttons.children.length - 1; i++)
                {
                    child_width += row_buttons.children[i].width
                }
                child_width += row_buttons.spacing * row_buttons.children.length - 1
                return (row_buttons.width - child_width)
            }
        }
    }
}
