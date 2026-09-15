import QtQuick
import Quickshell
import Quickshell.Io
import qs.Theme

Text {
    id: root

    property string value: ""

    text: value

    color: Colors.text

    font.pixelSize: 12

    verticalAlignment: Text.AlignVCenter

    Process {
        id: stopwatch

        command: [
            "/usr/bin/bash",
            "/home/nika/.config/waybar/scripts/waybar-stopwatch"
        ]

        running: true

        stdout: SplitParser {
            onRead: function(line) {
                try {
                    const json = JSON.parse(line)
                    root.value =
                        json.text !== undefined
                            ? json.text
                            : line
                }
                catch (e) {
                    root.value = line
                }
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true

        onTriggered: {
            stopwatch.running = true
        }
    }

    MouseArea {
        anchors.fill: parent

        acceptedButtons:
            Qt.LeftButton |
            Qt.RightButton

        onClicked: function(mouse) {
            if (mouse.button === Qt.LeftButton)
                toggle.running = true
            else
                reset.running = true
        }
    }

    Process {
        id: toggle

        command: [
            "/usr/bin/bash",
            "/home/nika/.config/waybar/scripts/waybar-stopwatch",
            "toggle"
        ]
    }

    Process {
        id: reset

        command: [
            "/usr/bin/bash",
            "/home/nika/.config/waybar/scripts/waybar-stopwatch",
            "reset"
        ]
    }
}
