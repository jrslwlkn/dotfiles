vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "x", [["_x]])

vim.keymap.set("n", "<leader>d", [["_d]])
vim.keymap.set("n", "<leader>D", [["_D]])
vim.keymap.set("v", "<leader>d", [["_d]])

vim.keymap.set("n", "<leader>c", [["_c]])
vim.keymap.set("n", "<leader>C", [["_C]])
vim.keymap.set("v", "<leader>c", [["_c]])

vim.keymap.set("n", "<leader>y", [["*y]])
vim.keymap.set("v", "<leader>y", [["*y]])

vim.keymap.set("v", "<leader>p", [["_dP]])

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("v", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

