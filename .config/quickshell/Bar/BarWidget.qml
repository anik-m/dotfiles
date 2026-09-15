import QtQuick
import qs.Theme

Rectangle {
    id: root

    property alias content: contentItem.data

    implicitHeight: 30

    radius: 7

    color:
        mouse.containsMouse
            ? Colors.cardHover
            : Colors.card

    Behavior on color {
        ColorAnimation {
            duration: 100
        }
    }

    Item {
        id: contentItem

        anchors {
            fill: parent
            leftMargin: 8
            rightMargin: 8
        }
    }

    MouseArea {
        id: mouse

        anchors.fill: parent

        hoverEnabled: true
    }
}
