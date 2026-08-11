------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({
    output   = "DP-1",
    mode     = "2560x1440@240",
    position = "0x0",
    scale    = "1",
})
hl.monitor({
    output   = "DP-2",
    mode     = "1920x1080@240",
    position = "-1920x180",
    scale    = "1",
})

---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local fileManager = "nautilus --new-window"
local browser     = "firefox"
local sysmonitor  = "kitty -e 'btop'"

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

 hl.on("hyprland.start", function ()
   hl.exec_cmd("noctalia")
   hl.exec_cmd("hyprctl dispatch workspace 1")
   hl.exec_cmd("wl-clip-persist --clipboard regular")
   hl.exec_cmd("wl-paste --type text --watch cliphist store")
   hl.exec_cmd("wl-paste --type image -- watch cliphist store")
   hl.exec_cmd("openrgb")
   hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 24")
 end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("NVD_BACKEND", "direct")
hl.env("MOZ_DISABLE_RDD_SANDBOX", "1")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("NIXOS_OZONE_WL", "1")

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/


hl.config({
ecosystem = {
 -- enforce_permissions = true,
 no_update_news = true,
 no_donation_nag = true,
 },
})

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
 hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
 hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 10,
        gaps_out = 20,

        border_size = 2,

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = true,

        layout = "master",
    },

    decoration = {
        rounding       = 20,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled        = true,
            range          = 10,
            render_power   = 2,
            color          = "rgba(00000099)",
	    color_inactive = "rgba(00000099)",
        },

        blur = {
            enabled   = true,
            size      = 6,
            passes    = 4,
	        noise     = 0,
	        popups    = true,
            popups_ignorealpha = 0.45,
	        contrast  = 1,
	        xray      = false,
            vibrancy  = 0,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("smoothFast",     { type = "bezier", points = { {0.4, 0},     {0.2, 1}     } })
hl.curve("smoothSlow",     { type = "bezier", points = { {0, 0},       {0.2, 1}     } })
hl.curve("easeInSleek",    { type = "bezier", points = { {0.55, 0},    {0.1, 1}     } })
hl.curve("easeOutSleek",   { type = "bezier", points = { {0.1, 0},     {0.45, 1}    } })
hl.curve("linearSlick",    { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("softGlide",      { type = "bezier", points = { {0.3, 0},     {0.3, 1}     } })
hl.curve("gentleCurve",    { type = "bezier", points = { {0.25, 0.1},  {0.35, 0.95} } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "smoothSlow" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "smoothFast" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 2.2,  bezier = "softGlide",    style = "slide"     })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 2.2,  bezier = "softGlide",    style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 2.2,  bezier = "easeOutSleek", style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "easeInSleek" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "easeOutSleek" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "gentleCurve" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 2.1,  bezier = "softGlide",    style = "slide"     })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 2.5,  bezier = "softGlide",    style = "slide" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 2.5,  bezier = "easeOutSleek", style = "slide" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "easeInSleek" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "easeOutSleek" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 2,    bezier = "softGlide",    style = "slide" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 2,    bezier = "softGlide",    style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 2,    bezier = "easeOutSleek", style = "slide" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "gentleCurve" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "slave",
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = 0,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
    },
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "de",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",
        repeat_delay = 200,
        repeat_rate = 35,

        follow_mouse = 1,
      	accel_profile = flat,
	      force_no_accel = true,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.device({
	name = "dualsense-wireless-controller-touchpad",
	enabled = false,
})
hl.device({
	name = "sony-interactive-entertainment-dualsense-wireless-controller-touchpad",
	enabled = false,
})
hl.device({
	name = "opentabletdriver-virtual-artist-tablet",
	output = "DP-1",
})
hl.device({
	name = "wacom-one-by-wacom-s-pen",
	output = "DP-1",
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + Z", hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd(sysmonitor))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(browser))
hl.bind("CTRL + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("noctalia msg session lock"))
hl.bind("ALT + F4 ", hl.dsp.exec_cmd("hyprctl kill"))
hl.bind(mainMod .. " + ALT + C ", hl.dsp.exec_cmd("killall .nautilus-wrapped; nautilus"))
hl.bind("CTRL + SHIFT + Y", hl.dsp.exec_cmd("noctalia msg panel-toggle clipboard"))
hl.bind(mainMod .. " + CTRL + SPACE", hl.dsp.exec_cmd("noctalia msg panel-toggle wallpaper"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("noctalia msg screenshot-region"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center notifications"))
hl.bind(" ALT + TAB ", hl.dsp.exec_cmd("noctalia msg window-switcher"))
hl.bind(" SHIFT + CTRL + P ", hl.dsp.exec_cmd("noctalia msg panel-toggle oldirtty/color_picker:panel"))
hl.bind(mainMod .. " + M ", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center"))
-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + H",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + A", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + D", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + I", hl.dsp.workspace.toggle_special("Discord"))
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.window.move({ workspace = "special:Discord"}))
hl.bind(mainMod .. " + O", hl.dsp.workspace.toggle_special("OpenRGB"))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.window.move({ workspace = "special:OpenRGB"}))
hl.bind(mainMod .. " + U", hl.dsp.focus({ workspace = "name:Steam"}))
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.window.move({ workspace = "name:Steam"}))
hl.bind(mainMod .. " + SHIFT + CTRL + L", hl.dsp.window.move({ workspace = "+1" }))
hl.bind(mainMod .. " + SHIFT + CTRL + H", hl.dsp.window.move({ workspace = "-1" }))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.resize({ x = -100, y = 0, relative = true}), {repeating = true })
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.resize({ x = 0, y = 100, relative = true}), {repeating = true })
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.resize({ x = 0, y = -100, relative = true}), {repeating = true })
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.resize({ x = 100, y = 0, relative = true}), {repeating = true })


-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

hl.workspace_rule({ workspace = "1", monitor = "DP-1", default = true, persistent = true})
hl.workspace_rule({ workspace = "2", monitor = "DP-1", persistent = true})
hl.workspace_rule({ workspace = "3", monitor = "DP-1", persistent = true})
hl.workspace_rule({ workspace = "4", monitor = "DP-1", persistent = true})
hl.workspace_rule({ workspace = "5", monitor = "DP-1", persistent = true})
hl.workspace_rule({ workspace = "6", monitor = "DP-1",})
hl.workspace_rule({ workspace = "7", monitor = "DP-1",})
hl.workspace_rule({ workspace = "8", monitor = "DP-1",})
hl.workspace_rule({ workspace = "9", monitor = "DP-1",})
hl.workspace_rule({ workspace = "10", monitor = "DP-1",})
hl.workspace_rule({ workspace = "11", monitor = "DP-2", default = true, persistent = true})
hl.workspace_rule({ workspace = "12", monitor = "DP-2", persistent = true})
hl.workspace_rule({ workspace = "13", monitor = "DP-2", persistent = true})
hl.workspace_rule({ workspace = "14", monitor = "DP-2", persistent = true})
hl.workspace_rule({ workspace = "15", monitor = "DP-2", persistent = true})
hl.workspace_rule({ workspace = "16", monitor = "DP-2"})
hl.workspace_rule({ workspace = "17", monitor = "DP-2"})
hl.workspace_rule({ workspace = "18", monitor = "DP-2"})
hl.workspace_rule({ workspace = "19", monitor = "DP-2"})
hl.workspace_rule({ workspace = "20", monitor = "DP-2"})
hl.workspace_rule({ workspace = "name:Steam", monitor = "DP-1"})

hl.window_rule({
    name = "windowrule-1",
    match = { class = ".*" },
    idle_inhibit = "fullscreen",
})
hl.window_rule({
    name = "windowrule-2",
    no_focus = true,
    match = {
        class = "^$",
        title = "^$",
        xwayland = 1,
        float = 1,
        fullscreen = 0,
        pin = 0,
    },
})

hl.window_rule({
    name = "ryujinx",
    float = true,
    tile = false,
    decorate = true,
    dim_around = false,
    no_blur = true,
    match = {
        class = "^(Ryujinx)$",
    },
})

hl.window_rule({
    name = "float2",
    float = true,
    tile = false,
    decorate = true,
    dim_around = false,
    no_blur = true,
    match = {
        class = "^(Tk)$",
    },
})

hl.window_rule({
    name = "float",
    float = true,
    tile = false,
    decorate = true,
    dim_around = false,
    no_blur = true,
    match = {
        class = "^(ComboboxPopdown)$",
    },
})

hl.window_rule({
    name = "Xdg-desktop-portal-gtk",
    float = true,
    tile = false,
    decorate = false,
    dim_around = false,
    no_blur = true,
    match = {
        class = "^(Xdg-desktop-portal-gtk)$",
    },
})

hl.window_rule({
    name = "xdg-desktop-portal-gtk",
    float = true,
    tile = false,
    decorate = false,
    dim_around = false,
    no_blur = true,
    match = {
        class = "^(xdg-desktop-portal-gtk)$",
    },
})

hl.window_rule({
    name = "windowrule-10",
    opacity = "0.8",
    match = {
        class = "org.gnome.Nautilus",
    },
})

hl.window_rule({
    name = "windowrule-12",
    opacity = "0.8",
    match = {
        class = "VSCodium",
    },
})

hl.window_rule({
    name = "windowrule-13",
    workspace = "special:OpenRGB silent",
    match = {
        class = "org.openrgb.OpenRGB",
    },
})

hl.window_rule({
    name = "windowrule-14",
    workspace = "special:Discord silent",
    match = {
        class = "discord",
    },
})

hl.window_rule({
    name = "vesktop",
    workspace = "special:Discord silent",
    match = {
        class = "vesktop",
    },
})

hl.window_rule({
    name = "windowrule-15",
    workspace = "name:Steam silent",
    focus_on_activate = false,
    match = {
        class = "steam",
    },
})

hl.window_rule({
    name = "windowrule-16",
    fullscreen = true,
    match = {
        class = "^(gamescope)$",
    },
})

hl.window_rule({
    name = "windowrule-17",
    opacity = "0.8",
    match = {
        class = "codium",
    },
})

hl.window_rule({
    name = "steam-float",
    float = true,
    tile = false,
    fullscreen = false,
    decorate = false,
    rounding = 0,
    border_size = 0,
    match = {
        class = "^(steam)$",
    },
})

hl.layer_rule({
    name = "layerrule-5",
    animation = "fade",
    match = {
        namespace = "selection",
    },
})

hl.window_rule({
    name = "noctalia-settings",
    float = true,
    match = {
        class = "dev.noctalia.Noctalia",
    },
    size = {1500, 1000},
})

hl.layer_rule({
    name = "noctalia-blur",
    blur = true,
    no_anim = true,
    ignore_alpha = 0.5,
    blur_popups = true,
    match = {
        namespace = "^noctalia-(bar-|notification|dock|panel|attached-panel|osd)$"
    },
    xray = false
})

hl.layer_rule({
    name = "attached panel layer",
    blur = true,
    ignore_alpha = 0.5,
    blur_popups = true,
    match = {
        namespace = "noctalia-bar-.*"
    },
    xray = false
})

hl.layer_rule({
    name = "noctalia window switcher",
    blur = true,
    ignore_alpha = 0.3,
    blur_popups = true,
    match = {
        namespace = "^noctalia-window-switcher.*",
    },
    animation = "fade",
})

hl.layer_rule({
    name = "screenshot no anim",
    no_anim = true,
    match = {
        namespace = "noctalia-screenshot-region"
    },
})

hl.layer_rule({
    name = "no anim hyprpicker",
    no_anim = true,
    match = {
        namespace = "^hyprpicker.*",
    }
})

hl.window_rule({
   name = "swash float",
   size = {1500, 1000},
   float = true,
   match = {
     class = "^dev.lemmy.swash.*",
   }
})

-- For Noctalia Color templates
require("noctalia").apply_theme()


