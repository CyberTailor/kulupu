/*
    SPDX-License-Identifier: GPL-3.0-only
    SPDX-FileCopyrightText: 2021 Anna "CyberTailor" <cyber@sysrq.in>
*/

import QtQuick 2.12
import org.kde.kirigami 2.14 as Kirigami
import QtQuick.Controls 2.5 as Controls

Controls.ToolButton {
    property string name

    property string iconName

    property string iconFallback: iconName

    Accessible.name: i18nc("@action:button", name)
    flat: true

    Controls.ToolTip.visible: (hovered || activeFocus)
    Controls.ToolTip.delay: Kirigami.Units.toolTipDelay
    Controls.ToolTip.text: Accessible.name

    contentItem: Kirigami.Icon {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        source: iconName
        fallback: iconFallback

        isMask: true
        selected: parent.activeFocus
        height: Kirigami.Units.iconSizes.smallMedium
    }
}
