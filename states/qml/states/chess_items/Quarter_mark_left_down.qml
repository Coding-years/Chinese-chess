//import QtQuick 1.0
import QtQuick 1.0

/*Rectangle {
    width: 100
    height: 62
}*/

Item {
    //y: 4*4
    id: mark_left_down
    //anchors.fill: parent
    width: 16; height: 16*2 + 4*2
    //color: "yellow"

    Rectangle {
        id: down_horizon
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -4 - 4/2
        width: 16; height: 4
        color: "gray"
    }

    Rectangle {
        id: down_vertical
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: 4; height: 16
        color: "gray"
    }

        Rectangle {
        id: up_horizon
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 4 + 4/2
        width: 16; height: 4
        color: "gray"
    }

    Rectangle {
        id: up_vertical
        anchors.right: parent.right
        anchors.top: parent.top
        width: 4; height: 16
        color: "gray"
    }
}
