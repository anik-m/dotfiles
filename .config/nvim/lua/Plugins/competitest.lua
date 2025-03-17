return {
  'xeluxee/competitest.nvim',
  dependencies = 'MunifTanjim/nui.nvim',
  config = function()
    require('competitest').setup {
      template_file = {
        -- c = '~/path/to/file.c',
        cpp = '~/Flow/code/comp/prog.cpp',
        -- py = "~/path/to/file.py",
      },
    }
  end,
}
