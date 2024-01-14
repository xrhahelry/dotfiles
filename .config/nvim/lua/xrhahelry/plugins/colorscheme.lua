return {
    'tanvirtin/monokai.nvim',
    priority = 1000,
    config = function ()
        require('monokai').setup{
            custom_hlgroups = {
                GitSignsChange = {
                    fg = "#fdf07f",
                    bg = "#26292c"
                }
            }
        }
        vim.cmd([[colorscheme monokai]])
    end
}
