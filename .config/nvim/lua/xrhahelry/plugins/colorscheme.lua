ColorCatppuccin = {
	"catppuccin/nvim",
	priority = 1000,
	name = "catppuccin",
	config = function()
		require("catppuccin").setup({
			transparent_background = false,
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

ColorOneDark = {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
        require('onedark').setup {
            style = 'dark'
        }
        require('onedark').load()
    end
}

ColorOldWorld = {
    "dgox16/oldworld.nvim",
    lazy = false,
    priority = 1000,
    config = function ()
        vim.cmd.colorscheme("oldworld")
    end
}

ColorNordic = {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('nordic').setup({
            noice = {
                style = 'flat'
            },
            telescope = {
                style = 'flat'
            },
            on_highlight = function(highlights)
                highlights.StatusLine = { fg = "#c0c8d8" }
            end,
        })
        require('nordic').load()
    end
}

return ColorNordic

