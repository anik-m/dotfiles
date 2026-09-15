-- Hyprland native animations
-- Target:
-- Hyprland 0.56.2
-- Style:
-- Neon / cinematic / responsive
-- Hyprfocus is configured separately in plugins.lua.
-- Native window styles used here:
-- popin
-- gnomed
-- slide
-- Native workspace styles:
-- slidefade
-- slidefadevert

local M = {}

function M.setup()
	--------------------------------------------------
	-- Curves
	--------------------------------------------------

	--------------------------------------------------
	-- Cinematic ease
	--------------------------------------------------

	hl.curve("cinematic", {
		type = "bezier",
		points = {
			{ 0.16, 1.0 },
			{ 0.30, 1.0 },
		},
	})

	--------------------------------------------------
	-- Fast response
	--------------------------------------------------

	hl.curve("snappy", {
		type = "bezier",
		points = {
			{ 0.12, 0.8 },
			{ 0.30, 1.0 },
		},
	})

	--------------------------------------------------
	-- Smooth movement
	--------------------------------------------------

	hl.curve("smooth", {
		type = "bezier",
		points = {
			{ 0.22, 1.0 },
			{ 0.36, 1.0 },
		},
	})

	--------------------------------------------------
	-- Gentle spring
	--------------------------------------------------

	hl.curve("soft_spring", {
		type = "spring",
		mass = 1,
		stiffness = 85,
		dampening = 15,
	})

	--------------------------------------------------
	-- Snappy spring
	--------------------------------------------------

	hl.curve("snappy_spring", {
		type = "spring",
		mass = 1,
		stiffness = 150,
		dampening = 18,
	})

	--------------------------------------------------
	-- Global
	--------------------------------------------------

	hl.animation({
		leaf = "global",
		enabled = true,
		speed = 6,
		bezier = "cinematic",
	})

	--------------------------------------------------
	-- WINDOWS
	--------------------------------------------------

	--------------------------------------------------
	-- General window movement
	--
	-- Spring gives resizing/movement a little life
	-- without making everything bounce excessively.
	--------------------------------------------------

	hl.animation({
		leaf = "windows",
		enabled = true,
		speed = 5,
		spring = "soft_spring",
		style = "slide",
	})

	--------------------------------------------------
	-- Window opening
	--
	-- 82% -> 100% pop
	--------------------------------------------------

	hl.animation({
		leaf = "windowsIn",
		enabled = true,
		speed = 5,
		bezier = "snappy",
		style = "popin 82%",
	})

	--------------------------------------------------
	-- Window closing
	--
	-- GNOMED gives the close action a distinctive
	-- "collapse/disappear" effect.
	--------------------------------------------------

	hl.animation({
		leaf = "windowsOut",
		enabled = true,
		speed = 5,
		bezier = "cinematic",
		style = "gnomed",
	})

	--------------------------------------------------
	-- Window movement
	--------------------------------------------------

	hl.animation({
		leaf = "windowsMove",
		enabled = true,
		speed = 5,
		spring = "soft_spring",
	})

	--------------------------------------------------
	-- FADE
	--------------------------------------------------

	hl.animation({
		leaf = "fade",
		enabled = true,
		speed = 5,
		bezier = "snappy",
	})

	--------------------------------------------------
	-- Window fade in
	--------------------------------------------------

	hl.animation({
		leaf = "fadeIn",
		enabled = true,
		speed = 5,
		bezier = "snappy",
	})

	--------------------------------------------------
	-- Window fade out
	--------------------------------------------------

	hl.animation({
		leaf = "fadeOut",
		enabled = true,
		speed = 4,
		bezier = "snappy",
	})

	--------------------------------------------------
	-- Active window transition
	--------------------------------------------------

	hl.animation({
		leaf = "fadeSwitch",
		enabled = true,
		speed = 3,
		bezier = "snappy",
	})

	--------------------------------------------------
	-- Shadow
	--------------------------------------------------

	hl.animation({
		leaf = "fadeShadow",
		enabled = true,
		speed = 4,
		bezier = "smooth",
	})

	--------------------------------------------------
	-- Inactive window dimming
	--------------------------------------------------

	hl.animation({
		leaf = "fadeDim",
		enabled = true,
		speed = 4,
		bezier = "smooth",
	})

	--------------------------------------------------
	-- Glow
	--------------------------------------------------

	hl.animation({
		leaf = "fadeGlow",
		enabled = true,
		speed = 4,
		bezier = "smooth",
	})

	--------------------------------------------------
	-- WORKSPACES
	--------------------------------------------------

	--------------------------------------------------
	-- Main workspace transition
	--
	-- Directional movement + subtle fade.
	--------------------------------------------------

	hl.animation({
		leaf = "workspaces",
		enabled = true,
		speed = 6,
		bezier = "cinematic",
		style = "slidefade 18%",
	})

	--------------------------------------------------
	-- Workspace entering
	--------------------------------------------------

	hl.animation({
		leaf = "workspacesIn",
		enabled = true,
		speed = 6,
		bezier = "cinematic",
		style = "slidefade 18%",
	})

	--------------------------------------------------
	-- Workspace leaving
	--------------------------------------------------

	hl.animation({
		leaf = "workspacesOut",
		enabled = true,
		speed = 5,
		bezier = "cinematic",
		style = "slidefade 18%",
	})

	--------------------------------------------------
	-- Special workspace
	--------------------------------------------------

	hl.animation({
		leaf = "specialWorkspace",
		enabled = true,
		speed = 6,
		bezier = "snappy",
		style = "slidefade 22%",
	})

	hl.animation({
		leaf = "specialWorkspaceIn",
		enabled = true,
		speed = 6,
		bezier = "snappy",
		style = "slidefade 22%",
	})

	hl.animation({
		leaf = "specialWorkspaceOut",
		enabled = true,
		speed = 5,
		bezier = "snappy",
		style = "slidefade 22%",
	})

	--------------------------------------------------
	-- LAYERS
	--
	-- Rofi, notifications, etc.
	--------------------------------------------------

	hl.animation({
		leaf = "layers",
		enabled = true,
		speed = 5,
		bezier = "snappy",
		style = "popin 85%",
	})

	hl.animation({
		leaf = "layersIn",
		enabled = true,
		speed = 5,
		bezier = "snappy",
		style = "popin 85%",
	})

	hl.animation({
		leaf = "layersOut",
		enabled = true,
		speed = 4,
		bezier = "snappy",
		style = "fade",
	})

	--------------------------------------------------
	-- BORDER
	--------------------------------------------------

	hl.animation({
		leaf = "border",
		enabled = true,
		speed = 4,
		bezier = "smooth",
	})

	--------------------------------------------------
	-- BORDER GRADIENT
	--
	-- Animate only when the angle changes.
	-- Avoid loop to prevent continuous rendering.
	--------------------------------------------------

	hl.animation({
		leaf = "borderangle",
		enabled = true,
		speed = 8,
		bezier = "smooth",
		style = "once",
	})

	--------------------------------------------------
	-- SHADOW GRADIENT
	--------------------------------------------------

	hl.animation({
		leaf = "shadowangle",
		enabled = true,
		speed = 8,
		bezier = "smooth",
		style = "once",
	})

	--------------------------------------------------
	-- GLOW GRADIENT
	--------------------------------------------------

	hl.animation({
		leaf = "glowangle",
		enabled = true,
		speed = 8,
		bezier = "smooth",
		style = "once",
	})

	--------------------------------------------------
	-- SCREEN ZOOM
	--------------------------------------------------

	hl.animation({
		leaf = "zoomFactor",
		enabled = true,
		speed = 5,
		bezier = "cinematic",
	})

	--------------------------------------------------
	-- MONITOR APPEARANCE
	--------------------------------------------------

	hl.animation({
		leaf = "monitorAdded",
		enabled = true,
		speed = 6,
		bezier = "cinematic",
	})
end

return M
