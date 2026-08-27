{
  config,
  pkgs,
  lib,
  ...
}: let
  tomlFormat = pkgs.formats.toml {};

  love = {
    # rose-pine love, ~#eb6f92
    alpha = 1.0;
    red = 0.922;
    green = 0.435;
    blue = 0.573;
  };

  overlay = {
    # rose-pine base, ~#1f1d2e
    alpha = 1.0;
    red = 0.122;
    green = 0.114;
    blue = 0.18;
  };

  hk = id: binding: {inherit id binding;};
  hk' = id: hk id "Unassigned";

  # niri modifier scheme translated to macOS chords. Control+Command is the mod
  # key (acts as niri's Super), so niri's Mod maps to Control+Command. niri's
  # Ctrl modifier then maps to Option (Control is already part of the mod chord):
  #   niri  Mod            -> Control+Command
  #   niri  Mod+Ctrl       -> Control+Command+Option
  #   niri  Mod+Shift      -> Control+Command+Shift
  #   niri  Mod+Ctrl+Shift -> Control+Command+Option+Shift
  mod = k: "Control+Command+${k}";
  modCtrl = k: "Control+Command+Option+${k}";
  modShift = k: "Control+Command+Shift+${k}";
  modCtrlShift = k: "Control+Command+Option+Shift+${k}";

  ws = name: id: {
    inherit name id;
    layoutType = "niri";
    monitorAssignment.type = "main";
  };

  settings = {
    monitorBarOverrides = [];
    monitorDwindleOverrides = [];
    monitorGapOverrides = [];
    monitorNiriOverrides = [];
    monitorOrientationOverrides = [];
    monitorRoutingOverrides = [];

    appearance.mode = "dark";

    borders = {
      enabled = true;
      width = 2.0;
      color = love;
    };

    clipboard = {
      historyEnabled = true;
      maxItemBytes = 8388608;
      maxItems = 200;
      maxTotalBytes = 67108864;
    };

    dwindle = {
      defaultSplitRatio = 1.0;
      moveToRootStable = true;
      singleWindowFit = "fill";
      smartSplit = false;
      splitWidthMultiplier = 1.0;
      useGlobalGaps = true;
    };

    focus = {
      crossesMonitorAtEdge = false;
      followsMouse = false;
      followsWindowToMonitor = false;
      lockModifier = "off";
      moveCrossesMonitorAtEdge = false;
      moveMouseToFocusedWindow = false;
      raiseOnMouseFocus = false;
    };

    gaps = {
      size = 10.0;
      fullscreenUsesOuterGaps = false;
      outer = {
        bottom = 0.0;
        left = 0.0;
        right = 0.0;
        top = 0.0;
      };
    };

    general = {
      animationsEnabled = true;
      defaultLayoutType = "niri";
      hotkeysEnabled = true;
      hyperKeyModifiers = "Control+Option+Shift+Command";
      ipcEnabled = false;
      preventSleepEnabled = false;
      systemHyperTrigger = "None";
      updateChecksEnabled = true;
    };

    gestures = {
      fingerCount = 3;
      invertDirection = true;
      mouseMoveModifierKey = "controlCommand";
      mouseResizeModifierKey = "controlCommand";
      scrollEnabled = true;
      scrollModifierKey = "controlShift";
      scrollSensitivity = 5.0;
      trackpadScrollStyle = "snap";
      workspaceSwipeAxis = "vertical";
      workspaceSwipeEnabled = false;
      workspaceSwipeFingerCount = 3;
    };

    hiddenBar = {
      enabled = true;
      hiddenBundleIDs = [];
      rehideIntervalSeconds = 5.0;
    };

    mouseWarp = {
      constrainToArrangement = false;
      enabled = true;
      margin = 1;
    };

    niri = {
      alwaysCenterSingleColumn = false;
      centerFocusedColumn = "never";
      containerPrimarySpanPresets = [(1.0 / 3.0) 0.5 (2.0 / 3.0)];
      defaultContainerPrimarySpan = 0.5;
      infiniteLoop = false;
      singleWindowFit = "fill";
      visibleContainerCount = 2;
    };

    overview = {
      zoom = 1.0;
      backdrop = overlay // {alpha = 0.4;};
      windowBorders = {
        hovered = love;
        normal = overlay;
        selected = love;
      };
    };

    quakeTerminal = {
      animationDuration = 0.2;
      autoHide = false;
      backgroundBlurRadius = 0;
      backgroundEffect = "standardBlur";
      enabled = false;
      heightPercent = 50.0;
      monitorMode = "focusedWindow";
      opacity = 1.0;
      position = "center";
      widthPercent = 50.0;
    };

    routing.mode = "macOS";

    statusBar = {
      showAppNames = false;
      showWorkspaceName = false;
      useWorkspaceId = false;
    };

    workspaceBar = {
      backgroundOpacity = 0.1;
      deduplicateAppIcons = false;
      enabled = true;
      excludedBundleIDs = [];
      height = 24.0;
      hideEmptyWorkspaces = false;
      iconOverrides = {};
      notchActiveZoneWidth = 180.0;
      notchMode = "moveBelowMenuBar";
      position = "overlappingMenuBar";
      reserveLayoutSpace = false;
      revealHoldMilliseconds = 200.0;
      revealModifier = "controlCommand";
      showFloatingWindows = false;
      showLabels = true;
      systemStatsButton = false;
      windowLevel = "popup";
      xOffset = 0.0;
      yOffset = 0.0;
    };

    appRules = [
      {
        bundleId = "com.openai.codex";
        id = "6A31F08A-4051-4354-B439-42F4C71894A3";
        minHeight = 600.0;
        minWidth = 800.0;
      }
      {
        bundleId = "com.eltima.cmd1.pro.mas";
        id = "4BA546DA-2875-4BEF-B13F-1539E833B1A0";
        minHeight = 550.0;
        minWidth = 950.0;
      }
      {
        bundleId = "com.google.Chrome";
        id = "486CEFA6-69AA-4A3C-AF27-BCD38F4F138B";
        minHeight = 375.0;
        minWidth = 500.0;
      }
      {
        bundleId = "dev.zed.Zed";
        id = "979F05F4-FFA2-4EDD-B23F-08A9944C759F";
        minHeight = 240.0;
        minWidth = 360.0;
      }
      {
        bundleId = "com.apple.Safari";
        id = "81426D13-C1A5-475E-AFBC-00BBA05042D0";
        minHeight = 220.0;
        minWidth = 574.0;
      }
      {
        bundleId = "app.zen-browser.zen";
        id = "1CF39647-F30D-4E76-9686-79B551F1B094";
        minHeight = 495.0;
        minWidth = 500.0;
      }
      {
        bundleId = "org.mozilla.firefox";
        id = "005C00D3-F665-47F8-BDAE-D80790E9E46B";
        minHeight = 120.0;
        minWidth = 500.0;
      }
      {
        bundleId = "company.thebrowser.dia";
        id = "C21156B1-0224-4998-97E3-8F4FA65B9F3B";
        minHeight = 420.0;
        minWidth = 500.0;
      }
      {
        bundleId = "com.spotify.client";
        id = "2DE9390B-0DB4-4D0C-9ABA-06F76F1D4EA9";
        minHeight = 600.0;
        minWidth = 800.0;
      }
      {
        bundleId = "com.hnc.Discord";
        id = "AF752D95-8497-4844-BE20-4C93E73BAEF2";
        minHeight = 500.0;
        minWidth = 800.0;
      }
      {
        bundleId = "com.mitchellh.ghostty";
        id = "7876C9EF-437E-4D4F-9C27-B1B02F4AABCE";
        minHeight = 48.0;
        minWidth = 90.0;
      }
      {
        bundleId = "com.microsoft.Outlook";
        id = "8ECAB78B-BCDD-4245-BC25-1609A49B1C86";
        minHeight = 650.0;
        minWidth = 930.0;
      }
      {
        bundleId = "com.apple.MobileSMS";
        id = "552FB77D-BF0E-4737-90A6-B5BC6986C579";
        minHeight = 320.0;
        minWidth = 660.0;
      }
    ];

    # Keybinds mirror ~/nixos/modules/home-manager/nixos/_files/niri/config.kdl.
    # See the mod/modCtrl/modShift/modCtrlShift helpers above for the
    # niri -> macOS modifier translation. OmniWM only allows one chord per
    # action id, so where niri binds both hjkl and arrows we keep hjkl.
    hotkeys = [
      # --- focus (niri: Mod + hjkl) ---
      (hk "focus.left" (mod "H"))
      (hk "focus.down" (mod "J"))
      (hk "focus.up" (mod "K"))
      (hk "focus.right" (mod "L"))
      (hk' "focusDownOrLeft")
      (hk' "focusUpOrRight")
      (hk' "focusWindowTop")
      (hk' "focusWindowBottom")
      (hk' "focusWindowDownOrTop")
      (hk' "focusWindowUpOrBottom")
      (hk' "focusWindowOrWorkspaceDown")
      (hk' "focusWindowOrWorkspaceUp")
      (hk' "focusWindowInColumn.1")
      (hk' "focusWindowInColumn.2")
      (hk' "focusWindowInColumn.3")
      (hk' "focusWindowInColumn.4")
      (hk' "focusWindowInColumn.5")
      (hk' "focusWindowInColumn.6")
      (hk' "focusWindowInColumn.7")
      (hk' "focusWindowInColumn.8")
      (hk' "focusWindowInColumn.9")

      # --- move window / column (niri: Mod+Ctrl + hjkl) ---
      (hk "moveColumn.left" (modCtrl "H"))
      (hk "moveColumn.right" (modCtrl "L"))
      (hk "move.down" (modCtrl "J"))
      (hk "move.up" (modCtrl "K"))
      (hk' "move.left")
      (hk' "move.right")
      (hk' "moveColumn.up")
      (hk' "moveColumn.down")
      (hk' "moveWindowDown")
      (hk' "moveWindowUp")
      (hk' "moveWindowDownOrToWorkspaceDown")
      (hk' "moveWindowUpOrToWorkspaceUp")
      (hk' "moveColumnToIndex.1")
      (hk' "moveColumnToIndex.2")
      (hk' "moveColumnToIndex.3")
      (hk' "moveColumnToIndex.4")
      (hk' "moveColumnToIndex.5")
      (hk' "moveColumnToIndex.6")
      (hk' "moveColumnToIndex.7")
      (hk' "moveColumnToIndex.8")
      (hk' "moveColumnToIndex.9")

      # --- column ends / consume / expel / tabs / center ---
      (hk "focusColumnFirst" (mod "Home")) # niri Mod+Home
      (hk "focusColumnLast" (mod "End")) # niri Mod+End
      (hk "moveColumnToFirst" (modCtrl "Home")) # niri Mod+Ctrl+Home
      (hk "moveColumnToLast" (modCtrl "End")) # niri Mod+Ctrl+End
      (hk "consumeWindowIntoColumn" (mod "Comma")) # niri Mod+Comma
      (hk "expelWindowFromColumn" (mod "Period")) # niri Mod+Period
      (hk "toggleColumnTabbed" (mod "G")) # niri Mod+G
      (hk "centerColumn" (mod "P")) # niri Mod+P
      (hk "centerVisibleColumns" (modCtrl "P")) # niri Mod+Ctrl+P
      (hk' "focusColumn.0")
      (hk' "focusColumn.1")
      (hk' "focusColumn.2")
      (hk' "focusColumn.3")
      (hk' "focusColumn.4")
      (hk' "focusColumn.5")
      (hk' "focusColumn.6")
      (hk' "focusColumn.7")
      (hk' "focusColumn.8")

      # --- sizing (niri: Mod+Z / Mod+Shift+Z / Mod+Ctrl+Z / Mod+Ctrl+Shift+Z, Mod+F, Mod+-/+) ---
      (hk "cycleSizeForward" (mod "Z")) # niri Mod+Z            switch-preset-column-width
      (hk "cycleSizeBackward" (modShift "Z")) # niri Mod+Shift+Z      switch-preset-column-width-back
      (hk "cycleWindowSecondarySpanForward" (modCtrlShift "Z")) # niri Mod+Ctrl+Shift+Z switch-preset-window-height
      (hk "resetWindowSecondarySpan" (modCtrl "Z")) # niri Mod+Ctrl+Z       reset-window-height
      (hk "toggleContainerFullPrimarySpan" (mod "F")) # niri Mod+F            maximize-column
      (hk "toggleFullscreen" (modShift "F")) # niri Mod+Shift+F      fullscreen-window
      (hk "expandContainerToAvailablePrimarySpan" (modCtrl "F")) # niri Mod+Ctrl+F
      (hk "setContainerPrimarySpan.decrease10Percent" (mod "Minus")) # niri Mod+Minus
      (hk "setContainerPrimarySpan.increase10Percent" (mod "Equal")) # niri Mod+Plus
      (hk "setWindowSecondarySpan.decrease10Percent" (modShift "Minus")) # niri Mod+Shift+Minus
      (hk "setWindowSecondarySpan.increase10Percent" (modShift "Equal")) # niri Mod+Shift+Plus
      (hk' "cycleWindowPrimarySpanForward")
      (hk' "cycleWindowPrimarySpanBackward")
      (hk' "cycleWindowSecondarySpanBackward")
      (hk' "setWindowPrimarySpan.decrease10Percent")
      (hk' "setWindowPrimarySpan.increase10Percent")
      (hk' "toggleNativeFullscreen")
      (hk' "moveToRoot")
      (hk' "toggleSplit")
      (hk' "swapSplit")
      (hk' "resizeGrow.horizontal")
      (hk' "resizeGrow.vertical")
      (hk' "resizeShrink.horizontal")
      (hk' "resizeShrink.vertical")
      (hk' "resizeFocusedWindow.grow")
      (hk' "resizeFocusedWindow.shrink")
      (hk' "preselect.left")
      (hk' "preselect.right")
      (hk' "preselect.up")
      (hk' "preselect.down")
      (hk' "preselectClear")

      # --- workspaces (niri: Mod+<n> / Mod+Ctrl+<n> / Mod+U/I / Mod+Ctrl+U/I) ---
      (hk "switchWorkspace.0" (mod "1"))
      (hk "switchWorkspace.1" (mod "2"))
      (hk "switchWorkspace.2" (mod "3"))
      (hk "switchWorkspace.3" (mod "4"))
      (hk "switchWorkspace.4" (mod "5"))
      (hk "switchWorkspace.5" (mod "6"))
      (hk "switchWorkspace.6" (mod "7"))
      (hk "switchWorkspace.7" (mod "8"))
      (hk "switchWorkspace.8" (mod "9"))
      (hk "moveColumnToWorkspace.0" (modCtrl "1"))
      (hk "moveColumnToWorkspace.1" (modCtrl "2"))
      (hk "moveColumnToWorkspace.2" (modCtrl "3"))
      (hk "moveColumnToWorkspace.3" (modCtrl "4"))
      (hk "moveColumnToWorkspace.4" (modCtrl "5"))
      (hk "moveColumnToWorkspace.5" (modCtrl "6"))
      (hk "moveColumnToWorkspace.6" (modCtrl "7"))
      (hk "moveColumnToWorkspace.7" (modCtrl "8"))
      (hk "moveColumnToWorkspace.8" (modCtrl "9"))
      (hk "switchWorkspace.next" (mod "U")) # niri Mod+U          focus-workspace-down
      (hk "switchWorkspace.previous" (mod "I")) # niri Mod+I          focus-workspace-up
      (hk "moveColumnToWorkspaceDown" (modCtrl "U")) # niri Mod+Ctrl+U     move-column-to-workspace-down
      (hk "moveColumnToWorkspaceUp" (modCtrl "I")) # niri Mod+Ctrl+I     move-column-to-workspace-up
      # extras (no niri equivalent, kept on free chords): move focused window to workspace <n>
      (hk "moveToWorkspace.0" (modCtrlShift "1"))
      (hk "moveToWorkspace.1" (modCtrlShift "2"))
      (hk "moveToWorkspace.2" (modCtrlShift "3"))
      (hk "moveToWorkspace.3" (modCtrlShift "4"))
      (hk "moveToWorkspace.4" (modCtrlShift "5"))
      (hk "moveToWorkspace.5" (modCtrlShift "6"))
      (hk "moveToWorkspace.6" (modCtrlShift "7"))
      (hk "moveToWorkspace.7" (modCtrlShift "8"))
      (hk "moveToWorkspace.8" (modCtrlShift "9"))
      (hk "moveWindowToWorkspaceUp" (modCtrlShift "Up Arrow"))
      (hk "moveWindowToWorkspaceDown" (modCtrlShift "Down Arrow"))
      (hk "workspaceBackAndForth" (modCtrl "Tab"))

      # --- monitors (niri: Mod+Shift + hjkl / Mod+Ctrl+Shift + hjkl, Mod+Ctrl+Shift+U/I) ---
      (hk "focusMonitorPrevious" (modShift "H")) # niri Mod+Shift+H    focus-monitor-left
      (hk "focusMonitorNext" (modShift "L")) # niri Mod+Shift+L    focus-monitor-right
      (hk "moveWindowToMonitor.left" (modCtrlShift "H")) # niri Mod+Ctrl+Shift+H
      (hk "moveWindowToMonitor.down" (modCtrlShift "J")) # niri Mod+Ctrl+Shift+J
      (hk "moveWindowToMonitor.up" (modCtrlShift "K")) # niri Mod+Ctrl+Shift+K
      (hk "moveWindowToMonitor.right" (modCtrlShift "L")) # niri Mod+Ctrl+Shift+L
      (hk "moveWorkspaceToMonitor.left" (modCtrlShift "U")) # niri Mod+Ctrl+Shift+U
      (hk "moveWorkspaceToMonitor.right" (modCtrlShift "I")) # niri Mod+Ctrl+Shift+I
      (hk "focusMonitorLast" (mod "Grave"))
      (hk' "moveWorkspaceToMonitor.up")
      (hk' "moveWorkspaceToMonitor.down")

      # --- window / misc ---
      (hk "toggleFocusedWindowFloating" (mod "V")) # niri Mod+V
      (hk "toggleOverview" (mod "O")) # niri Mod+O
      (hk "focusPrevious" (mod "Tab"))
      (hk "openCommandPalette" (modShift "P"))
      (hk "raiseAllFloatingWindows" (modShift "R"))
      (hk "balanceSizes" (modShift "B"))
      (hk "toggleWorkspaceLayout" (modShift "T"))
      (hk "openMenuAnywhere" (modCtrl "M"))
      (hk' "rescueOffscreenWindows")
      (hk' "assignFocusedWindowToScratchpad")
      (hk' "toggleScratchpadWindow")
      (hk' "toggleWorkspaceBarVisibility")
      (hk' "toggleHiddenBarPanel")
      (hk' "toggleQuakeTerminal")
      (hk' "toggleSystemStats")
    ];

    workspaces = [
      (ws "1" "AD36F001-C57E-41A5-AC1D-DF5249D007F0")
      (ws "2" "454CECD4-5E9D-4ED1-95D7-979D48817F5F")
      (ws "3" "BEB842B5-E894-4791-9FD1-397C3CDD3538")
      (ws "4" "248AA883-2261-4D45-943C-79C0E46A232B")
      (ws "5" "8B8C45D6-CE9E-41D9-BD50-BE4989D5E3DE")
      (ws "6" "5953F2BF-A378-4266-91B2-287174C4FA4D")
      (ws "7" "A7D5E104-6985-4516-8ED5-07F144F2A33D")
      (ws "8" "017275B0-01C3-43AE-904E-70EE3FBB77B8")
      (ws "9" "D6637D6C-92CB-47C4-B9DE-159C9A9114D3"
        // {
          displayName = "M";
          monitorAssignment.type = "secondary";
        })
    ];
  };

  settingsFile = tomlFormat.generate "omniwm-settings.toml" settings;
in {
  options.myModules.home-manager.programs.omniwm.enable =
    lib.mkEnableOption "enable omniwm configuration";

  config = lib.mkIf config.myModules.home-manager.programs.omniwm.enable {
    # OmniWM owns settings.toml at runtime: it rewrites the file on schema
    # migrations and GUI edits, and when it *can't* write (e.g. a read-only
    # /nix/store symlink) a single unknown/missing key makes it move the whole
    # file to settings.toml.corrupt and fall back to defaults. So instead of
    # `xdg.configFile` (a store symlink) we drop a writable copy into place on
    # every activation. This stays declarative (re-asserted each switch) while
    # letting OmniWM self-heal a future schema bump instead of corrupting.
    home.activation.omniwmSettings = lib.hm.dag.entryAfter ["writeBoundary"] ''
      _omniwm_dir="${config.xdg.configHome}/omniwm"
      run mkdir -p "$_omniwm_dir"
      run rm -f "$_omniwm_dir/settings.toml.corrupt" "$_omniwm_dir/settings.toml.corrupt.1"
      run install $VERBOSE_ARG -m 0644 ${settingsFile} "$_omniwm_dir/settings.toml"
    '';
  };
}
