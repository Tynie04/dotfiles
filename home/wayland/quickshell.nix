{ inputs, pkgs, lib, ... }:
{
  home.packages = [
    inputs.quickshell.packages.${pkgs.system}.default
    inputs.caelestia-shell.packages.${pkgs.system}.default
    inputs.caelestia-cli.packages.${pkgs.system}.default
  ];

  # Seed caelestia shell.json only if it doesn't exist yet (caelestia needs to write to it)
  home.activation.caelestiaConfig = let
    defaultConfig = builtins.toJSON {
      appearance.transparency.enabled = false;
      background.wallpaperEnabled = true;
      bar = {
        activeWindow = { compact = true; inverted = false; showOnHover = false; };
        clock = { background = false; showDate = false; };
        dragThreshold = 10;
        persistent = false;
        popouts.activeWindow = false;
        showOnHover = true;
        statusIcons = [
          { enabled = true;  id = "lockStatus"; }
          { enabled = false; id = "audio"; }
          { enabled = true;  id = "microphone"; }
          { enabled = false; id = "kbLayout"; }
          { enabled = true;  id = "network"; }
          { enabled = true;  id = "bluetooth"; }
          { enabled = true;  id = "battery"; }
        ];
        tray = { background = false; compact = false; recolour = false; };
        workspaces = { showWindows = false; showWindowsOnSpecialWorkspaces = false; };
      };
      border.thickness = 2;
      dashboard.dragThreshold = 50;
      general.apps = { explorer = [ "dolphin" ]; terminal = [ "kitty" ]; };
      launcher = { enabled = true; showOnHover = true; useFuzzy = { actions = false; apps = false; }; vimKeybinds = false; };
      services = { smartScheme = true; useFahrenheit = false; useTwelveHourClock = false; };
      sidebar.dragThreshold = 20;
      utilities.quickToggles = [
        { enabled = true;  id = "wifi"; }
        { enabled = true;  id = "bluetooth"; }
        { enabled = true;  id = "mic"; }
        { enabled = true;  id = "settings"; }
        { enabled = true;  id = "gameMode"; }
        { enabled = true;  id = "dnd"; }
        { enabled = false; id = "vpn"; }
      ];
    };
  in lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -f "$HOME/.config/caelestia/shell.json" ]; then
      mkdir -p "$HOME/.config/caelestia"
      echo '${defaultConfig}' > "$HOME/.config/caelestia/shell.json"
    fi
  '';

  # Patched caelestia Content.qml with display settings button
  xdg.configFile."quickshell/caelestia/modules/utilities/Content.qml" = {
    force = true;
    text = ''
      pragma ComponentBehavior: Bound

      import "cards"
      import QtQuick
      import QtQuick.Layouts
      import Quickshell
      import Caelestia.Config
      import qs.components
      import qs.components.controls
      import qs.services
      import qs.modules.bar.popouts as BarPopouts

      Item {
          id: root

          required property var props
          required property ScreenState screenState
          required property BarPopouts.Wrapper popouts
          required property matrix4x4 deformMatrix

          readonly property int enabledCards: (idleInhibit.active ? 1 : 0) + (record.active ? 1 : 0) + (toggles.active ? 1 : 0) + 1
          readonly property real nonAnimHeight: ((idleInhibit.item as IdleInhibit)?.nonAnimHeight ?? 0) + ((record.item as Record)?.nonAnimHeight ?? 0) + ((toggles.item as Toggles)?.implicitHeight ?? 0) + 48 + layout.spacing * Math.max(0, enabledCards - 1)

          implicitWidth: layout.implicitWidth
          implicitHeight: layout.implicitHeight

          ColumnLayout {
              id: layout

              anchors.fill: parent
              spacing: Tokens.spacing.medium

              Loader {
                  id: idleInhibit
                  Layout.fillWidth: true
                  active: Config.utilities.cards.keepAwake
                  visible: active
                  sourceComponent: IdleInhibit { objectName: "utilitiesKeepAwake" }
              }

              Loader {
                  id: record
                  Layout.fillWidth: true
                  active: Config.utilities.cards.recorder
                  visible: active
                  z: 1
                  sourceComponent: Record {
                      objectName: "utilitiesScreenRecorder"
                      props: root.props
                      screenState: root.screenState
                  }
              }

              Loader {
                  id: toggles
                  Layout.fillWidth: true
                  active: Config.utilities.cards.quickToggles
                  visible: active
                  sourceComponent: Toggles {
                      objectName: "utilitiesQuickToggles"
                      screenState: root.screenState
                      popouts: root.popouts
                  }
              }

              StyledRect {
                  Layout.fillWidth: true
                  implicitHeight: 48
                  radius: Tokens.rounding.large
                  color: Colours.tPalette.m3surfaceContainer

                  RowLayout {
                      anchors.fill: parent
                      anchors.margins: Tokens.padding.large

                      StyledText {
                          text: qsTr("Display Settings")
                          font: Tokens.font.body.medium
                          Layout.fillWidth: true
                      }

                      IconButton {
                          icon: "display_settings"
                          isRound: true
                          onClicked: {
                              const proc = Qt.createQmlObject(
                                  "import Quickshell; import Quickshell.Io; Process { command: [\"nwg-displays\"]; running: true }",
                                  root);
                          }
                      }
                  }
              }
          }

          RecordingDeleteModal {
              props: root.props
              deformMatrix: root.deformMatrix
          }
      }
    '';
  };

  # Toggle between caelestia (default) and waybar fallback
  home.file.".local/bin/toggle-caelestia.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env sh
      if pgrep -f "quickshell" >/dev/null; then
        pkill -f quickshell
        sleep 0.5
        waybar &
        dunst &
      else
        pkill -x waybar
        pkill -x dunst
        sleep 0.5
        caelestia-shell &
      fi
    '';
  };
}
