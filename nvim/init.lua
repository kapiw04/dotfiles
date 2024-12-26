vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"

require("config.lazy")

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight Text when yanked",
	callback = function()
		vim.highlight.on_yank()
	end
})

vim.keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format()
end, { desc = "Format current file" })
