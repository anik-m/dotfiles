import QtQuick
import Quickshell.Services.Pipewire
import qs.Audio
// import qs.Theme
import "../Theme"

Column {
    id: root

    required property bool output

    spacing: 5

    Repeater {
        model: Pipewire.nodes

        delegate: Rectangle {
            required property var modelData

            readonly property var node: modelData

            width: root.width
            height: 52

            radius: 8

            visible:
                node.audio !== null &&
                !node.isStream &&
                node.isSink === root.output

            color:
                node === (
                    root.output
                        ? AudioService.sink
                        : AudioService.source
                )
                    ? Colors.cardSelected
                    : mouseArea.containsMouse
                        ? Colors.cardHover
                        : Colors.card

            border.width:
                node === (
                    root.output
                        ? AudioService.sink
                        : AudioService.source
                )
                    ? 1
                    : 0

            border.color:
                node === (
                    root.output
                        ? AudioService.sink
                        : AudioService.source
                )
                    ? Colors.accent
                    : "transparent"

            Behavior on color {
                ColorAnimation {
                    duration: 80
                }
            }

            Behavior on border.color {
                ColorAnimation {
                    duration: 80
                }
            }

            Row {
                anchors {
                    fill: parent
                    leftMargin: 12
                    rightMargin: 12
                }

                spacing: 10

                Text {
                    width: 28

                    anchors.verticalCenter: parent.verticalCenter

                    text:
                        root.output
                            ? "󰓃"
                            : "󰍬"

                    color:
                        node === (
                            root.output
                                ? AudioService.sink
                                : AudioService.source
                        )
                            ? Colors.accent
                            : Colors.textSecondary

                    font.pixelSize: 19

                    horizontalAlignment:
                        Text.AlignHCenter
                }

                Column {
                    anchors.verticalCenter: parent.verticalCenter

                    width: parent.width - 70

                    spacing: 2

                    Text {
                        width: parent.width

                        text:
                            node.description ||
                            node.nickname ||
                            node.name

                        color: Colors.text

                        font.pixelSize: 13

                        elide: Text.ElideRight
                    }

                    Text {
                        width: parent.width

                        text: node.name

                        color: Colors.textSecondary

                        font.pixelSize: 10

                        elide: Text.ElideRight

                        visible:
                            node.description !== node.name
                    }
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter

                    text:
                        node === (
                            root.output
                                ? AudioService.sink
                                : AudioService.source
                        )
                            ? "✓"
                            : ""

                    color: Colors.accent

                    font.pixelSize: 15

                    font.bold: true
                }
            }

            MouseArea {
                id: mouseArea

                anchors.fill: parent

                hoverEnabled: true

                acceptedButtons: Qt.LeftButton

                onClicked: {
                    console.log(
                        "Selecting audio node:",
                        node.id,
                        node.description,
                        node.name
                    )

                    if (root.output) {
                        Pipewire.preferredDefaultAudioSink =
                            node
                    } else {
                        Pipewire.preferredDefaultAudioSource =
                            node
                    }
                }
            }
        }
    }
}
