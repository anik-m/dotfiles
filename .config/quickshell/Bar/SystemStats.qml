pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property real cpu: 0
    property real memory: 0
    property real temperature: 0

    property real previousTotal: 0
    property real previousIdle: 0

    Process {
        id: cpuProcess

        command: [
            "sh",
            "-c",
            "awk '/^cpu / {print $2,$3,$4,$5,$6,$7,$8,$9}' /proc/stat"
        ]

        running: true

        stdout: SplitParser {
            onRead: function(line) {
                const fields =
                    line.trim().split(/\s+/).map(Number)

                if (fields.length < 4)
                    return

                let total = 0

                for (let i = 0; i < fields.length; ++i)
                    total += fields[i]

                const idle =
                    fields[3] + fields[4]

                const totalDelta =
                    total - root.previousTotal

                const idleDelta =
                    idle - root.previousIdle

                if (root.previousTotal > 0) {
                    root.cpu =
                        totalDelta > 0
                            ? 100 *
                              (1 - idleDelta / totalDelta)
                            : 0
                }

                root.previousTotal = total
                root.previousIdle = idle
            }
        }
    }

    Process {
        id: memoryProcess

        command: [
            "sh",
            "-c",
            "free | awk '/^Mem:/ {printf \"%.2f\", $3/$2*100}'"
        ]

        running: true

        stdout: SplitParser {
            onRead: function(line) {
                root.memory = Number(line)
            }
        }
    }

    Process {
        id: temperatureProcess

        command: [
            "sh",
            "-c",
            "for f in /sys/class/thermal/thermal_zone*/temp; do cat \"$f\" 2>/dev/null; echo; done | awk 'BEGIN{max=0} {v=$1/1000; if(v>max)max=v} END{printf \"%.1f\",max}'"
        ]

        running: true

        stdout: SplitParser {
            onRead: function(line) {
                root.temperature = Number(line)
            }
        }
    }

    Timer {
        interval: 30000
        running: true
        repeat: true

        onTriggered: {
            cpuProcess.running = true
            memoryProcess.running = true
            temperatureProcess.running = true
        }
    }

    Component.onCompleted: {
        cpuProcess.running = true
        memoryProcess.running = true
        temperatureProcess.running = true
    }
}
