local M = {}

function M.setup(opts)
	local mod = opts.mainMod

	hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })

	hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
end

return M
