import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import qs.Audio
// import qs.Theme
import "../Theme"

Rectangle {
    id: root

    required property var node
    required property bool output

    signal selected()

    property bool selectedDevice:
        output
            ? AudioService.sink === node
            : AudioService.source === node

    PwObjectTracker {
        objects: [root.node]
    }

    width: parent.width
    height: 52

    radius: 8

    color:
        selectedDevice
            ? Colors.cardSelected
            : mouseArea.containsMouse
                ? Colors.cardHover
                : Colors.card

    border.width:
        selectedDevice ? 1 : 0

    border.color:
        selectedDevice
            ? Colors.accent
            : "transparent"

    Behavior on color {
        ColorAnimation {
            duration: 100
        }
    }

    Behavior on border.color {
        ColorAnimation {
            duration: 100
        }
    }

    Row {
        anchors {
            fill: parent
            leftMargin: 12
            rightMargin: 12
        }

        spacing: 12

        Text {
            width: 28

            anchors.verticalCenter: parent.verticalCenter

            text:
                root.output
                    ? "󰓃"
                    : "󰍬"

            color:
                root.selectedDevice
                    ? Colors.accent
                    : Colors.textSecondary

            font.pixelSize: 20

            horizontalAlignment: Text.AlignHCenter
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter

            width: parent.width - 60

            spacing: 2

            Text {
                width: parent.width

                text:
                    root.node.description ||
                    root.node.nickname ||
                    root.node.name

                color: Colors.text

                font.pixelSize: 13

                elide: Text.ElideRight
            }

            Text {
                width: parent.width

                text: root.node.name

                color: Colors.textSecondary

                font.pixelSize: 10

                elide: Text.ElideRight

                visible:
                    root.node.description !== root.node.name
            }
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter

            text:
                root.selectedDevice
                    ? "✓"
                    : ""

            color: Colors.accent

            font.pixelSize: 15
            font.bold: true
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent

        hoverEnabled: true

        acceptedButtons: Qt.LeftButton

        onClicked: {
            if (root.output)
                AudioService.setOutput(root.node)
            else
                AudioService.setInput(root.node)

            root.selected()
        }
    }
}
