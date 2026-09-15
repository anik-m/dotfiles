import QtQuick
import Quickshell
import Quickshell.Io
import qs.Theme

Rectangle {
    id: root

    implicitWidth: workspacesRow.width + 16
    implicitHeight: 26

    radius: 7

    color: Colors.card

    Row {
        id: workspacesRow

        anchors.centerIn: parent

        spacing: 7

        Repeater {
            model: 10

            delegate: Rectangle {
                required property int index

                width: 20
                height: 20

                radius: 5

                property var workspace:
                    NiriService.workspaces.find(
                        w => Number(w.idx) === index + 1
                    )

                property bool focused:
                    workspace !== undefined &&
                    workspace.is_focused === true

                property bool occupied:
                    workspace !== undefined &&
                    workspace.active_window_id !== null

                color:
                    focused
                        ? Colors.accent
                        : mouse.containsMouse
                            ? Colors.cardHover
                            : "transparent"

                Text {
                    anchors.centerIn: parent

                    text: [
                        "০",
                        "১",
                        "২",
                        "৩",
                        "৪",
                        "৫",
                        "৬",
                        "৭",
                        "৮",
                        "৯"
                    ][index]

                    color:
                        focused
                            ? Colors.background
                            : occupied
                                ? Colors.text
                                : Colors.textSecondary

                    font.pixelSize: 12

                    font.bold: focused
                }

                MouseArea {
                    id: mouse

                    anchors.fill: parent

                    hoverEnabled: true

                    onClicked: {
                        focusWorkspace.running = true
                    }
                }

                Process {
                    id: focusWorkspace

                    command: [
                        "niri",
                        "msg",
                        "action",
                        "focus-workspace",
                        String(index + 1)
                    ]

                    running: false
                }
            }
        }
    }
}
