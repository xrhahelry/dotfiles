return {
    "folke/zen-mode.nvim",
    config = function()
        require("zen-mode").setup {
            window = {
                backdrop = 1,
                width = 90,
                options = {
                    signcolumn = "no",
                    number = true,
                    relativenumber = true,
                    cursorline = true,
                },
            },
            plugins = {
                tmux = { enabled = true },
                twilight = { enabled = true }
            },
        }
        vim.keymap.set("n", '<leader>z', function()
            require("zen-mode").toggle()
        end,
        { desc = "Toggle Zen mode" })
    end
}
