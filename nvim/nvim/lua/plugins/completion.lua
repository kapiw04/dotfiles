local blink_cmp = {
	'saghen/blink.cmp',
	dependencies = 'rafamadriz/friendly-snippets',

	version = '*',
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' for mappings similar to built-in completion
		-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
		-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
		-- See the full "keymap" documentation for information on defining your own keymap.
		keymap = { preset = 'super-tab' },

		appearance = {
			-- Sets the fallback highlight groups to nvim-cmp's highlight groups
			-- Useful for when your theme doesn't support blink.cmp
			-- Will be removed in a future release
			use_nvim_cmp_as_default = true,
			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = 'mono'
		},

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' }, },
		snippets = {
			preset = "luasnip",
		},
	},
	opts_extend = { "sources.default" }
}


local function toggle_lsp_source()
	local sources = blink_cmp.opts.sources.default
	print(vim.inspect(sources)) -- print the current sources
	
	local lsp_index = nil
	for i, source in ipairs(sources) do
		if source == 'lsp' then
			lsp_index = i
			break
		end
	end
	if lsp_index then
		table.remove(sources, lsp_index)
	else
		table.insert(sources, 'lsp')
	end
	print(vim.inspect(sources)) -- print the updated sources
end


-- Keybinding to toggle 'lsp' source
vim.keymap.set('n', '<leader>tl', toggle_lsp_source, { noremap = true, silent = true })

return blink_cmp
