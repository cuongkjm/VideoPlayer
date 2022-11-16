import QtQuick 2.15
import QtMultimedia 5.15

Column
{
    property alias video_source: video_player.source
    signal open_video_button_clicked()

    Video
    {
        id: video_player
        width: parent.width
        height: parent.height - row_buttons.height

        source: "file:///E:\\QT\\video.mp4"
    }

    Row
    {
        id: row_buttons
        height: childrenRect.height
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
            onClicked: video_player.play()
        }

        Button
        {
            id: button_pause
            text: "Pause"
            onClicked: video_player.pause()
        }
    }
}
