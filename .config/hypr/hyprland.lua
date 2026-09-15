--------------------------------------------------
-- imports
--------------------------------------------------

local programs = require("lua.programs")

require("lua.environment").setup()
require("lua.monitors").setup()
require("lua.appearance").setup()
require("lua.input").setup()
require("lua.rules").setup()
require("lua.animations").setup()

require("lua.autostart").setup()

require("lua.plugins").setup()

require("lua.keybinds").setup({
	mainMod = "SUPER",
	terminal = programs.terminal,
	menu = programs.menu,
	browser1 = programs.browser1,
	browser2 = programs.browser2,
	emacs = programs.emacs,
})
