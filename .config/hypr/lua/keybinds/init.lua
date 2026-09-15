local M = {}

function M.setup(opts)
	local config = {
		mainMod = opts.mainMod or "SUPER",

		terminal = opts.terminal,
		menu = opts.menu,
		browser1 = opts.browser1,
		browser2 = opts.browser2,
		emacs = opts.emacs,
	}

	require("lua.keybinds.apps").setup(config)
	require("lua.keybinds.window").setup(config)
	require("lua.keybinds.navigation").setup(config)
	require("lua.keybinds.workspace").setup(config)
	require("lua.keybinds.layout").setup(config)
	require("lua.keybinds.mouse").setup(config)
	require("lua.keybinds.media").setup(config)
end

return M
