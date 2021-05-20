/*
    SPDX-License-Identifier: GPL-3.0-or-later
    SPDX-FileCopyrightText: 2021 Anna "CyberTailor" <cyber@sysrq.in>
*/

import QtQuick 2.12
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.14 as Kirigami
import QtQuick.Controls 2.5 as Controls

Kirigami.AbstractCard {
    id: timelineItem

    Accessible.role: Accessible.ListItem | Accessible.Button
    Accessible.description: i18nc("@action:button", "Open replies")
    Accessible.defaultButton: true

    showClickFeedback: true

    property bool isWidescreen: true
    property Kirigami.Avatar avatar: isWidescreen ? cardAvatar : cardHeader.item.avatar

    /* set correct keyboard navigation order */
    onActiveFocusChanged: if (activeFocus) {
        if (timelineView.focusOnContents) {
            cardContents.forceActiveFocus(focusReason);
            timelineView.focusOnContents = false;
        } else {
            avatar.forceActiveFocus(Qt.TabFocusReason);
        }
    }

    onClicked: {
        if (!activeFocus) {
            cardContents.forceActiveFocus();
        }
    }

    onPressAndHold: cardTextMenu.popup()

    contentItem: Item {
        implicitWidth: cardLayout.implicitWidth
        implicitHeight: cardLayout.implicitHeight
        RowLayout {
            id: cardLayout

            spacing: Kirigami.Units.largeSpacing

            anchors {
                left: parent.left
                top: parent.top
                right: parent.right
            }

            UserAvatar {
                id: cardAvatar
                visible: timelineItem.isWidescreen
            }

            ColumnLayout {
                id: cardContents

                spacing: Kirigami.Units.largeSpacing

                onActiveFocusChanged: timelineItem.highlighted = activeFocus
                KeyNavigation.tab: cardActions

                Keys.onMenuPressed: {
                    cardTextMenu.popup();
                    event.accepted = true;
                }

                Loader {
                    id: cardHeader
                    source: isWidescreen ? "TimelineCardHeader.qml" :
                                           "TimelineCardHeaderNarrow.qml"
                }

                Controls.Label {
                    id: cardText

                    Layout.fillWidth: true
                    activeFocusOnTab: true
                    wrapMode: Text.WordWrap
                    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.RightButton
                        propagateComposedEvents: true

                        onClicked: cardTextMenu.popup()
                    }
                }

                Controls.Menu {
                    id: cardTextMenu

                    Kirigami.Action {
                        text: i18nc("@action:inmenu", "Copy")
                        iconName: "edit-copy"
                        shortcut: StandardKey.Copy
                        onTriggered: {
                            selectionOverlay.text = cardText.text;
                            selectionOverlay.copy();
                        }
                    }
                    Kirigami.Action {
                        text: i18nc("@action:inmenu", "Select text…")
                        iconName: "edit-select-all"
                        onTriggered: {
                            selectionOverlay.text = cardText.text;
                            selectionOverlay.open();
                        }
                    }
                }
            }
        }
    }

    footer: FocusScope {
        id: cardActions

        implicitWidth: cardLayout.implicitWidth
        implicitHeight: Kirigami.Units.iconSizes.smallMedium

        /* set correct keyboard navigation order */
        onActiveFocusChanged: if (activeFocus) {
            if (timelineView.focusOnContents) {
                cardContents.forceActiveFocus(focusReason)
                timelineView.focusOnContents = false
            } else if (timelineView.directOrder) {
                actionReply.forceActiveFocus(focusReason)
            } else {
                actionBoost.forceActiveFocus(focusReason)
                timelineView.directOrder = true
            }
        }

        RowLayout {
            spacing: timelineItem.isWidescreen ? Kirigami.Units.largeSpacing * 2 :
                                                 Kirigami.Units.largeSpacing * 4

            anchors {
                left: parent.left
                bottom: parent.bottom
                leftMargin: timelineItem.isWidescreen ? Kirigami.Units.iconSizes.large : 0
            }

            TimelineCardButton {
                id: actionReply

                name: "Reply"
                iconName: "edit-undo"
                KeyNavigation.backtab: cardContents
            }

            TimelineCardButton {
                id: actionFav

                name: "Add to favorites"
                iconName: "emblem-favorite"
                Accessible.checkable: true
            }

            TimelineCardButton {
                id: actionBoost

                name: "Boost"
                iconName: "retweet"
                iconFallback: "media-playlist-repeat"
                Accessible.checkable: true

                /* scroll timeline on tab navigation */
                Keys.onTabPressed: timelineView.incrementCurrentIndex()
            }
        }
    }
}
