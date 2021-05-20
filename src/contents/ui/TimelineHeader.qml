/*
    SPDX-License-Identifier: GPL-3.0-only
    SPDX-FileCopyrightText: 2021 Anna "CyberTailor" <cyber@sysrq.in>
*/

import QtQuick 2.12
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.14 as Kirigami
import QtQuick.Controls 2.5 as Controls

Controls.TabBar {
    id: topToolbar

    activeFocusOnTab: true
    onActiveFocusChanged: if(activeFocus) {
        currentItem.forceActiveFocus();
    }

    Controls.TabButton { text: i18nc("@title:tab", "Home") }

    Controls.TabButton { text: i18nc("@title:tab", "Local") }

    Controls.TabButton { text: i18nc("@title:tab", "Federated") }
}
