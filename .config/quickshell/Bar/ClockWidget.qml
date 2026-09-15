import QtQuick
import qs.Theme

Text {
    text: Qt.formatDateTime(new Date(), "HH:mm")

    color: Colors.primary

    font.family: "JetBrainsMono Nerd Font Propo"
    font.pixelSize: 13
    font.bold: true

    verticalAlignment: Text.AlignVCenter

    Timer {
        interval: 1000
        running: true
        repeat: true

        onTriggered: {
            parent.text =
                Qt.formatDateTime(new Date(), "HH:mm")
        }
    }
}
