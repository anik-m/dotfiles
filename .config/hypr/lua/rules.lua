local M = {}

function M.setup()
	hl.config({
		windowrule = {
			"suppressevent maximize",
			"nofocus,class:.*",
		},
	})
end

return M
