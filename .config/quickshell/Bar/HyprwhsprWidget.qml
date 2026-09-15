import QtQuick
import Quickshell
import Quickshell.Io
import qs.Theme

Item {
    id: root

    implicitWidth: content.implicitWidth + 12
    implicitHeight: 30

    property string statusText: ""
    property string tooltipText: ""

    Rectangle {
        anchors.fill: parent

        radius: 7

        color:
            mouseArea.containsMouse
                ? Colors.cardHover
                : Colors.card

        Behavior on color {
            ColorAnimation {
                duration: 100
            }
        }
    }

    Text {
        id: content

        anchors.centerIn: parent

        text: root.statusText

        color: Colors.text

        font.pixelSize: 12

        verticalAlignment:
            Text.AlignVCenter
    }

    // ================================================================
    // STATUS
    // ================================================================

    Process {
        id: statusProcess

        command: [
            "/usr/lib/hyprwhspr/config/hyprland/hyprwhspr-tray.sh",
            "status"
        ]

        running: true

        stdout: SplitParser {
            onRead: function(line) {
                try {
                    const data = JSON.parse(line)

                    root.statusText =
                        data.text !== undefined
                            ? data.text
                            : ""

                    root.tooltipText =
                        data.alt !== undefined
                            ? data.alt
                            : data.tooltip !== undefined
                                ? data.tooltip
                                : ""
                }
                catch (error) {
                    console.warn(
                        "hyprwhspr status parse error:",
                        error,
                        line
                    )

                    root.statusText = line
                }
            }
        }

        stderr: SplitParser {
            onRead: function(line) {
                console.warn(
                    "hyprwhspr:",
                    line
                )
            }
        }
    }

    // ================================================================
    // STATUS REFRESH
    // ================================================================

    Timer {
        interval: 1000

        running: true

        repeat: true

        onTriggered: {
            if (!statusProcess.running)
                statusProcess.running = true
        }
    }

    // ================================================================
    // ACTIONS
    // ================================================================

    Process {
        id: recordProcess

        command: [
            "/usr/lib/hyprwhspr/config/hyprland/hyprwhspr-tray.sh",
            "record"
        ]

        running: false
    }

    Process {
        id: restartProcess

        command: [
            "/usr/lib/hyprwhspr/config/hyprland/hyprwhspr-tray.sh",
            "restart"
        ]

        running: false
    }

    // ================================================================
    // TOOLTIP
    // ================================================================

    Rectangle {
        id: tooltip

        visible:
            mouseArea.containsMouse &&
            root.tooltipText.length > 0

        width:
            tooltipTextItem.implicitWidth + 16

        height:
            tooltipTextItem.implicitHeight + 10

        x:
            (root.width - width) / 2

        y:
            root.height + 5

        radius: 6

        color: Colors.popupBackground

        border.width: 1
        border.color: Colors.popupBorder

        z: 100

        Text {
            id: tooltipTextItem

            anchors.centerIn: parent

            text: root.tooltipText

            color: Colors.text

            font.pixelSize: 11
        }
    }

    // ================================================================
    // MOUSE
    // ================================================================

    MouseArea {
        id: mouseArea

        anchors.fill: parent

        hoverEnabled: true

        acceptedButtons:
            Qt.LeftButton |
            Qt.RightButton

        onClicked: function(mouse) {
            if (mouse.button === Qt.LeftButton) {
                recordProcess.running = true
            }

            else if (
                mouse.button === Qt.RightButton
            ) {
                restartProcess.running = true
            }
        }
    }
}
