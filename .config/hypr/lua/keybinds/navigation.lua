local M = {}

function M.setup(opts)
	local mod = opts.mainMod

	local directions = {
		{ key = "h", direction = "left" },
		{ key = "l", direction = "right" },
		{ key = "k", direction = "up" },
		{ key = "j", direction = "down" },

		{ key = "left", direction = "left" },
		{ key = "right", direction = "right" },
		{ key = "up", direction = "up" },
		{ key = "down", direction = "down" },
	}

	for _, item in ipairs(directions) do
		hl.bind(mod .. " + " .. item.key, hl.dsp.focus({ direction = item.direction }))
	end
end

return M
