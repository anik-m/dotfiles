local M = {}

function M.setup(opts)
	local mod = opts.mainMod

	hl.bind(mod .. " + SHIFT + return", hl.dsp.exec_cmd(opts.terminal))

	hl.bind(mod .. " + return", hl.dsp.exec_cmd(opts.menu))
end

return M
