import QtQuick 1.1

Item {
    id: mark_left

   Quarter_mark_left_up {

   }
   Quarter_mark_left_down {
       anchors.top: mark_left_up.bottom
       anchors.topMargin: 4 + 4 +4
   }
}
