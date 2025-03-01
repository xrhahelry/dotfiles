ColorCatppuccin = {
	"catppuccin/nvim",
	priority = 1000,
	name = "catppuccin",
	config = function()
		require("catppuccin").setup({
			transparent_background = false,
			-- color_overrides = {
			-- 	mocha = {
			-- 		base = "#181818",
			-- 		mantle = "#181818",
			-- 		crust = "#181818",
			-- 	},
			-- },
		})
		vim.cmd("colorscheme catppuccin")
	end,
}

ColorGruberDarker = {
	"blazkowolf/gruber-darker.nvim",
	config = function()
		vim.cmd("colorscheme gruber-darker")
	end,
}

ColorGruvbox = {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	config = function()
		vim.cmd("colorscheme gruvbox")
	end,
}

ColorRosePine = {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			variant = "auto",
			dark_variant = "moon",
		})
		vim.cmd("colorscheme rose-pine")
	end,
}

return ColorCatppuccin
