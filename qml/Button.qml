import QtQuick 2.15

Rectangle
{
    id: rectangle_button

    property color onclicked_color: "#343a40"
    property color background_color: "#292f33"
    property alias text_color: text_button.color
    property alias text: text_button.text

    signal clicked()

    width: childrenRect.width
    height: childrenRect.height
    radius: height/10
    color: mousearea.pressed ? onclicked_color : background_color

    Text
    {
        id: text_button
        padding: 20
        color: "white"
    }

    MouseArea
    {
        id: mousearea
        anchors.fill: parent
        onClicked: rectangle_button.clicked()
    }
}
