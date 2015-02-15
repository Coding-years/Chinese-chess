//import QtQuick 1.0
import QtQuick 1.1

/*Rectangle {
    width: 100
    height: 62
}*/

/*Item {
    //y: 4*4

    Rectangle {
        id: first_horizon
        width: 16; height: 4
        color: "gray"
    }

    Rectangle {
        //x: first_horizon.x; y: first_horizon.y + 16 - 4
        width: 4; height: 16
        color: "gray"
    }
    /*Quarter_mark_right_up {
        x: (page.width - 8*60)/2 + 4*2 + 4; y: (page.height - 3*60)/2 - 4*2 +4
        transformOrigin: Item.BottomLeft
        rotation: 90
    }
}*/

/*Item {
    id: right_mark

    rotation: 180
    Quarter_mark_left_down {

    }
}*/
Item {
    //y: 4*4
    id: mark_right_down
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
        anchors.left: parent.left
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
        anchors.left: parent.left
        anchors.top: parent.top
        width: 4; height: 16
        color: "gray"
    }
}
