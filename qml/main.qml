import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 1280
    height: 720
    visible: true

    ScreenPlayVideo
    {
        id: screen_play_video
        anchors.fill: parent

        onOpen_video_button_clicked:
        {
            file_browser.show()
        }
    }

    FileBrowser
    {
        id: file_browser
        anchors.fill: parent
    }
}
