return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
    config = function ()
        require("ibl").setup {
            indent = {
                char = "│",
                tab_char = "▏",
            },
            scope = {
                enabled = true,
                show_start = true,
                show_end = false,
                injected_languages = true
            },
            exclude = {
                filetypes = { "help", "dashboard", "lazy", "packer", "NvimTree" },
                buftypes = { "terminal", "nofile" }
            }
        }
    end
}
