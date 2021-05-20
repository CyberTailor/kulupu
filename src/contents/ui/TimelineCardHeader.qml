/*
    SPDX-License-Identifier: GPL-3.0-or-later
    SPDX-FileCopyrightText: 2021 Anna "CyberTailor" <cyber@sysrq.in>
*/

import QtQuick 2.12
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.14 as Kirigami
import QtQuick.Controls 2.5 as Controls

RowLayout {
    spacing: Kirigami.Units.largeSpacing

    Kirigami.Heading {
        Accessible.ignored: true
        level: 4
        font.bold: true
        text: "Test User " + modelData
        verticalAlignment: Text.AlignBottom
    }

    Kirigami.Heading {
        Accessible.ignored: true
        level: 5
        color: palette.buttonText
        text: "@local" + modelData + "@example.com"
        verticalAlignment: Text.AlignBottom
    }
}
