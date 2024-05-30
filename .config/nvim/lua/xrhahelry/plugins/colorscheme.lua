return {
	-- "blazkowolf/gruber-darker.nvim",
	-- "pappasam/papercolor-theme-slim",
	-- "rebelot/kanagawa.nvim",
	-- "marko-cerovac/material.nvim",
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		-- require("monokai").setup({
		-- 	custom_hlgroups = {
		-- 		GitSignsChange = {
		-- 			fg = "#fdf07f",
		-- 			bg = "#26292c",
		-- 		},
		-- 	},
		-- })
		vim.cmd("colorscheme catppuccin")
	end,
}
