/*
    SPDX-License-Identifier: GPL-3.0-only
    SPDX-FileCopyrightText: 2021 Anna "CyberTailor" <cyber@sysrq.in>
*/

import QtQuick 2.12
import org.kde.kirigami 2.14 as Kirigami
//import org.kde.kquickcontrolsaddons 2.0 as KQuickControlsAddons
import QtQuick.Controls 2.5 as Controls

Kirigami.ApplicationWindow {
    id: appwindow

    title: "Kulupu"

    /* cards don't look good on wide layout */
    width: Kirigami.Units.gridUnit * 40
    height: width * 1.25

    globalDrawer: Kirigami.GlobalDrawer {
        id: appwindowMenu

        actions: [
            quitAction
        ]
    }

    Shortcut {
        sequence: "F10"
        onActivated: appwindowMenu.drawerOpen = true
    }

    /*
    KQuickControlsAddons.Clipboard {
        id: clipboard
    }
    */

    TimelinePage {
        id: timelinePage
    }

    pageStack.initialPage: timelinePage
}
