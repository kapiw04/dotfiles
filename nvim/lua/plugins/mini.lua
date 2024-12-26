return {
	{
		'echasnovski/mini.nvim',
		version = false,
		config = function()
			local statusline = require 'mini.statusline'
			require('mini.comment').setup()
			require('mini.trailspace').setup()
			statusline.setup { use_icons = true }
		end
	}
}
