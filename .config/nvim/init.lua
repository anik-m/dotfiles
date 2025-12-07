--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

    after understanding a bit more about lua, you can use `:help lua-guide` as a
    reference for how neovim integrates lua.
    - :help lua-guide
    - (or html version): https://neovim.io/doc/user/lua-guide.html

kickstart guide:

  todo: the very first thing you should do is to run the command `:tutor` in neovim.

    if you don't know what this means, type the following:
      - <escape key>
      - :
      - tutor
      - <enter key>

    (if you already know the neovim basics, you can skip this step.)

  once you've completed that, you can continue working through **and reading** the rest
  of the kickstart init.lua.

  next, run and read `:help`.
    this will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    this should be the first place you go to look when you're stuck or confused
    with something. it's one of my favorite neovim features.

    most importantly, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  i have left several `:help x` comments throughout the init.lua
    these are hints about where to find more information about the relevant settings,
    plugins or neovim features used in kickstart.

   note: look for lines like this

    throughout the file. these are for you, the reader, to help you understand what is happening.
    feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your neovim config.

if you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

i hope you enjoy your neovim journey,
- tj

p.s. you can delete this when you're done too. it's your config now! :)
--]]

require 'config.lazy'

-- -- -- [[ setting options ]]
require 'options'
-- --
-- -- -- [[ basic keymaps ]]
require 'keymaps'

--
--

-- -- The line beneath this is called `modeline`. See `:help modeline`
-- -- vim: ts=2 sts=2 sw=2 et
