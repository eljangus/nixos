{
  osConfig,
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
    };

    gaps = {
      size = 10.0;
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

    hotkeys = [
      (hk "switchWorkspace.0" "Control+Command+1")
      (hk "moveToWorkspace.0" "Control+Option+Shift+1")
      (hk "switchWorkspace.1" "Control+Command+2")
      (hk "moveToWorkspace.1" "Control+Option+Shift+2")
      (hk "switchWorkspace.2" "Control+Command+3")
      (hk "moveToWorkspace.2" "Control+Option+Shift+3")
      (hk "switchWorkspace.3" "Control+Command+4")
      (hk "moveToWorkspace.3" "Control+Option+Shift+4")
      (hk "switchWorkspace.4" "Control+Command+5")
      (hk "moveToWorkspace.4" "Control+Option+Shift+5")
      (hk "switchWorkspace.5" "Control+Command+6")
      (hk "moveToWorkspace.5" "Control+Option+Shift+6")
      (hk "switchWorkspace.6" "Control+Command+7")
      (hk "moveToWorkspace.6" "Control+Option+Shift+7")
      (hk "switchWorkspace.7" "Control+Command+8")
      (hk "moveToWorkspace.7" "Control+Option+Shift+8")
      (hk "switchWorkspace.8" "Control+Command+9")
      (hk "moveToWorkspace.8" "Control+Option+Shift+9")
      (hk "workspaceBackAndForth" "Control+Option+Tab")
      (hk "switchWorkspace.next" "Control+Command+U")
      (hk "switchWorkspace.previous" "Control+Command+I")
      (hk "focus.left" "Control+Command+H")
      (hk "focus.down" "Control+Command+J")
      (hk "focus.up" "Control+Command+K")
      (hk "focus.right" "Control+Command+L")
      (hk "focusPrevious" "Control+Command+Tab")
      (hk' "focusDownOrLeft")
      (hk' "focusUpOrRight")
      (hk' "focusWindowTop")
      (hk' "focusWindowBottom")
      (hk' "focusWindowDownOrTop")
      (hk' "focusWindowUpOrBottom")
      (hk' "focusWindowOrWorkspaceDown")
      (hk' "focusWindowOrWorkspaceUp")
      (hk "centerColumn" "Control+Command+Shift+P")
      (hk "centerVisibleColumns" "Control+Option+P")
      (hk "moveWindowToWorkspaceUp" "Control+Option+Shift+Up Arrow")
      (hk "moveWindowToWorkspaceDown" "Control+Option+Shift+Down Arrow")
      (hk "moveColumnToWorkspaceUp" "Control+Option+I")
      (hk "moveColumnToWorkspaceDown" "Control+Option+U")
      (hk "moveColumnToWorkspace.0" "Control+Option+1")
      (hk "moveColumnToWorkspace.1" "Control+Option+2")
      (hk "moveColumnToWorkspace.2" "Control+Option+3")
      (hk "moveColumnToWorkspace.3" "Control+Option+4")
      (hk "moveColumnToWorkspace.4" "Control+Option+5")
      (hk "moveColumnToWorkspace.5" "Control+Option+6")
      (hk "moveColumnToWorkspace.6" "Control+Option+7")
      (hk "moveColumnToWorkspace.7" "Control+Option+8")
      (hk "moveColumnToWorkspace.8" "Control+Option+9")
      (hk' "move.left")
      (hk "move.down" "Control+Option+J")
      (hk "move.up" "Control+Option+K")
      (hk' "move.right")
      (hk' "moveWindowDown")
      (hk' "moveWindowUp")
      (hk' "moveWindowDownOrToWorkspaceDown")
      (hk' "moveWindowUpOrToWorkspaceUp")
      (hk "consumeOrExpelWindowLeft" "Control+Command+A")
      (hk "consumeOrExpelWindowRight" "Control+Command+D")
      (hk "consumeWindowIntoColumn" "Control+Command+Comma")
      (hk "expelWindowFromColumn" "Control+Command+Period")
      (hk "focusMonitorNext" "Control+Command+Shift+L")
      (hk "focusMonitorPrevious" "Control+Command+Shift+H")
      (hk "focusMonitorLast" "Control+Command+Grave")
      (hk "moveWorkspaceToMonitor.left" "Control+Option+Shift+U")
      (hk "moveWorkspaceToMonitor.right" "Control+Option+Shift+I")
      (hk' "moveWorkspaceToMonitor.up")
      (hk' "moveWorkspaceToMonitor.down")
      (hk "toggleFullscreen" "Control+Command+Shift+F")
      (hk' "toggleNativeFullscreen")
      (hk "moveColumn.left" "Control+Option+H")
      (hk "moveColumn.right" "Control+Option+L")
      (hk' "moveColumn.up")
      (hk' "moveColumn.down")
      (hk "moveColumnToFirst" "Control+Option+Home")
      (hk "moveColumnToLast" "Control+Option+End")
      (hk "toggleColumnTabbed" "Control+Command+G")
      (hk "focusColumnFirst" "Control+Command+Home")
      (hk "focusColumnLast" "Control+Command+End")
      (hk' "focusColumn.0")
      (hk' "focusColumn.1")
      (hk' "focusColumn.2")
      (hk' "focusColumn.3")
      (hk' "focusColumn.4")
      (hk' "focusColumn.5")
      (hk' "focusColumn.6")
      (hk' "focusColumn.7")
      (hk' "focusColumn.8")
      (hk' "focusWindowInColumn.1")
      (hk' "focusWindowInColumn.2")
      (hk' "focusWindowInColumn.3")
      (hk' "focusWindowInColumn.4")
      (hk' "focusWindowInColumn.5")
      (hk' "focusWindowInColumn.6")
      (hk' "focusWindowInColumn.7")
      (hk' "focusWindowInColumn.8")
      (hk' "focusWindowInColumn.9")
      (hk' "moveColumnToIndex.1")
      (hk' "moveColumnToIndex.2")
      (hk' "moveColumnToIndex.3")
      (hk' "moveColumnToIndex.4")
      (hk' "moveColumnToIndex.5")
      (hk' "moveColumnToIndex.6")
      (hk' "moveColumnToIndex.7")
      (hk' "moveColumnToIndex.8")
      (hk' "moveColumnToIndex.9")
      (hk "cycleSizeForward" "Control+Command+Y")
      (hk "cycleSizeBackward" "Control+Command+Shift+Y")
      (hk' "cycleWindowPrimarySpanForward")
      (hk' "cycleWindowPrimarySpanBackward")
      (hk "cycleWindowSecondarySpanForward" "Control+Option+Shift+Y")
      (hk' "cycleWindowSecondarySpanBackward")
      (hk "toggleContainerFullPrimarySpan" "Control+Command+F")
      (hk "expandContainerToAvailablePrimarySpan" "Control+Option+F")
      (hk "resetWindowSecondarySpan" "Control+Option+Y")
      (hk "setContainerPrimarySpan.decrease10Percent" "Control+Command+Minus")
      (hk "setContainerPrimarySpan.increase10Percent" "Control+Command+Equal")
      (hk' "setWindowPrimarySpan.decrease10Percent")
      (hk' "setWindowPrimarySpan.increase10Percent")
      (hk "setWindowSecondarySpan.decrease10Percent" "Control+Option+Shift+Minus")
      (hk "setWindowSecondarySpan.increase10Percent" "Control+Option+Shift+Equal")
      (hk "balanceSizes" "Control+Command+Shift+B")
      (hk' "moveToRoot")
      (hk' "toggleSplit")
      (hk' "swapSplit")
      (hk' "resizeGrow.left")
      (hk' "resizeGrow.right")
      (hk' "resizeGrow.up")
      (hk' "resizeGrow.down")
      (hk' "resizeShrink.left")
      (hk' "resizeShrink.right")
      (hk' "resizeShrink.up")
      (hk' "resizeShrink.down")
      (hk' "resizeFocusedWindow.grow")
      (hk' "resizeFocusedWindow.shrink")
      (hk' "preselect.left")
      (hk' "preselect.right")
      (hk' "preselect.up")
      (hk' "preselect.down")
      (hk' "preselectClear")
      (hk "openCommandPalette" "Control+Command+P")
      (hk "raiseAllFloatingWindows" "Control+Command+Shift+R")
      (hk' "rescueOffscreenWindows")
      (hk "toggleFocusedWindowFloating" "Control+Command+V")
      (hk' "assignFocusedWindowToScratchpad")
      (hk' "toggleScratchpadWindow")
      (hk "openMenuAnywhere" "Control+Option+M")
      (hk' "toggleWorkspaceBarVisibility")
      (hk' "toggleHiddenBarPanel")
      (hk' "toggleQuakeTerminal")
      (hk "toggleWorkspaceLayout" "Control+Command+Shift+T")
      (hk "toggleOverview" "Control+Command+O")
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
in {
  config = lib.mkIf osConfig.myModules.home-manager.programs.omniwm.enable {
    xdg.configFile."omniwm/settings.toml".source = tomlFormat.generate "omniwm-settings.toml" settings;
    homebrew.taps = ["BarutSRB/tap"];
    homebrew.casks = ["BarutSRB/tap/omniwm"];
  };
}
