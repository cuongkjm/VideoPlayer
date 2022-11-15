import QtQuick 2.15
import QtQuick.Window 2.15
import QtMultimedia 5.15

Window {
    width: Screen.width
    height: Screen.height
    visible: true

    Video
    {
        width: parent.width
        height: parent.height

        source: "file:///E:\\QT\\VideoPlayer\\video.mp4"
        autoPlay: true
        rotation: 30
    }
}
