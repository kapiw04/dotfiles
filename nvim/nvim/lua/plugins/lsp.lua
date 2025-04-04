return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup {}
			lspconfig.rust_analyzer.setup({
				diagnostics = {
					enable = true, -- Enable diagnostics
				},
				on_attach = function(client, bufnr)
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end
			})
			lspconfig.pyright.setup {}
			lspconfig.clangd.setup {
				cmd = { "/home/stud2023/3wojtowiczk/homebrew/bin/clangd" },
				on_attach = function(client, bufnr)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition)
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
				end }
		end,
	}
}
