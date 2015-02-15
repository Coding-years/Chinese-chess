/****************************************************************************
**
** Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

//import QtQuick 1.0
import QtQuick 1.0
import "chess_items"

/*
    This is exactly the same as states.qml, except that we have appended
    a set of transitions to apply animations when the item changes 
    between each state.
*/

Rectangle {
    //Item {
    property int line_width: 4
    property int line_mid_spc: 60 /* the line middle spacing */

    id: page
    width: 10*line_mid_spc; height: 11*line_mid_spc

    //color: "#404000FF"
    color: "#202000FF"
    //Image { source: "background.png"; anchors.fill: parent; fillMode: Image.Tile }

    Column {
        spacing: line_mid_spc - line_width
        anchors.horizontalCenter: page.horizontalCenter
        anchors.verticalCenter: page.verticalCenter

        Repeater {
            model: 10
            delegate: Rectangle {width: 8*line_mid_spc + line_width; height: line_width; color: "red"}
        }
    }

    Row {
        spacing: line_mid_spc - line_width
        anchors.horizontalCenter: page.horizontalCenter
        anchors.verticalCenter: page.verticalCenter
        anchors.verticalCenterOffset: 2*line_mid_spc + line_mid_spc/2 + line_width/2

        Repeater {
            model: 7
            delegate: Rectangle {width: line_width; height: 4*line_mid_spc; color: "green"}
        }
    }

    Row {
        spacing: line_mid_spc - line_width
        anchors.horizontalCenter: page.horizontalCenter
        anchors.verticalCenter: page.verticalCenter

        Rectangle {width: line_width; height: 9*line_mid_spc + line_width; color: "green"}
        Repeater {
            model: 7
            delegate: Rectangle {width: line_width; height: 4*line_mid_spc; color: "green"}
        }
        Rectangle {width: line_width; height: 9*line_mid_spc + line_width; color: "green"}
    }

    Column {
        id: guard_line
        spacing: 5*line_mid_spc
        anchors.horizontalCenter: page.horizontalCenter
        anchors.verticalCenter: page.verticalCenter
        z: 0

        Repeater {
            model: 2
            delegate:
            Item {
                width: 2*line_mid_spc
                height: 2*line_mid_spc
                rotation: 45

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: 1.414*2*line_mid_spc; height: line_width;
                    color: "gray";
                }
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: line_width; height: 1.414*2*line_mid_spc
                    color: "gray"
                }
            }
        }
    }

    Row {
        id: obiit_mark_left_up
        spacing: 2*line_mid_spc - 16
        anchors.verticalCenter: page.verticalCenter
        anchors.verticalCenterOffset: -3*line_mid_spc/2
        anchors.horizontalCenter: page.horizontalCenter
        anchors.horizontalCenterOffset: line_mid_spc - 16/2 - line_width

        Repeater {
            model: 4
            delegate: Quarter_mark_left_down {}
        }
    }

    Row {
        id: obiit_mark_right_up
        spacing: 2*line_mid_spc - 16
        anchors.verticalCenter: page.verticalCenter
        anchors.verticalCenterOffset: -3*line_mid_spc/2
        anchors.horizontalCenter: page.horizontalCenter
        anchors.horizontalCenterOffset: -line_mid_spc + 16/2 + line_width

       Repeater {
           model: 4
           delegate: Quarter_mark_right_down {}
        }
    }

    Row {
        id: obiit_mark_left_down
        spacing: 2*line_mid_spc - 16
        anchors.verticalCenter: page.verticalCenter
        anchors.verticalCenterOffset: (line_mid_spc + 30)
        anchors.horizontalCenter: page.horizontalCenter
        anchors.horizontalCenterOffset: line_mid_spc - 16/2 - 4

        Repeater {
            model: 4
            delegate: Quarter_mark_left_down {}
        }
    }

    Row {
        id: obiit_mark_right_down
        spacing: 2*line_mid_spc - 16
        anchors.verticalCenter: page.verticalCenter
        anchors.verticalCenterOffset: (line_mid_spc + 30)
        anchors.horizontalCenter: page.horizontalCenter
        anchors.horizontalCenterOffset: -line_mid_spc + 16/2 + 4

       Repeater {
           model: 4
           delegate: Quarter_mark_right_down {}
        }
    }

    Column {
        id: cannon_mark
        spacing: 5*line_mid_spc - 2*16 - line_width/* the trunk line width */ - 2*2/* the margin between the quarter mark's horizon line and the chessboard trunk line */
        anchors.horizontalCenter:  page.horizontalCenter
        anchors.verticalCenter:  page.verticalCenter

        Repeater {
            model: 2
            delegate:
            Item {
                width: 6*line_mid_spc + 2*(16 + 2 + line_width/2)
                height: 2*(16 + 2 + line_width/2)

                Row {
                    id : cannon_mark_left
                    spacing: 6*line_mid_spc - 16
                    anchors.left: parent.left

                    Repeater {
                        model: 2
                        delegate: Quarter_mark_left_down {}
                    }
                }

                Row {
                    id : cannon_mark_right
                    spacing: 6*line_mid_spc - 16
                    anchors.right: parent.right

                    Repeater {
                        model: 2
                        delegate: Quarter_mark_right_down {}
                    }
                }
            }
        }
    }

    property int chess_size: 50
    property int font_size: chess_size*70/100

    Rectangle {
        id: red_horse
        width: chess_size
        height: chess_size
        radius: width/2
        x: (page.width - 8*line_mid_spc)/2 - width/2
        y: (page.height - 9*line_mid_spc)/2 + 9*line_mid_spc - width/2
        //anchors.horizontalCenter: parent.horizontalCenter
        //anchors.verticalCenter: parent.verticalCenter
        //anchors.horizontalCenterOffset: -4*line_mid_spc
        //anchors.verticalCenterOffset: 9*line_mid_spc/2
        color: "yellow"
        Text {
            color: "#FF0000"
            text: "马"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: font_size
            font.family: "Impact"
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

    Rectangle {
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
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            //red_horse.anchors.horizontalCenterOffset += mouseX - red_horse.x
            //red_horse.anchors.verticalCenterOffset += mouseY - red_horse.y
            red_horse.x = mouseX - chess_size/2
            red_horse.y = mouseY - chess_size/2
        }
    }

    /*color: "#343434"*/
    //color: "#FFFFFF"

    /*Flow {
            anchors.fill: parent
            anchors.margins: 4
            spacing: 10

            Text { text: "Text"; font.pixelSize: 40 }
            Text { text: "items"; font.pixelSize: 40 }
            Text { text: "flowing"; font.pixelSize: 40 }
            Text { text: "inside"; font.pixelSize: 40 }
            Text { text: "a"; font.pixelSize: 40 }
            Text { text: "Flow"; font.pixelSize: 40 }
            Text { text: "item"; font.pixelSize: 40 }
        }*/

    /*Image {
        id: userIcon
        x: topLeftRect.x; y: topLeftRect.y
        source: "qt-logo.png"
    }*/

    /*Image { source: "lele1.jpeg"; anchors.fill: parent; fillMode: Image.PreserveAspectCrop
    }*/

/*    Rectangle {
        id: topLeftRect

        anchors { left: parent.left; top: parent.top; leftMargin: 40; topMargin: 40 }
        //width: 46; height: 54
        width: (parent.width - 80); height: (parent.height - 80)
        color: "Transparent"; border.color: "Gray"; border.width: 5; radius: 0
        //color: "red"; border.color: "Gray"; radius: 6

        // Clicking in here sets the state to the default state, returning the image to
        // its initial position
        MouseArea { anchors.fill: parent; onClicked: page.state = '' }

    }*/

/*    Path {
        id: chessLine
        startX: topLeftRect.x; startY: topLeftRect.y + 100
        PathLine { x: topLeftRect.x + 200; y: topLeftRect.y + 100 }
    }*/

    /*Line {
        id:
    }/*

    /*Rectangle {
        id: middleRightRect

        anchors { right: parent.right; verticalCenter: parent.verticalCenter; rightMargin: 20 }
        width: 46; height: 54
        color: "Transparent"; border.color: "Gray"; radius: 6

        // Clicking in here sets the state to 'middleRight'
        MouseArea { anchors.fill: parent; onClicked: page.state = 'middleRight' }
    }

    Rectangle {
        id: bottomLeftRect

        anchors { left: parent.left; bottom: parent.bottom; leftMargin: 10; bottomMargin: 20 }
        width: 46; height: 54
        color: "Transparent"; border.color: "Gray"; radius: 6

        // Clicking in here sets the state to 'bottomLeft'
        MouseArea { anchors.fill: parent; onClicked: page.state = 'bottomLeft' }
    }*/

    /*states: [
        // In state 'middleRight', move the image to middleRightRect
        State {
            name: "middleRight"
            PropertyChanges { target: userIcon; x: middleRightRect.x; y: middleRightRect.y }
        },

        // In state 'bottomLeft', move the image to bottomLeftRect
        State {
            name: "bottomLeft"
            PropertyChanges { target: userIcon; x: bottomLeftRect.x; y: bottomLeftRect.y  }
        }
    ]

    // Transitions define how the properties change when the item moves between each state
    transitions: [

        // When transitioning to 'middleRight' move x,y over a duration of 1 second,
        // with OutBounce easing function.
        Transition {
            from: "*"; to: "middleRight"
            NumberAnimation { properties: "x,y"; easing.type: Easing.OutBounce; duration: 1000 }
        },

        // When transitioning to 'bottomLeft' move x,y over a duration of 2 seconds,
        // with InOutQuad easing function.
        Transition {
            from: "*"; to: "bottomLeft"
            NumberAnimation { properties: "x,y"; easing.type: Easing.InOutQuad; duration: 2000 }
        },

        // For any other state changes move x,y linearly over duration of 200ms.
        Transition {
            NumberAnimation { properties: "x,y"; duration: 200 }
        }
    ]*/
}
