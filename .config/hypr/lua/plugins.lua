local M = {}

function M.setup()
	--------------------------------------------------
	-- Hyprfocus
	--
	-- The plugin is loaded by hyprpm.
	--
	-- Current detected options:
	-- keyboard_focus_animation
	-- mouse_focus_animation
	-- animate_floating
	--------------------------------------------------

	hl.config({
		plugin = {
			hyprfocus = {
				keyboard_focus_animation = "shrink",
				mouse_focus_animation = "flash",
				animate_floating = true,
			},
		},
	})
end

return M
