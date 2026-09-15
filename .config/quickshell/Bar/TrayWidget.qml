import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import qs.Theme

Row {
    id: root

    spacing: 10

    Repeater {
        model: SystemTray.items

        delegate: Item {
            required property var modelData

            width: 18
            height: 22

            Image {
                anchors.centerIn: parent

                width: 18
                height: 18

                source:
                    modelData.icon

                fillMode:
                    Image.PreserveAspectFit
            }

            MouseArea {
                anchors.fill: parent

                acceptedButtons:
                    Qt.LeftButton |
                    Qt.RightButton

                onClicked: function(mouse) {
                    if (
                        mouse.button ===
                        Qt.LeftButton
                    ) {
                        modelData.activate()
                    }
                    else {
                        modelData.secondaryActivate()
                    }
                }
            }
        }
    }
}
