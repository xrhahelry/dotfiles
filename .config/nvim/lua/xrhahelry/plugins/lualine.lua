return {
    'nvim-lualine/lualine.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons', opt = true},
    config = function ()
        require('lualine').setup {
            options = {
                theme = "auto",
                component_separators = { left = '/', right = ' '},
                section_separators = { left = '', right = ''},
                disabled_filetypes = {
                    statusline = {
                        'NvimTree',
                        'oil'
                    },
                    winbar = {
                        'NvimTree',
                        'oil'
                    },
                    NvimTree = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = true,
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {
                    {
                        function()
                            local msg = 'No Active Lsp'
                            local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                            local clients = vim.lsp.get_active_clients()
                            if next(clients) == nil then
                                return msg
                            end
                            for _, client in ipairs(clients) do
                                local filetypes = client.config.filetypes
                                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                                    return client.name
                                end
                            end
                            return msg
                        end,
                        icon = ' LSP:',
                        color = { fg = '#ffffff', gui = 'bold' },
                    },
                },
                lualine_x = {'encoding'},
                lualine_y = {
                    {
                        'filetype',
                        color = { fg = '#ffffff'}
                    }},
                lualine_z = {'os.date("%I:%M")'}
            },
            inactive_sections = {
                lualine_c = {{
                    'filename',
                    path = 2
                }},
                lualine_x = {'location'},
            },
        }
    end,
}
