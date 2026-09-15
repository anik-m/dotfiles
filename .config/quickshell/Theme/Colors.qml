pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    FileView {
        id: colorsFile

        path: Quickshell.shellPath("Theme/colors.json")

        blockLoading: true
        watchChanges: true

        onFileChanged: reload()
    }

    // ---------------------------------------------------------
    // Raw Matugen JSON
    // ---------------------------------------------------------

    readonly property var data: JSON.parse(colorsFile.text())

    // ---------------------------------------------------------
    // Material palette
    // ---------------------------------------------------------

    readonly property color background:
        data.colors.background

    readonly property color surface:
        data.colors.surface

    readonly property color surfaceVariant:
        data.colors.surface_variant

    readonly property color surfaceContainerLowest:
        data.colors.surface_container_lowest

    readonly property color surfaceContainerLow:
        data.colors.surface_container_low

    readonly property color surfaceContainer:
        data.colors.surface_container

    readonly property color surfaceContainerHigh:
        data.colors.surface_container_high

    readonly property color surfaceContainerHighest:
        data.colors.surface_container_highest

    // ---------------------------------------------------------
    // Primary
    // ---------------------------------------------------------

    readonly property color primary:
        data.colors.primary

    readonly property color onPrimary:
        data.colors.on_primary

    readonly property color primaryContainer:
        data.colors.primary_container

    readonly property color onPrimaryContainer:
        data.colors.on_primary_container

    // ---------------------------------------------------------
    // Secondary
    // ---------------------------------------------------------

    readonly property color secondary:
        data.colors.secondary

    readonly property color onSecondary:
        data.colors.on_secondary

    // ---------------------------------------------------------
    // Foreground
    // ---------------------------------------------------------

    readonly property color onSurface:
        data.colors.on_surface

    readonly property color onSurfaceVariant:
        data.colors.on_surface_variant

    // ---------------------------------------------------------
    // Borders
    // ---------------------------------------------------------

    readonly property color outline:
        data.colors.outline

    readonly property color outlineVariant:
        data.colors.outline_variant

    // ---------------------------------------------------------
    // Error
    // ---------------------------------------------------------

    readonly property color error:
        data.colors.error

    readonly property color onError:
        data.colors.on_error

    // ---------------------------------------------------------
    // Semantic UI colors
    // ---------------------------------------------------------

    // Main text on surfaces/backgrounds
    readonly property color text:
        data.colors.on_surface

    // Secondary / less prominent text
    readonly property color textSecondary:
        data.colors.on_surface_variant

    // Accent
    readonly property color accent:
        data.colors.primary

    // Text placed directly on accent
    readonly property color accentText:
        data.colors.on_primary

    // ---------------------------------------------------------
    // Popup
    // ---------------------------------------------------------

    readonly property color popupBackground:
        data.colors.surface_container_low

    readonly property color popupBorder:
        data.colors.outline_variant

    // ---------------------------------------------------------
    // Cards
    // ---------------------------------------------------------

    readonly property color card:
        data.colors.surface_container

    readonly property color cardHover:
        data.colors.surface_container_high

    readonly property color cardSelected:
        data.colors.primary_container

    // ---------------------------------------------------------
    // Sliders
    // ---------------------------------------------------------

    readonly property color sliderBackground:
        data.colors.surface_container_highest

    readonly property color sliderFill:
        data.colors.primary
}
