import QtQuick
import qs.Theme

Text {
    id: root

    width: 300

    text: {
        const w = NiriService.focusedWindow

        if (!w)
            return ""

        if (w.title && w.app_id)
            return w.app_id + ": " + w.title

        return w.title || w.app_id || ""
    }

    color: Colors.text

    font.pixelSize: 12

    elide: Text.ElideRight

    horizontalAlignment: Text.AlignLeft

    verticalAlignment: Text.AlignVCenter
}
