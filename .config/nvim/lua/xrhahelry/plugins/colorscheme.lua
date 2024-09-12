ColorCatppuccin = {
	"catppuccin/nvim",
	priority = 1000,
	name = "catppuccin",
	config = function()
		require("catppuccin").setup({
			transparent_background = true,
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

return ColorCatppuccin
