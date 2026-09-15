import QtQuick
import Quickshell.Services.UPower
import qs.Theme

Text {
    id: root

    readonly property var battery:
        UPower.displayDevice

    readonly property real percentage:
        battery?.percentage ?? 0

    readonly property bool charging:
        battery?.state === UPowerDeviceState.Charging ||
        battery?.state === UPowerDeviceState.PendingCharge

    readonly property string icon: {
        if (charging)
            return "󰂄"

        if (percentage >= 95)
            return "󰁹"

        if (percentage >= 85)
            return "󰂂"

        if (percentage >= 75)
            return "󰂁"

        if (percentage >= 65)
            return "󰂀"

        if (percentage >= 55)
            return "󰁿"

        if (percentage >= 45)
            return "󰁾"

        if (percentage >= 35)
            return "󰁽"

        if (percentage >= 25)
            return "󰁼"

        if (percentage >= 15)
            return "󰁻"

        return "󰁺"
    }

    text:
        icon + " " +
        Math.round(percentage) + "%"

    color:
        percentage <= 15
            ? Colors.accent
            : Colors.text

    font.pixelSize: 12
}
