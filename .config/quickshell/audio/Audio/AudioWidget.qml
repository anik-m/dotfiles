import QtQuick
import Quickshell
import qs.Audio
// import qs.Theme
import "../Theme"

Rectangle {
    id: root

    signal clicked()

    implicitWidth: content.implicitWidth + 16
    implicitHeight: 30

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

    Row {
        id: content

        anchors.centerIn: parent

        spacing: 5

        // ============================================================
        // OUTPUT ICON
        // ============================================================

        Text {
            id: outputIcon

            text: AudioService.statusIcon

            color:
                AudioService.muted
                    ? Colors.textSecondary
                    : Colors.text

            font.pixelSize: 16

            anchors.verticalCenter:
                parent.verticalCenter
        }

        // ============================================================
        // VOLUME INDICATOR
        // ============================================================

        Item {
            id: volumeArea

            width: mouseArea.containsMouse ? 34 : 52
            height: 16

            anchors.verticalCenter:
                parent.verticalCenter

            Behavior on width {
                NumberAnimation {
                    duration: 120
                    easing.type: Easing.OutCubic
                }
            }

            // --------------------------------------------------------
            // Percentage on hover
            // --------------------------------------------------------

            Text {
                anchors.centerIn: parent

                text:
                    Math.round(
                        AudioService.volume * 100
                    ) + "%"

                color: Colors.text

                font.pixelSize: 10

                visible: mouseArea.containsMouse

                opacity:
                    mouseArea.containsMouse
                        ? 1
                        : 0

                Behavior on opacity {
                    NumberAnimation {
                        duration: 80
                    }
                }
            }

            // --------------------------------------------------------
            // Minimal volume bar
            // --------------------------------------------------------

            Rectangle {
                id: barBackground

                anchors {
                    left: parent.left
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }

                height: 3

                radius: 1.5

                color: Colors.sliderBackground

                visible: !mouseArea.containsMouse

                Rectangle {
                    anchors {
                        left: parent.left
                        top: parent.top
                        bottom: parent.bottom
                    }

                    width:
                        parent.width *
                        Math.max(
                            0,
                            Math.min(
                                1,
                                AudioService.volume
                            )
                        )

                    radius: parent.radius

                    color:
                        AudioService.muted
                            ? Colors.sliderBackground
                            : Colors.sliderFill

                    Behavior on width {
                        NumberAnimation {
                            duration: 100
                            easing.type: Easing.OutCubic
                        }
                    }
                }
            }
        }

        // ============================================================
        // MICROPHONE MUTED
        // ============================================================

        Text {
            text: "󰍭"

            visible:
                AudioService.sourceMuted

            color: Colors.accent

            font.pixelSize: 14

            anchors.verticalCenter:
                parent.verticalCenter

            opacity:
                AudioService.sourceMuted
                    ? 1
                    : 0

            Behavior on opacity {
                NumberAnimation {
                    duration: 100
                }
            }
        }
    }

    // ================================================================
    // INTERACTION
    // ================================================================

    MouseArea {
        id: mouseArea

        anchors.fill: parent

        hoverEnabled: true

        acceptedButtons:
            Qt.LeftButton |
            Qt.MiddleButton

        onClicked: function(mouse) {
            if (mouse.button === Qt.LeftButton) {
                root.clicked()
            }

            else if (
                mouse.button === Qt.MiddleButton
            ) {
                AudioService.toggleMute()
            }
        }

        onWheel: function(wheel) {
            if (wheel.angleDelta.y > 0)
                AudioService.increaseVolume()
            else if (wheel.angleDelta.y < 0)
                AudioService.decreaseVolume()
        }
    }
}
