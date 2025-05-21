return {
    "lervag/vimtex",
    lazy = false,     -- we don't want to lazy load VimTeX
    config = function()
        vim.g.vimtex_quickfix_ignore_filters = {
          'Overfull \\hbox',
          'Underfull \\hbox',
          'LaTeX Warning',
          'Package hyperref Warning',
        }
    end
}
