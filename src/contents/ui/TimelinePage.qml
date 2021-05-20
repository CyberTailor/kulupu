/*
    SPDX-License-Identifier: GPL-3.0-only
    SPDX-FileCopyrightText: 2021 Anna "CyberTailor" <cyber@sysrq.in>
*/

import QtQuick 2.12
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.14 as Kirigami
import QtQuick.Controls 2.5 as Controls

Kirigami.ScrollablePage {
    id: timelinePage

    title: i18nc("@title:window", "Timeline")

    Component.onCompleted: {
        changeLayout(!isWidescreen);
    }

    actions.main: Kirigami.Action {
        id: composeAction
        icon.name: "gtk-edit"
        shortcut: StandardKey.New
        text: i18nc("@action:button", "Compose")
    }

    Kirigami.OverlaySheet {
        id: selectionOverlay
        property string text: ""

        contentItem: Controls.TextArea {
            id: selectionArea
            focus: true
            selectByMouse: true
            text: selectionOverlay.text
        }

        function copy() {
            selectionArea.selectAll();
            selectionArea.copy();
            selectionArea.deselect();
        }

        onSheetOpenChanged: if (!sheetOpen) {
            timelineView.forceActiveFocus();
        }
    }

    Kirigami.CardsListView {
        id: timelineView

        activeFocusOnTab: true

        function changeLayout(toNarrow) {
            if (toNarrow) {
                delegate = timelineDelegateNarrow;
            } else {
                delegate = timelineDelegateWide;
            }

            /* model must be reloaded, otherwise the layout is broken */
            model = 0;
            model = 100;
        }

        Component {
            id: timelineDelegateWide
            TimelineItem {
                isWidescreen: true
            }
        }

        Component {
            id: timelineDelegateNarrow
            TimelineItem {
                isWidescreen: false
            }
        }

        Kirigami.PlaceholderMessage {
            anchors.centerIn: parent
            width: parent.width - (Kirigami.Units.largeSpacing * 4)
            visible: timelineView.count === 0
            text: i18nc("@info:status", "Your timeline is empty")
            helpfulAction: Kirigami.Action {
                text: i18nc("@action:button", "Refresh")
                icon.name: "view-refresh"
            }
        }

        property bool directOrder: true
        property bool focusOnContents: false
        Keys.onPressed: {
            if (event.key == Qt.Key_Up || event.key == Qt.Key_Down) {
                focusOnContents = true;
            }
            if (event.key == Qt.Key_Home) {
                positionViewAtBeginning();
                currentIndex = 0;
                event.accepted = true;
            }
            if (event.key == Qt.Key_End) {
                positionViewAtEnd();
                currentIndex = count - 1;
                event.accepted = true;
            }
        }

        Keys.onEscapePressed: {
            timelinePage.tabbar.forceActiveFocus();
        }
    }

    property Controls.TabBar tabbar
    property bool isWidescreen: Kirigami.Settings.isMobile || appwindow.width >= Kirigami.Units.gridUnit * 25
    onIsWidescreenChanged: changeLayout(!isWidescreen)

    function changeLayout(toNarrow) {
        if (toNarrow) {
            if (header !== null) {
                header.destroy();
                header = null;
            }
            let timelineFooter = Qt.createComponent("TimelineFooter.qml");
            footer = timelineFooter.createObject(timelinePage);
            tabbar = footer;
        } else {
            if (footer !== null) {
                footer.destroy();
                footer = null;
            }
            let timelineHeader = Qt.createComponent("TimelineHeader.qml");
            header = timelineHeader.createObject(timelinePage);
            tabbar = header;
        }
        timelineView.changeLayout(toNarrow);
    }
}
