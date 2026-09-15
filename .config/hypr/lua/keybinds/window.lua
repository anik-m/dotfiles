local M = {}

function M.setup(opts)
	local mod = opts.mainMod

	hl.bind(mod .. " + SHIFT + q", hl.dsp.window.close())

	hl.bind(mod .. " + SHIFT + c", hl.dsp.exec_cmd("~/.local/bin/power-menu"))

	hl.bind(mod .. " + space", hl.dsp.exec_cmd("~/.local/bin/hypr-layout-cycle"))

	hl.bind(mod .. " + f", hl.dsp.window.fullscreen({ mode = 1 }))

	hl.bind(mod .. " + SHIFT + f", hl.dsp.window.fullscreen({ mode = 0 }))

	hl.bind(mod .. " + v", hl.dsp.window.float({ action = "toggle" }))

	hl.bind(mod .. " + SHIFT + w", hl.dsp.exec_cmd("~/.local/bin/setbgtheme-hypr"))

	hl.bind(mod .. " + t", function()
		hl.bind(mod .. " + t", hl.dsp.layout.toggle_split())
		hl.dsp.layout.toggle_split()
	end)

	-- Move windows
	hl.bind(mod .. " + SHIFT + h", hl.dsp.window.move({ direction = "l" }))
	hl.bind(mod .. " + SHIFT + l", hl.dsp.window.move({ direction = "r" }))
	hl.bind(mod .. " + SHIFT + k", hl.dsp.window.move({ direction = "u" }))
	hl.bind(mod .. " + SHIFT + j", hl.dsp.window.move({ direction = "d" }))
end

return M
