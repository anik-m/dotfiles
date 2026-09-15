import QtQuick
import Quickshell
import qs.Audio
// import qs.Theme
import "../Theme"

PopupWindow {
    id: root


    implicitWidth: 380

    implicitHeight:
        420 +
        (
            outputSelector.expanded
                ? outputDeviceList.implicitHeight + 1
                : 0
        ) +
        (
            inputSelector.expanded
                ? inputDeviceList.implicitHeight + 1
                : 0
        )

    color: "transparent"

    Rectangle {
        id: popup

        anchors.fill: parent

        radius: 14

        color: Colors.popupBackground

        border.width: 1
        border.color: Colors.popupBorder

        Column {
            anchors {
                fill: parent
                margins: 18
            }

            spacing: 14

            // ============================================================
            // HEADER
            // ============================================================

            Column {
                width: parent.width

                spacing: 2

                Text {
                    text: "Audio"

                    color: Colors.text

                    font.pixelSize: 20
                    font.bold: true
                }

                Text {
                    text: "Output and input controls"

                    color: Colors.textSecondary

                    font.pixelSize: 11
                }
            }

            // ============================================================
            // OUTPUT
            // ============================================================

            Column {
                width: parent.width

                spacing: 7

                Text {
                    text: "OUTPUT"

                    color: Colors.textSecondary

                    font.pixelSize: 10
                    font.bold: true

                    opacity: 0.9
                }

                // --------------------------------------------------------
                // OUTPUT CARD
                // --------------------------------------------------------

                Rectangle {
                    id: outputCard

                    width: parent.width
                    height: 58

                    radius: 10

                    color:
                        outputMouse.containsMouse
                            ? Colors.cardHover
                            : Colors.card

                    border.width:
                        AudioService.muted
                            ? 1
                            : 0

                    border.color:
                        AudioService.muted
                            ? Colors.accent
                            : "transparent"

                    Behavior on color {
                        ColorAnimation {
                            duration: 100
                        }
                    }

                    Behavior on border.color {
                        ColorAnimation {
                            duration: 100
                        }
                    }

                    Row {
                        anchors {
                            fill: parent
                            leftMargin: 14
                            rightMargin: 14
                        }

                        spacing: 12

                        Text {
                            anchors.verticalCenter: parent.verticalCenter

                            text: AudioService.volumeIcon

                            color:
                                AudioService.muted
                                    ? Colors.accent
                                    : Colors.text

                            font.pixelSize: 22
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter

                            width: parent.width - 50

                            spacing: 2

                            Text {
                                width: parent.width

                                text: AudioService.sinkName

                                color: Colors.text

                                font.pixelSize: 14

                                elide: Text.ElideRight
                            }

                            Text {
                                text:
                                    AudioService.muted
                                        ? "Muted"
                                        : Math.round(
                                            AudioService.volume * 100
                                        ) + "%"

                                color:
                                    AudioService.muted
                                        ? Colors.accent
                                        : Colors.textSecondary

                                font.pixelSize: 11

                                font.bold:
                                    AudioService.muted
                            }
                        }
                    }

                    // PRESERVED:
                    // output left click = mute
                    // output wheel = volume
                    MouseArea {
                        id: outputMouse

                        anchors.fill: parent

                        hoverEnabled: true

                        acceptedButtons:
                            Qt.LeftButton |
                            Qt.MiddleButton

                        onClicked: function(mouse) {
                            if (mouse.button === Qt.LeftButton) {
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

                // --------------------------------------------------------
                // OUTPUT SLIDER
                // --------------------------------------------------------

                Rectangle {
                    id: outputSlider

                    width: parent.width
                    height: 8

                    radius: 4

                    color: Colors.sliderBackground

                    Rectangle {
                        width:
                            outputSlider.width *
                            Math.max(
                                0,
                                Math.min(
                                    1,
                                    AudioService.volume
                                )
                            )

                        height: parent.height

                        radius: 4

                        color:
                            AudioService.muted
                                ? Colors.accent
                                : Colors.sliderFill

                        Behavior on width {
                            NumberAnimation {
                                duration: 80
                            }
                        }
                    }

                    // PRESERVED:
                    // click = set volume
                    // wheel = change volume
                    MouseArea {
                        anchors.fill: parent

                        acceptedButtons: Qt.LeftButton

                        onClicked: function(mouse) {
                            AudioService.setVolume(
                                Math.max(
                                    0,
                                    Math.min(
                                        1,
                                        mouse.x / width
                                    )
                                )
                            )
                        }

                        onWheel: function(wheel) {
                            if (wheel.angleDelta.y > 0)
                                AudioService.increaseVolume()
                            else if (wheel.angleDelta.y < 0)
                                AudioService.decreaseVolume()
                        }
                    }
                }

                // --------------------------------------------------------
                // OUTPUT DEVICE SELECTOR
                // --------------------------------------------------------

                Rectangle {
                    id: outputSelector

                    width: parent.width

                    height:
                        52 +
                        (
                            expanded
                                ? outputDeviceList.implicitHeight + 1
                                : 0
                        )

                    radius: 8

                    color: Colors.card

                    property bool expanded: false

                    Behavior on height {
                        NumberAnimation {
                            duration: 150
                            easing.type: Easing.OutCubic
                        }
                    }

                    // Selector header
                    Item {
                        id: outputSelectorHeader

                        anchors {
                            left: parent.left
                            right: parent.right
                            top: parent.top
                        }

                        height: 52

                        // Rectangle {
                        //     anchors.fill: parent
                        //
                        //     radius: 8
                        //
                        //     color:
                        //         outputSelectorMouse.containsMouse
                        //             ? Colors.cardHover
                        //             : "transparent"
                        //
                        //     Behavior on color {
                        //         ColorAnimation {
                        //             duration: 100
                        //         }
                        //     }
                        // }
                        //
                        Column {
                            anchors {
                                left: parent.left
                                leftMargin: 12
                                right: parent.right
                                rightMargin: 36
                                verticalCenter: parent.verticalCenter
                            }

                            spacing: 2

                            Text {
                                text: "OUTPUT DEVICE"

                                color: Colors.textSecondary

                                font.pixelSize: 9
                                font.bold: true

                                opacity: 0.9
                            }

                            Text {
                                width: parent.width

                                text: AudioService.sinkName

                                color: Colors.text

                                font.pixelSize: 12

                                elide: Text.ElideRight
                            }
                        }

                        Text {
                            anchors {
                                right: parent.right
                                rightMargin: 12
                                verticalCenter: parent.verticalCenter
                            }

                            text:
                                outputSelector.expanded
                                    ? "⌃"
                                    : "⌄"

                            color:
                                outputSelectorMouse.containsMouse
                                    ? Colors.accent
                                    : Colors.textSecondary

                            font.pixelSize: 15
                            font.bold: true
                        }

                        // PRESERVED selector toggle
                        MouseArea {
                            id: outputSelectorMouse

                            anchors.fill: parent

                            hoverEnabled: true

                            acceptedButtons: Qt.LeftButton

                            onClicked: {
                                outputSelector.expanded =
                                    !outputSelector.expanded
                            }
                        }
                    }

                    // Small separation below selector header
                    Rectangle {
                        anchors {
                            top: outputSelectorHeader.bottom
                            left: parent.left
                            right: parent.right
                        }

                        height: 1

                        color: Colors.popupBorder

                        visible: outputSelector.expanded
                    }

                    AudioDeviceList {
                        id: outputDeviceList

                        anchors {
                            top: parent.top
                            topMargin: 53
                            left: parent.left
                            right: parent.right
                        }

                        width: parent.width

                        output: true

                        visible: outputSelector.expanded
                    }
                }
            }

            // ============================================================
            // INPUT
            // ============================================================

            Column {
                width: parent.width

                spacing: 7

                Text {
                    text: "INPUT"

                    color: Colors.textSecondary

                    font.pixelSize: 10
                    font.bold: true

                    opacity: 0.9
                }

                // --------------------------------------------------------
                // INPUT CARD
                // --------------------------------------------------------

                Rectangle {
                    id: inputCard

                    width: parent.width
                    height: 58

                    radius: 10

                    color:
                        inputMouse.containsMouse
                            ? Colors.cardHover
                            : Colors.card

                    border.width:
                        AudioService.sourceMuted
                            ? 1
                            : 0

                    border.color:
                        AudioService.sourceMuted
                            ? Colors.accent
                            : "transparent"

                    Behavior on color {
                        ColorAnimation {
                            duration: 100
                        }
                    }

                    Behavior on border.color {
                        ColorAnimation {
                            duration: 100
                        }
                    }

                    Row {
                        anchors {
                            fill: parent
                            leftMargin: 14
                            rightMargin: 14
                        }

                        spacing: 12

                        Text {
                            anchors.verticalCenter: parent.verticalCenter

                            text: AudioService.sourceIcon

                            color:
                                AudioService.sourceMuted
                                    ? Colors.accent
                                    : Colors.text

                            font.pixelSize: 22
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter

                            width: parent.width - 50

                            spacing: 2

                            Text {
                                width: parent.width

                                text: AudioService.sourceName

                                color: Colors.text

                                font.pixelSize: 14

                                elide: Text.ElideRight
                            }

                            Text {
                                text:
                                    AudioService.sourceMuted
                                        ? "Muted"
                                        : Math.round(
                                            AudioService.sourceVolume * 100
                                        ) + "%"

                                color:
                                    AudioService.sourceMuted
                                        ? Colors.accent
                                        : Colors.textSecondary

                                font.pixelSize: 11

                                font.bold:
                                    AudioService.sourceMuted
                            }
                        }
                    }

                    // PRESERVED:
                    // input left click = mute
                    // input wheel = volume
                    MouseArea {
                        id: inputMouse

                        anchors.fill: parent

                        hoverEnabled: true

                        acceptedButtons: Qt.LeftButton

                        onClicked: {
                            if (AudioService.source)
                                AudioService.source.audio.muted =
                                    !AudioService.source.audio.muted
                        }

                        onWheel: function(wheel) {
                            if (wheel.angleDelta.y > 0)
                                AudioService.increaseSourceVolume()
                            else if (wheel.angleDelta.y < 0)
                                AudioService.decreaseSourceVolume()
                        }
                    }
                }

                // --------------------------------------------------------
                // INPUT SLIDER
                // --------------------------------------------------------

                Rectangle {
                    id: inputSlider

                    width: parent.width
                    height: 8

                    radius: 4

                    color: Colors.sliderBackground

                    Rectangle {
                        width:
                            inputSlider.width *
                            Math.max(
                                0,
                                Math.min(
                                    1,
                                    AudioService.sourceVolume
                                )
                            )

                        height: parent.height

                        radius: 4

                        color:
                            AudioService.sourceMuted
                                ? Colors.accent
                                : Colors.sliderFill

                        Behavior on width {
                            NumberAnimation {
                                duration: 80
                            }
                        }
                    }

                    // PRESERVED:
                    // click = set input volume
                    // wheel = change input volume
                    MouseArea {
                        anchors.fill: parent

                        acceptedButtons: Qt.LeftButton

                        onClicked: function(mouse) {
                            AudioService.setSourceVolume(
                                Math.max(
                                    0,
                                    Math.min(
                                        1,
                                        mouse.x / width
                                    )
                                )
                            )
                        }

                        onWheel: function(wheel) {
                            if (wheel.angleDelta.y > 0)
                                AudioService.increaseSourceVolume()
                            else if (wheel.angleDelta.y < 0)
                                AudioService.decreaseSourceVolume()
                        }
                    }
                }

                // --------------------------------------------------------
                // INPUT DEVICE SELECTOR
                // --------------------------------------------------------

                Rectangle {
                    id: inputSelector

                    width: parent.width

                    height:
                        52 +
                        (
                            expanded
                                ? inputDeviceList.implicitHeight + 1
                                : 0
                        )

                    radius: 8

                    color: Colors.card

                    property bool expanded: false

                    Behavior on height {
                        NumberAnimation {
                            duration: 150
                            easing.type: Easing.OutCubic
                        }
                    }

                    // Selector header
                    Item {
                        id: inputSelectorHeader

                        anchors {
                            left: parent.left
                            right: parent.right
                            top: parent.top
                        }

                        height: 52

                        // Rectangle {
                        //     anchors.fill: parent
                        //
                        //     radius: 8
                        //
                        //     color:
                        //         inputSelectorMouse.containsMouse
                        //             ? Colors.cardHover
                        //             : "transparent"
                        //
                        //     Behavior on color {
                        //         ColorAnimation {
                        //             duration: 100
                        //         }
                        //     }
                        // }
                        //
                        Column {
                            anchors {
                                left: parent.left
                                leftMargin: 12
                                right: parent.right
                                rightMargin: 36
                                verticalCenter: parent.verticalCenter
                            }

                            spacing: 2

                            Text {
                                text: "INPUT DEVICE"

                                color: Colors.textSecondary

                                font.pixelSize: 9
                                font.bold: true

                                opacity: 0.9
                            }

                            Text {
                                width: parent.width

                                text: AudioService.sourceName

                                color: Colors.text

                                font.pixelSize: 12

                                elide: Text.ElideRight
                            }
                        }

                        Text {
                            anchors {
                                right: parent.right
                                rightMargin: 12
                                verticalCenter: parent.verticalCenter
                            }

                            text:
                                inputSelector.expanded
                                    ? "⌃"
                                    : "⌄"

                            color:
                                inputSelectorMouse.containsMouse
                                    ? Colors.accent
                                    : Colors.textSecondary

                            font.pixelSize: 15
                            font.bold: true
                        }

                        // PRESERVED selector toggle
                        MouseArea {
                            id: inputSelectorMouse

                            anchors.fill: parent

                            hoverEnabled: true

                            acceptedButtons: Qt.LeftButton

                            onClicked: {
                                inputSelector.expanded =
                                    !inputSelector.expanded
                            }
                        }
                    }

                    // Small separation below selector header
                    Rectangle {
                        anchors {
                            top: inputSelectorHeader.bottom
                            left: parent.left
                            right: parent.right
                        }

                        height: 1

                        color: Colors.popupBorder

                        visible: inputSelector.expanded
                    }

                    AudioDeviceList {
                        id: inputDeviceList

                        anchors {
                            top: parent.top
                            topMargin: 53
                            left: parent.left
                            right: parent.right
                        }

                        width: parent.width

                        output: false

                        visible: inputSelector.expanded
                    }
                }
            }
        }
    }
}
