return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
    config = function()
        require('lualine').setup({
            options = {
                theme = 'nordic',
                component_separators = { left = '|', right = '|'},
                section_separators = { left = '', right = ''},
                disabled_filetypes = {
                    statusline = {
                        "NvimTree",
                        "oil",
                    },
                    winbar = {
                        "NvimTree",
                        "oil",
                    },
                    NvimTree = {},
                },
                always_divide_middle = false,
                global_status = true
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_x = {
                    {
                        function()
                            local msg = "No Active Lsp"
                            local buf_ft = vim.bo.filetype -- Updated from vim.api.nvim_buf_get_option(0, "filetype")
                            local clients = vim.lsp.get_clients() -- Updated from vim.lsp.get_active_clients()
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
                        icon = " LSP:",
                        color = { fg = "#ffffff", gui = "bold" },
                    },
                    "filetype"
                },
            }
        })
    end
}
