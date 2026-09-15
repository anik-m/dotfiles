import QtQuick
import Quickshell.Io
import qs.Theme

Row {
    id: root

    spacing: 30

    BatteryWidget {}

    Text {
        text:
            Math.round(SystemStats.memory) + "% "

        color: Colors.text

        font.pixelSize: 12

        verticalAlignment:
            Text.AlignVCenter
    }

    Text {
        text:
            Math.round(SystemStats.cpu) + "% "

        color: Colors.text

        font.pixelSize: 12

        verticalAlignment:
            Text.AlignVCenter
    }

    Text {
        text:
            Math.round(SystemStats.temperature) +
            "°C " +
            (
                SystemStats.temperature >= 80
                    ? "󰔐"
                    : SystemStats.temperature >= 60
                        ? "󰔏"
                        : "󰔄"
            )

        color:
            SystemStats.temperature >= 80
                ? Colors.accent
                : Colors.text

        font.pixelSize: 12

        verticalAlignment:
            Text.AlignVCenter
    }

    Text {
        text: "⏻"

        color: Colors.text

        font.pixelSize: 15

        verticalAlignment:
            Text.AlignVCenter

        MouseArea {
            anchors.fill: parent

            onClicked: {
                power.running = true
            }
        }

        Process {
            id: power

            command: [
                "/home/nika/.local/bin/power-menu"
            ]
        }
    }
}
