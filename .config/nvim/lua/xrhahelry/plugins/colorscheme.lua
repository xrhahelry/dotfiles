return {
    'morhetz/gruvbox',
    priority = 1000,
    config = function ()
        vim.cmd([[colorscheme gruvbox]])
    end
}
-- return {
--     -- 'tanvirtin/monokai.nvim',
--     'sainnhe/sonokai',
--     priority = 1000,
--     config = function ()
--         -- require('monokai').setup{
--         --     custom_hlgroups = {
--         --         GitSignsChange = {
--         --             fg = "#fdf07f",
--         --             bg = "#26292c"
--         --         }
--         --     }
--         -- }
--         vim.cmd([[colorscheme sonokai]])
--     end
-- }
