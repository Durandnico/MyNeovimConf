local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find project files' })

vim.keymap.set(
  'n', '<leader>ps',
  function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
  end,
  { desc = 'Search in project' }
)

require("telescope").setup {
  defaults = {
    file_ignore_patterns = {
      -- Ignore common directories
      ".git/",
      "vendor/",
      "bin/",
      "build/",
      "dist/",

      -- Node (JS/TS) dependencies
      "node_modules/",

      -- Python virtual environments
      ".venv/",

      -- C/C++ build directories
      "obj/",
      "eigen",

    }
  }
}
