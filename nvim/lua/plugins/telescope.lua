return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags)
			vim.keymap.set("n", "<space>ff", require('telescope.builtin').find_files)
			vim.keymap.set("n", "<space>en", function()
				require('telescope.builtin').find_files {
					cwd = vim.fn.stdpath("config")
				}
			end
			)
			require('telescope').setup {
				defaults = {
					file_ignore_patterns = {
						"node_modules",
						"__pycache__/",
						".venv",
						"**/*.npz",
						"**/*.float",
						"**/*.npy",
						"**/*.hdr",
						"**/*.png",
					}
				}
			}
		end
	}
}
