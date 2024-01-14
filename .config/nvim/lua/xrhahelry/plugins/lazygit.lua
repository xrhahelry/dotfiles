return
    {
        "kdheepak/lazygit.nvim",
        config = function()
            vim.keymap.set("n", "<leader>g", "<cmd>LazyGit<CR>", { desc = "Toggle LazyGit"})
        end,
    }
