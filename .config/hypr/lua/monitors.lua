local M = {}

function M.setup()
	hl.config({
		monitor = {
			{
				name = "edp-1",
				mode = "preferred",
				position = "auto",
				scale = 0.5,
			},
		},
	})
end

return M
