import QtQuick
import Quickshell
import Quickshell.Io

import qs.Audio

ShellRoot {
    id: root

    PanelWindow {
        id: audioAnchor

        anchors {
            top: true
            right: true
        }

        implicitWidth: 1
        implicitHeight: 1

        color: "transparent"

        AudioPopup {
            id: audioPopup

            anchor.window: audioAnchor

            anchor.rect.x: -audioPopup.width
            anchor.rect.y: audioAnchor.height + 5

            visible: false
        }
    }

    IpcHandler {
        target: "audio"

        function toggle(): void {
            audioPopup.visible = !audioPopup.visible
        }

        function open(): void {
            audioPopup.visible = true
        }

        function close(): void {
            audioPopup.visible = false
        }
    }
}
