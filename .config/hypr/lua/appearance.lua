local matugen = require("matugen-colors")

local M = {}

function M.setup()
	hl.config({
		general = {
			gaps_in = 5,
			gaps_out = 10,
			border_size = 2,

			col = {
				active_border = {
					colors = {
						matugen.primary,
						matugen.secondary,
					},
					angle = 45,
				},

				inactive_border = matugen.outline,
			},

			resize_on_border = false,
			allow_tearing = false,

			-- Default layout.
			-- Use SUPER + SHIFT + TAB to switch layouts.
			layout = "dwindle",
		},

		decoration = {
			rounding = 10,

			-- active_opacity = 0.95,
			-- inactive_opacity = 0.9,

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

		--------------------------------------------------
		-- Niri-style scrolling layout
		--------------------------------------------------

		scrolling = {
			fullscreen_on_one_column = true,
			column_width = 0.5,

			-- IMPORTANT
			focus_fit_method = 0,

			follow_focus = true,
			follow_min_visible = 0.4,

			explicit_column_widths = "0.333, 0.5, 0.667, 1.0",

			-- wrap_focus = true,
			-- wrap_swapcol = true,

			direction = "right",
		},
		-- scrolling = {
		-- 	-- One window fills the workspace.
		-- 	fullscreen_on_one_column = true,
		--
		-- 	-- Default column width = 50% of the screen.
		-- 	column_width = 0.5,
		--
		-- 	-- Keep focused column properly visible.
		-- 	-- 0 = center
		-- 	-- 1 = fit
		-- 	focus_fit_method = 1,
		--
		-- 	-- Automatically scroll the tape when focus changes.
		-- 	follow_focus = true,
		--
		-- 	-- Focus must have at least this much visible
		-- 	-- before soft focus movement follows it.
		-- 	follow_min_visible = 0.4,
		--
		-- 	-- Used by colresize +conf / -conf.
		-- 	explicit_column_widths = "0.333, 0.5, 0.667, 1.0",
		--
		-- 	-- h/l wraps around at the ends.
		-- 	wrap_focus = true,
		--
		-- 	-- Swapping at either end wraps around.
		-- 	wrap_swapcol = true,
		--
		-- 	-- New windows appear to the right.
		-- 	direction = "right",
		-- },
	})
end

return M
