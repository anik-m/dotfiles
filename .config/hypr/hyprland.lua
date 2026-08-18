-- converted from hyprland.conf to lua format for hyprland 0.55+

--------------------------------------------------
-- variables
--------------------------------------------------

local terminal = "alacritty"
local filemanager = "pcmanfm"
local menu = "rofi -show drun -show-icons"
local browser1 = "firefox"
local browser2 = "brave"
local emacs = "emacsclient -c -a 'emacs'"
-- local mainmod = "SUPER"

--------------------------------------------------
-- environment variables
--------------------------------------------------

hl.env("xcursor_size", "24")
hl.env("hyprcursor_size", "24")
hl.env("xdg_session_type", "wayland")

--------------------------------------------------
-- monitors
--------------------------------------------------

hl.config({
	monitor = {
		{ name = "edp-1", mode = "preferred", position = "auto", scale = 0.75 },
	},
})

--------------------------------------------------
-- autostart
--------------------------------------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("waybar -c ~/.config/waybar/config-hypr.jsonc")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("~/.local/bin/setbg")
	hl.exec_cmd("fcitx5")
end)
-- hl.exec_once("nm-applet &")
-- -- hl.exec_once("sleep 0.01 && waybar -c ~/.config/waybar/config-hypr.jsonc & hyprpaper")
-- hl.exec_once("sleep 0.01 && waybar -c ~/.config/waybar/config-hypr.jsonc &")
-- hl.exec_once("hyprpaper")
-- hl.exec_once("~/.local/bin/setbg")
-- hl.exec_once("flameshot &")

--------------------------------------------------
-- general config
--------------------------------------------------

hl.config({

	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 2,

		col = {
			active_border = { colors = { "#88c0d0", "#81a1c1" }, angle = 45 },
			inactive_border = "#2e3440",
		},

		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 10,

		active_opacity = 1.0,
		inactive_opacity = 0.9,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,

		bezier = {
			"easeoutquint,0.23,1,0.32,1",
			"easeinoutcubic,0.65,0.05,0.36,1",
			"linear,0,0,1,1",
			"almostlinear,0.5,0.5,0.75,1.0",
			"quick,0.15,0,0.1,1",
		},

		animation = {
			"global, 1, 10, default",
			"border, 1, 5.39, easeoutquint",
			"windows, 1, 4.79, easeoutquint",
			"windowsin, 1, 4.1, easeoutquint, popin 87%",
			"windowsout, 1, 1.49, linear, popin 87%",
			"fadein, 1, 1.73, almostlinear",
			"fadeout, 1, 1.46, almostlinear",
			"fade, 1, 3.03, quick",
			"layers, 1, 3.81, easeoutquint",
			"layersin, 1, 4, easeoutquint, fade",
			"layersout, 1, 1.5, linear, fade",
			"fadelayersin, 1, 1.79, almostlinear",
			"fadelayersout, 1, 1.39, almostlinear",
			"workspaces, 1, 1.94, almostlinear, fade",
			"workspacesin, 1, 1.21, almostlinear, fade",
			"workspacesout, 1, 1.94, almostlinear, fade",
		},
	},

	dwindle = {
		preserve_split = true,
	},

	master = {
		new_status = "master",
	},

	input = {
		kb_layout = "us",
		follow_mouse = 1,
		sensitivity = 0,

		touchpad = {
			tap_button_map = "lrm",
			natural_scroll = false,
		},
	},

	device = {
		{
			name = "epic-mouse-v1",
			sensitivity = -0.5,
		},
	},
})
--------------------------------------------------
-- keybinds
--------------------------------------------------

-- launchers
hl.bind("SUPER + SHIFT + return", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + return", hl.dsp.exec_cmd(menu))

-- window management
hl.bind("SUPER + SHIFT + q", hl.dsp.window.close())
hl.bind("SUPER + SHIFT + c", hl.dsp.exec_cmd("uwsm stop"))

hl.bind("SUPER + space", hl.dsp.exec_cmd("~/.local/bin/hypr-layout-cycle"))

hl.bind("SUPER + f", hl.dsp.window.fullscreen({ mode = 1 }))

hl.bind("SUPER + SHIFT + f", hl.dsp.window.fullscreen({ mode = 0 }))

hl.bind("SUPER + v", hl.dsp.window.float({ action = "toggle" }))

hl.bind("SUPER + SHIFT + w", hl.dsp.exec_cmd(terminal .. " -e ~/.local/bin/setbg"))

hl.bind("SUPER + t", function()
	hl.bind("SUPER + t", hl.dsp.layout.toggle_split())
	hl.dsp.layout.toggle_split()
end)

--------------------------------------------------
-- focus movement
--------------------------------------------------
hl.bind("SUPER + h", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + l", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + k", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + j", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))
--------------------------------------------------
-- move windows
--------------------------------------------------

hl.bind("SUPER + SHIFT + h", function()
	hl.dsp.window.move("l")
end)
hl.bind("SUPER + SHIFT + l", function()
	hl.dsp.window.move("r")
end)
hl.bind("SUPER + SHIFT + k", function()
	hl.dsp.window.move("u")
end)
hl.bind("SUPER + SHIFT + j", function()
	hl.dsp.window.move("d")
end)

--------------------------------------------------
-- workspaces
--------------------------------------------------

for i = 2, 10 do
	local idx = i - 1
	hl.bind("SUPER + " .. idx, hl.dsp.focus({ workspace = idx }))

	hl.bind("SUPER + SHIFT + " .. idx, hl.dsp.window.move({ workspace = idx }))
end

-- map 0 to workspace 9
hl.bind("SUPER + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

--------------------------------------------------
-- workspace cycling
--------------------------------------------------

-- Get current workspace index
-- local function get_current_workspace()
-- 	local ws = hl.dsp.get_active_workspace()
-- 	return ws.index -- returns 0-based index
-- end
--
-- -- Move window to next workspace
-- hl.bind("SUPER + SHIFT + PAGE_UP", function()
-- 	local current = get_current_workspace()
-- 	local next_ws = (current + 1) % 10 -- wrap around 0-9
-- 	hl.dsp.window.move({ workspace = next_ws })
-- 	hl.dsp.focus({ workspace = next_ws })
-- end)
--
-- -- Move window to previous workspace
-- hl.bind("SUPER + SHIFT + PAGE_DOWN", function()
-- 	local current = get_current_workspace()
-- 	local prev_ws = (current - 1) % 10 -- wrap around 0-9
-- 	if prev_ws < 0 then
-- 		prev_ws = 9
-- 	end
-- 	hl.dsp.window.move({ workspace = prev_ws })
-- 	hl.dsp.focus({ workspace = prev_ws })
-- end)
--
--------------------------------------------------
-- scratchpad
--------------------------------------------------

-- Example special workspace (scratchpad)
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

--------------------------------------------------
-- mouse workspace scroll
--------------------------------------------------

-- Scroll through existing workspaces with mainMod + scroll
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/ows with mainMod + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

--------------------------------------------------
-- layout cycle
--------------------------------------------------

hl.bind("SUPER + SHIFT + tab", function()
	hl.dsp.layout.cycle_next()
end)

--------------------------------------------------
-- window cycling
--------------------------------------------------

hl.bind("SUPER + tab", function()
	hl.dsp.window.cycle()
end)

--------------------------------------------------
-- mouse drag
--------------------------------------------------

hl.bind("SUPER + mouse:272", hl.dsp.window.drag())

hl.bind("SUPER + mouse:273", hl.dsp.window.resize())

--------------------------------------------------
-- media keys
--------------------------------------------------

hl.bind("xf86audioraisevolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @default_audio_sink@ 5%+"), { repeating = true })

hl.bind("xf86audiolowervolume", hl.dsp.exec_cmd("wpctl set-volume @default_audio_sink@ 5%-"), { repeating = true })

hl.bind("xf86audiomute", hl.dsp.exec_cmd("wpctl set-mute @default_audio_sink@ toggle"), { locked = true })

hl.bind("xf86audiomicmute", hl.dsp.exec_cmd("wpctl set-mute @default_audio_source@ toggle"), { locked = true })

hl.bind("xf86monbrightnessup", hl.dsp.exec_cmd("brightnessctl s 10%+"), { repeating = true })

hl.bind("xf86monbrightnessdown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { repeating = true })

hl.bind("xf86audionext", hl.dsp.exec_cmd("playerctl next"))

hl.bind("xf86audiopause", hl.dsp.exec_cmd("playerctl play-pause"))

hl.bind("xf86audioplay", hl.dsp.exec_cmd("playerctl play-pause"))

hl.bind("xf86audioprev", hl.dsp.exec_cmd("playerctl previous"))

--------------------------------------------------
-- window rules
--------------------------------------------------
hl.config({
	windowrule = {
		"suppressevent maximize",
		"nofocus,class:.*",
	},
})
--------------------------------------------------
-- notes
--------------------------------------------------

-- if hyprland ignores hyprland.lua:
-- 1. make sure you're on hyprland 0.55+
-- 2. restart the entire hyprland session
-- 3. do not use just `hyprctl reload`
--
-- references:
-- :contentreference[oaicite:2]{index=2}
-- :contentreference[oaicite:3]{index=3}
