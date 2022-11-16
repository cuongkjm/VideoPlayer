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

    Video
    {
        id: video_player
        width: parent.width
        height: parent.height - row_buttons.height
        source: ""

        Text
        {
            id: text_status
            visible: video_player.error !== MediaPlayer.NoError
            anchors.centerIn: parent
            text: "Could not load this media file : " + video_player.source
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
