import QtQuick 2.15
import QtMultimedia 5.15

Column
{
    signal open_video_button_clicked()

    Video
    {
        width: parent.width
        height: parent.height - row_buttons.height

        source: "file:///D:\\cuongkjm\\video.mp4"
        autoPlay: true
        rotation: 30
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
        }
    }
}
