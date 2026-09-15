import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.Theme
import qs.Audio

PanelWindow {
    id: root

    required property var screen

    screen: root.screen

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 30

    color: "transparent"

    exclusiveZone: 30

    WlrLayershell.layer: WlrLayer.Top

    Row {
        id: bar

        anchors {
            fill: parent
            leftMargin: 4
            rightMargin: 4
        }

        spacing: 3

        // ============================================================
        // LEFT
        // ============================================================

        Item {
            width: leftContent.width
            height: parent.height

            Row {
                id: leftContent

                anchors.verticalCenter: parent.verticalCenter

                spacing: 30

                PomodoroWidget {}

                WindowWidget {}
            }
        }

        // ============================================================
        // CENTER
        // ============================================================

        Item {
            width:
                Math.max(
                    0,
                    parent.width -
                    leftContent.width -
                    rightContent.width -
                    6
                )

            height: parent.height

            WorkspaceWidget {
                anchors.centerIn: parent
            }
        }

        // ============================================================
        // RIGHT
        // ============================================================

        Item {
            id: rightContentContainer

            width: rightContent.width
            height: parent.height

            Row {
                id: rightContent

                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                spacing: 30

                // hyprwhspr placeholder.
                // Replace the command/text once the omitted
                // hyprwhspr-module-niri.jsonc is supplied.
                HyprwhsprWidget {}

                StopwatchWidget {}

                UtilsGroup {}

                ClockWidget {}

                SystemGroup {}
            }
        }
    }
}
