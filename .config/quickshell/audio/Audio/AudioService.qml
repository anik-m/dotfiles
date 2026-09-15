pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    readonly property var sink:
        Pipewire.defaultAudioSink

    readonly property var source:
        Pipewire.defaultAudioSource

    readonly property bool ready:
        Pipewire.ready

    // Keep the default sink/source bound.
    PwObjectTracker {
        objects: [
            root.sink,
            root.source
        ]
    }

    // ============================================================
    // OUTPUT
    // ============================================================

    readonly property real volume:
        sink?.audio?.volume ?? 0

    readonly property bool muted:
        sink?.audio?.muted ?? false

    // ============================================================
    // INPUT
    // ============================================================

    readonly property real sourceVolume:
        source?.audio?.volume ?? 0

    readonly property bool sourceMuted:
        source?.audio?.muted ?? false

    // ============================================================
    // NAMES
    // ============================================================

    readonly property string sinkName:
        sink?.description ||
        sink?.nickname ||
        "No output"

    readonly property string sourceName:
        source?.description ||
        source?.nickname ||
        "No microphone"

    // ============================================================
    // OUTPUT ICON
    // ============================================================

    readonly property string volumeIcon: {
        if (muted)
            return "󰅶"

        if (volume < 0.33)
            return "󰕿"

        if (volume < 0.66)
            return "󰖀"

        return "󰕾"
    }

    // ============================================================
    // BLUETOOTH
    // ============================================================

    readonly property bool bluetooth: {
        if (!sink)
            return false

        const name =
            String(sink.name || "").toLowerCase()

        const description =
            String(sink.description || "").toLowerCase()

        const combined =
            name + " " + description

        return (
            combined.includes("bluez") ||
            combined.includes("bluetooth")
        )
    }

    // ============================================================
    // STATUS ICON
    // ============================================================

    readonly property string statusIcon: {
        if (muted)
            return "󰅶"

        if (bluetooth)
            return "󰂯"

        return volumeIcon
    }

    // ============================================================
    // INPUT ICON
    // ============================================================

    readonly property string sourceIcon:
        sourceMuted ? "󰍭" : ""

    // ============================================================
    // VOLUME CONTROL
    // ============================================================

    function setVolume(value) {
        if (sink?.audio)
            sink.audio.volume = value
    }

    function increaseVolume() {
        setVolume(
            Math.min(1, volume + 0.05)
        )
    }

    function decreaseVolume() {
        setVolume(
            Math.max(0, volume - 0.05)
        )
    }

    function toggleMute() {
        if (sink?.audio)
            sink.audio.muted = !sink.audio.muted
    }

    // ============================================================
    // INPUT VOLUME CONTROL
    // ============================================================

    function setSourceVolume(value) {
        if (source?.audio)
            source.audio.volume = value
    }

    function increaseSourceVolume() {
        setSourceVolume(
            Math.min(1, sourceVolume + 0.05)
        )
    }

    function decreaseSourceVolume() {
        setSourceVolume(
            Math.max(0, sourceVolume - 0.05)
        )
    }

    // ============================================================
    // DEVICE SELECTION
    // ============================================================

    function setOutput(node) {
        if (node)
            Pipewire.preferredDefaultAudioSink = node
    }

    function setInput(node) {
        if (node)
            Pipewire.preferredDefaultAudioSource = node
    }
}
