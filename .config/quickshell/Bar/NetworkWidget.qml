import QtQuick
import Quickshell
import Quickshell.Io
import qs.Theme

Text {
    id: root

    property string value: "Disconnected"

    text: value

    color:
        value === "Disconnected"
            ? Colors.accent
            : Colors.text

    font.pixelSize: 12

    verticalAlignment: Text.AlignVCenter

    Process {
        id: network

        command: [
            "sh",
            "-c",
            "nmcli -t -f TYPE,STATE,CONNECTION dev status | awk -F: '$1==\"wifi\" && $2==\"connected\" {print \"wifi:\"$3; exit} $2==\"connected\" {print \"ethernet:\"$3; exit} END {if(!found) print \"disconnected\"}'"
        ]

        running: true

        stdout: SplitParser {
            onRead: function(line) {
                if (line.startsWith("wifi:")) {
                    root.value =
                        " " +
                        line.substring(5)
                }

                else if (
                    line.startsWith("ethernet:")
                ) {
                    root.value =
                        "󰈀 " +
                        line.substring(9)
                }

                else {
                    root.value =
                        "Disconnected ⚠"
                }
            }
        }
    }

    Timer {
        interval: 2000

        running: true

        repeat: true

        onTriggered: {
            network.running = true
        }
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            menu.running = true
        }
    }

    Process {
        id: menu

        command: [
            "/usr/bin/bash",
            "/home/nika/.local/bin/network-menu"
        ]
    }
}
