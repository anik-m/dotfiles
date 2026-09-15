import QtQuick
import Quickshell
import Quickshell.Io
import qs.Theme

Text {
    id: root

    property string textValue: "󱍷"
    property string tooltipValue: ""

    text: textValue

    color: Colors.text

    font.pixelSize: 13

    Process {
        id: updateTracker

        command: [
            "/home/nika/.local/bin/waybar-update-tracker"
        ]

        running: true

        stdout: SplitParser {
            onRead: function(line) {
                try {
                    const json = JSON.parse(line)

                    root.textValue =
                        json.text || ""

                    root.tooltipValue =
                        json.alt || ""
                }

                catch (error) {
                    root.textValue = line
                }
            }
        }
    }

    Timer {
        interval: 60000

        running: true

        repeat: true

        onTriggered: {
            updateTracker.running = true
        }
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            update.running = true
        }
    }

    Process {
        id: update

        command: [
            "alacritty",
            "-e",
            "sh",
            "-c",
            "sudo pacman -Syu && sudo paru -Sua"
        ]
    }
}
