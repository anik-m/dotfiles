--------------------------------------------------
-- Layout keybindings
--
-- Supported layouts:
--   scrolling
--   dwindle
--   master
--   monocle
--
-- This module owns:
--   - layout cycling
--   - Rofi layout selector
--   - focus/navigation
--   - scrolling-layout operations
--
-- This module does NOT own:
--   - workspace number bindings
--   - workspace mouse-wheel switching
--   - application launchers
--   - media keys
--------------------------------------------------

local M = {}

--------------------------------------------------
-- Layout order
--------------------------------------------------

local layouts = {
	"scrolling",
	"dwindle",
	"master",
	"monocle",
}

--------------------------------------------------
-- Active layout
--------------------------------------------------

local function active_layout()
	local ws = hl.get_active_workspace()

	if not ws then
		return nil
	end

	return ws.tiled_layout
end

--------------------------------------------------
-- Dispatch only if the current workspace uses
-- the requested layout.
--------------------------------------------------

local function dispatch_if_layout(layout, dispatcher)
	return function()
		if active_layout() == layout then
			hl.dispatch(dispatcher)
		end
	end
end

--------------------------------------------------
-- Layout cycling
--------------------------------------------------

local function cycle_layout(direction)
	local current = active_layout()

	if not current then
		return
	end

	local index = 1

	for i, layout in ipairs(layouts) do
		if layout == current then
			index = i
			break
		end
	end

	index = index + direction

	if index > #layouts then
		index = 1
	elseif index < 1 then
		index = #layouts
	end

	hl.config({
		general = {
			layout = layouts[index],
		},
	})
end

--------------------------------------------------
-- Setup
--------------------------------------------------

function M.setup(opts)
	local mod = opts.mainMod or "SUPER"

	--------------------------------------------------
	-- Layout cycling
	--------------------------------------------------

	hl.bind(mod .. " + SHIFT + TAB", function()
		cycle_layout(1)
	end)

	hl.bind(mod .. " + CTRL + SHIFT + TAB", function()
		cycle_layout(-1)
	end)

	--------------------------------------------------
	-- Rofi layout selector
	--------------------------------------------------

	hl.bind(mod .. " + SHIFT + P", hl.dsp.exec_cmd("~/.local/bin/hypr-layout-menu"))

	--------------------------------------------------
	-- H / L
	--
	-- IMPORTANT:
	--
	-- These are intentionally DIRECT scrolling
	-- dispatchers.
	--
	-- We verified these exact dispatchers work on
	-- your Hyprland 0.56.2 installation:
	--
	--     focus l
	--     focus r
	--
	-- Do not replace these with hl.dsp.focus().
	--------------------------------------------------

	hl.bind(mod .. " + h", hl.dsp.layout("focus l"))

	hl.bind(mod .. " + l", hl.dsp.layout("focus r"))

	--------------------------------------------------
	-- J / K
	--
	-- Native scrolling-layout vertical focus.
	--------------------------------------------------

	hl.bind(mod .. " + j", hl.dsp.layout("focus d"))

	hl.bind(mod .. " + k", hl.dsp.layout("focus u"))

	--------------------------------------------------
	-- Arrow keys
	--
	-- Native scrolling-layout focus.
	--------------------------------------------------

	hl.bind(mod .. " + left", hl.dsp.layout("focus l"))

	hl.bind(mod .. " + right", hl.dsp.layout("focus r"))

	hl.bind(mod .. " + up", hl.dsp.layout("focus u"))

	hl.bind(mod .. " + down", hl.dsp.layout("focus d"))

	--------------------------------------------------
	-- Move/swap column left
	--------------------------------------------------

	hl.bind(mod .. " + SHIFT + h", dispatch_if_layout("scrolling", hl.dsp.layout("swapcol l")))

	--------------------------------------------------
	-- Move/swap column right
	--------------------------------------------------

	hl.bind(mod .. " + SHIFT + l", dispatch_if_layout("scrolling", hl.dsp.layout("swapcol r")))

	--------------------------------------------------
	-- Move window down
	--------------------------------------------------

	hl.bind(
		mod .. " + SHIFT + j",
		hl.dsp.window.move({
			direction = "down",
		})
	)

	--------------------------------------------------
	-- Move window up
	--------------------------------------------------

	hl.bind(
		mod .. " + SHIFT + k",
		hl.dsp.window.move({
			direction = "up",
		})
	)

	--------------------------------------------------
	-- Scrolling: first column
	--------------------------------------------------

	hl.bind(mod .. " + HOME", dispatch_if_layout("scrolling", hl.dsp.layout("fit tobeg")))

	--------------------------------------------------
	-- Scrolling: last column
	--------------------------------------------------

	hl.bind(mod .. " + END", dispatch_if_layout("scrolling", hl.dsp.layout("fit toend")))

	--------------------------------------------------
	-- Scrolling: move tape left
	--------------------------------------------------

	hl.bind(mod .. " + CTRL + h", dispatch_if_layout("scrolling", hl.dsp.layout("move -col")))

	--------------------------------------------------
	-- Scrolling: move tape right
	--------------------------------------------------

	hl.bind(mod .. " + CTRL + l", dispatch_if_layout("scrolling", hl.dsp.layout("move +col")))

	--------------------------------------------------
	-- Scrolling: next configured column width
	--------------------------------------------------

	hl.bind(mod .. " + r", dispatch_if_layout("scrolling", hl.dsp.layout("colresize +conf")))

	--------------------------------------------------
	-- Scrolling: previous configured column width
	--------------------------------------------------

	hl.bind(mod .. " + SHIFT + r", dispatch_if_layout("scrolling", hl.dsp.layout("colresize -conf")))

	--------------------------------------------------
	-- Scrolling: decrease column width
	--------------------------------------------------

	hl.bind(mod .. " + minus", dispatch_if_layout("scrolling", hl.dsp.layout("colresize -0.1")))

	--------------------------------------------------
	-- Scrolling: increase column width
	--------------------------------------------------

	hl.bind(mod .. " + equal", dispatch_if_layout("scrolling", hl.dsp.layout("colresize +0.1")))

	--------------------------------------------------
	-- Scrolling: expand current column
	--------------------------------------------------

	hl.bind(mod .. " + CTRL + f", dispatch_if_layout("scrolling", hl.dsp.layout("fit expand")))

	--------------------------------------------------
	-- Scrolling: center current column
	--------------------------------------------------

	hl.bind(mod .. " + c", dispatch_if_layout("scrolling", hl.dsp.layout("center")))

	--------------------------------------------------
	-- Scrolling: fit visible columns
	--------------------------------------------------

	hl.bind(mod .. " + CTRL + c", dispatch_if_layout("scrolling", hl.dsp.layout("fit visible")))
end

return M
