local M = {}

function M.setup()
	hl.config({
		input = {
			kb_layout = "us",
			follow_mouse = 2,
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
end

return M
