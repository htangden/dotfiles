vim.g.mapleader = " "

vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Exit insert mode' })
vim.keymap.set('c', 'jk', '<Esc>', { desc = 'Exit insert mode' })

vim.keymap.set("n", "<leader>ls", ":Ex<CR>")

vim.keymap.set('t', 'jk', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<leader>q', ':bd!<CR>', { desc = 'Close terminal' })
vim.keymap.set('n', '<leader>t', ':terminal<CR>:startinsert<CR>', { desc = 'Open terminal' })

vim.keymap.set("n", "<leader>em", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>hl", vim.cmd.nohlsearch)
vim.keymap.set("n", "<leader>rr", "<cmd>Rest run<CR>")

vim.keymap.set("n", "<leader>go", function()
  local url = vim.fn.expand("<cfile>")
  vim.fn.jobstart({"xdg-open", url}, {detach = true})
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>dc", function()
  vim.cmd("Copilot disable")
  print("Copilot disabled")
end, { noremap = true, silent = false })

vim.keymap.set("n", "<leader>ec", function()
  vim.cmd("Copilot enable")
  print("Copilot enabled")
end, { noremap = true, silent = false })

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition (LSP)" })
vim.keymap.set('n', '<leader>in', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>sh', vim.lsp.buf.signature_help)
vim.keymap.set('n', '<leader>ho', vim.lsp.buf.hover)

vim.keymap.set('n', '<leader>us', function()
  vim.lsp.buf.references({ includeDeclaration = false })
end, { desc = "Find usages of word under cursor" })

vim.keymap.set("n", "<leader>ya", "ggVGy")

vim.keymap.set({ "i", "s" }, "<C-e>", function()
	vim.snippet.stop()
end, { desc = "Manually stop snippet mode" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- JUST FOR NOW, PLEASSE REMOVE LATER
vim.keymap.set('n', '<leader>jt', ':set filetype=java<CR>', { desc = "Set filetype to java" })
