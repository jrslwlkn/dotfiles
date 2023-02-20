local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pp', builtin.resume, {})
vim.keymap.set('n', '<leader>pl', builtin.jumplist, {})
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>pr', builtin.registers, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function() 
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set('n', '<leader>pq', builtin.quickfixhistory, {})

local actions = require "telescope.actions"
require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
      },
    },
  }
}
