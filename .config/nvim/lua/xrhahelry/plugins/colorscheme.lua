ColorCatppuccin = {
	"catppuccin/nvim",
	priority = 1000,
	name = "catppuccin",
	config = function()
		require("catppuccin").setup({
			transparent_background = false,
			color_overrides = {
				mocha = {
					base = "#000000",
					mantle = "#000000",
					crust = "#000000",
				},
			},
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

-- return {
-- 	"nvim-lualine/lualine.nvim",
-- 	dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
-- 	config = function()
-- 		require("lualine").setup({
-- 			options = {
-- 				theme = "auto",
-- 				component_separators = { left = "|", right = " " },
-- 				section_separators = { left = " ", right = " " },
-- 				disabled_filetypes = {
-- 					statusline = {
-- 						"NvimTree",
-- 						"oil",
-- 					},
-- 					winbar = {
-- 						"NvimTree",
-- 						"oil",
-- 					},
-- 					NvimTree = {},
-- 				},
-- 				ignore_focus = {},
-- 				always_divide_middle = false,
-- 				globalstatus = true,
-- 			},
-- 			sections = {
-- 				lualine_a = {},
-- 				lualine_b = { "branch", "diff", "diagnostics" },
-- 				lualine_y = {
-- 					{
-- 						function()
-- 							local msg = "No Active Lsp"
-- 							local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
-- 							local clients = vim.lsp.get_active_clients()
-- 							if next(clients) == nil then
-- 								return msg
-- 							end
-- 							for _, client in ipairs(clients) do
-- 								local filetypes = client.config.filetypes
-- 								if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
-- 									return client.name
-- 								end
-- 							end
-- 							return msg
-- 						end,
-- 						icon = " LSP:",
-- 						color = { fg = "#ffffff", gui = "bold" },
-- 					},
-- 				},
-- 				lualine_x = {},
-- 				lualine_c = {},
-- 				lualine_z = {},
-- 			},
-- 			inactive_sections = {
-- 				lualine_c = { {
-- 					"filename",
-- 					path = 2,
-- 				} },
-- 			},
-- 		})
-- 		vim.opt.laststatus = 0
-- 	end,
-- }
