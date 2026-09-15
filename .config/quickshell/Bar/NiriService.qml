pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property var workspaces: []
    property var windows: []
    property var focusedWindow: null

    Process {
        id: eventStream

        command: [
            "niri",
            "msg",
            "--json",
            "event-stream"
        ]

        running: true

        stdout: SplitParser {
            onRead: function(line) {
                try {
                    const event = JSON.parse(line)

                    if (event.WorkspacesChanged !== undefined) {
                        root.workspaces =
                            event.WorkspacesChanged.workspaces || []
                    }

                    else if (
                        event.WindowOpenedOrChanged !== undefined
                    ) {
                        refreshWindows.running = true
                    }

                    else if (
                        event.WindowClosed !== undefined
                    ) {
                        refreshWindows.running = true
                    }

                    else if (
                        event.WindowFocusChanged !== undefined
                    ) {
                        refreshFocusedWindow.running = true
                    }
                }

                catch (error) {
                    console.warn(
                        "Niri event parse error:",
                        error
                    )
                }
            }
        }
    }

    Process {
        id: refreshWindows

        command: [
            "niri",
            "msg",
            "--json",
            "windows"
        ]

        running: false

        stdout: SplitParser {
            onRead: function(line) {
                try {
                    root.windows = JSON.parse(line)
                }
                catch (error) {
                    console.warn(
                        "Niri windows parse error:",
                        error
                    )
                }
            }
        }
    }

    Process {
        id: refreshFocusedWindow

        command: [
            "niri",
            "msg",
            "--json",
            "focused-window"
        ]

        running: false

        stdout: SplitParser {
            onRead: function(line) {
                try {
                    root.focusedWindow = JSON.parse(line)
                }
                catch (error) {
                    console.warn(
                        "Niri focused window parse error:",
                        error
                    )
                }
            }
        }
    }

    Component.onCompleted: {
        refreshWindows.running = true
        refreshFocusedWindow.running = true
    }
}
