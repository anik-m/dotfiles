
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
        id: pomodoro

        command: [
            "/home/nika/.local/bin/waybar-pomodoro"
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
            pomodoro.running = true
        }
    }

    MouseArea {
        anchors.fill: parent

        acceptedButtons:
            Qt.LeftButton |
            Qt.MiddleButton |
            Qt.RightButton

        onClicked: function(mouse) {
            if (mouse.button === Qt.LeftButton) {
                toggle.running = true
            }

            else if (mouse.button === Qt.RightButton) {
                cycle.running = true
            }

            else if (mouse.button === Qt.MiddleButton) {
                stop.running = true
            }
        }
    }

    Process {
        id: toggle

        command: [
            "/home/nika/.local/bin/waybar-pomodoro",
            "toggle"
        ]
    }

    Process {
        id: cycle

        command: [
            "/home/nika/.local/bin/waybar-pomodoro",
            "cycle"
        ]
    }

    Process {
        id: stop

        command: [
            "/home/nika/.local/bin/waybar-pomodoro",
            "stop"
        ]
    }
}
