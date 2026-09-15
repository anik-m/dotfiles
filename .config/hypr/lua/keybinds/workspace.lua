local M = {}

function M.setup(opts)
	local mod = opts.mainMod

	--------------------------------------------------
	-- workspaces 1-9
	--------------------------------------------------

	for ws = 1, 9 do
		hl.bind(mod .. " + " .. ws, hl.dsp.focus({ workspace = ws }))

		hl.bind(mod .. " + SHIFT + " .. ws, hl.dsp.window.move({ workspace = ws }))
	end

	--------------------------------------------------
	-- workspace 10
	--------------------------------------------------

	hl.bind(mod .. " + 0", hl.dsp.focus({ workspace = 10 }))

	hl.bind(mod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

	--------------------------------------------------
	-- special workspace
	--------------------------------------------------

	hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("magic"))

	hl.bind(
		mod .. " + SHIFT + S",
		hl.dsp.window.move({
			workspace = "special:magic",
		})
	)

	--------------------------------------------------
	-- workspace scrolling
	--------------------------------------------------

	hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))

	hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
end

return M
