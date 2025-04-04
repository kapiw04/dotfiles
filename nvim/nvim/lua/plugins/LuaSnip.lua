-- lazy.nvim spec
return {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*",
	dependencies = { "rafamadriz/friendly-snippets" }, -- Optional: Load standard snippets
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load() -- Load VSCode-style snippets (like friendly-snippets)

		require("luasnip.loaders.from_lua").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })

		require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets" }) -- Load Lua snippets from a custom directory
	end,
}
