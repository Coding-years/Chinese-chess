import QtQuick 2.2

/*Rectangle {
    width: 100
    height: 62
}*/

Item {
    property alias chess_color: chess_text.color
    property alias chess_name: chess_text.text
    property int chess_size: 50
    property int font_size: chess_size*70/100

    width: chess_size
    height: chess_size

    Rectangle {
        //id: chess
        anchors.fill: parent
        //width: chess_size
        //height: chess_size
        radius: width/2
        //x: (page.width - 8*line_mid_spc)/2 - width/2
        //y: (page.height - 9*line_mid_spc)/2 + 9*line_mid_spc - width/2
        //anchors.horizontalCenter: parent.horizontalCenter
        //anchors.verticalCenter: parent.verticalCenter
        //anchors.horizontalCenterOffset: -4*line_mid_spc
        //anchors.verticalCenterOffset: 9*line_mid_spc/2
        color: "yellow"
        Text {
            id: chess_text
            //color: "#FF0000"
            //text: "马"
            anchors.centerIn: parent
            //anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: font_size
            //font.family: "Impact"
            font.family: "Helvetica"
        }
        //NumberAnimation on x { to: x + line_mid_spc; duration: 1000 }
        //NumberAnimation on y { to: y - 2*line_mid_spc; duration: 1000 }
        /*MouseArea {
    anchors.fill: parent
    onClicked: {
    //parent.x += line_mid_spc
    //parent.y += 2*line_mid_spc
    //parent.color = 'red'
    parent.anchors.horizontalCenterOffset += line_mid_spc
    parent.anchors.verticalCenterOffset -= 2*line_mid_spc
    }
    }*/
    }
}

/*Rectangle {
    id: red_rook
    width: chess_size
    height: chess_size
    radius: width/2
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenterOffset: -3*line_mid_spc
    anchors.verticalCenterOffset: 9*line_mid_spc/2
    color: "yellow"
    Text {
        color: "#FF0000"
        text: "车"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: font_size
        font.family: "Helvetica"
    }
}*/
