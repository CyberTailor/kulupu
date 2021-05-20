/*
    SPDX-License-Identifier: GPL-3.0-only
    SPDX-FileCopyrightText: 2021 Anna "CyberTailor" <cyber@sysrq.in>
*/

import QtQuick 2.12
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.14 as Kirigami
import QtQuick.Controls 2.5 as Controls

Kirigami.Page {
    id: loginPage

    title: i18nc("@title:window", "Login")

    Kirigami.FormLayout {
        Controls.TextField {
            id: userIdField
            focus: true

            Kirigami.FormData.label: i18nc("@label:textbox", "User ID:")
            placeholderText: "@johndoe@example.org"
            inputMethodHints: Qt.ImhPreferLowercase
            validator: RegExpValidator{ regExp: /^@[^@]+@[^@]+$/ }
        }

        Controls.Button {
            Layout.fillWidth: true
            text: i18nc("@action:button", "Authorize")
            enabled: userIdField.acceptableInput
        }
    }
}
