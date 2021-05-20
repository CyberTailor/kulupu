
/*
    SPDX-License-Identifier: GPL-3.0-only
    SPDX-FileCopyrightText: 2021 Anna "CyberTailor" <cyber@sysrq.in>
*/

import QtQuick 2.12
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.14 as Kirigami
import QtQuick.Controls 2.5 as Controls

Controls.TabBar {
    id: bottomToolbar

    activeFocusOnTab: true
    onActiveFocusChanged: if(activeFocus) {
        currentItem.forceActiveFocus();
    }

    Repeater {
        model: ListModel {
            // we can't use i18n with ListElement
            Component.onCompleted: {
                append({"index": 0,
                        "name": i18nc("@title:tab", "Home"),
                        "icon": "user-home",
                        "fallbackIcon": "go-home"});
                append({"index": 1,
                        "name": i18nc("@title:tab", "Local"),
                        "icon": "network-server",
                        "fallbackIcon": "network-workgroup"});
                append({"index": 2,
                        "name": i18nc("@title:tab", "Federated"),
                        "icon": "globe",
                        "fallbackIcon": "applications-internet"});
            }
        }

        Controls.TabButton {
            width: parent.width / model.count
            implicitHeight: toolbarButtonLayout.implicitHeight

            contentItem: FocusScope {
                ColumnLayout {
                    id: toolbarButtonLayout
                    anchors.fill: parent
                    anchors.topMargin: Kirigami.Units.smallSpacing
                    spacing: Kirigami.Units.smallSpacing

                    Kirigami.Icon {
                        source: model.icon
                        fallback: model.fallbackIcon

                        height: Kirigami.Units.iconSizes.large
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

                        isMask: true
                        selected: bottomToolbar.currentIndex == model.index
                    }

                    Controls.Label {
                        text: model.name
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                        bottomPadding: Kirigami.Units.largeSpacing
                        wrapMode: Text.WordWrap
                    }
                }
            }
        }
    }
}
