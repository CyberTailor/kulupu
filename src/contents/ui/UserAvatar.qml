/*
    SPDX-License-Identifier: GPL-3.0-or-later
    SPDX-FileCopyrightText: 2021 Anna "CyberTailor" <cyber@sysrq.in>

    Avatar component for timeline.
*/

import QtQuick 2.12
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.14 as Kirigami
import QtQuick.Controls 2.5 as Controls

Kirigami.Avatar {
    Layout.alignment: Qt.AlignTop
    focus: activeFocus
    name: "Test User"
    cache: true

    actions.main: Kirigami.Action {
        text: i18nc("@action:button", "Open @local@example.com's profile")
    }

    /* timelineCardContents needs to be focused to make background highlit */
    KeyNavigation.tab: cardContents

    /* scroll timeline on tab navigation */
    Keys.onBacktabPressed: {
        timelineView.directOrder = false;
        timelineView.decrementCurrentIndex();
    }
}
