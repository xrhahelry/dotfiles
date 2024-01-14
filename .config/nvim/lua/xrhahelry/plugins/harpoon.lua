return
    {
        'ThePrimeagen/harpoon',
        branch = "harpoon2",
        config = function ()
            local harpoon = require("harpoon")

            harpoon:setup()

            vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end, { desc = "Add to harpoon"})
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

            vim.keymap.set("n", "<C-g>", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<C-d>", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<C-s>", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<C-a>", function() harpoon:list():select(4) end)
            vim.keymap.set("i", "<C-g>", function() harpoon:list():select(1) end)
            vim.keymap.set("i", "<C-d>", function() harpoon:list():select(2) end)
            vim.keymap.set("i", "<C-s>", function() harpoon:list():select(3) end)
            vim.keymap.set("i", "<C-a>", function() harpoon:list():select(4) end)


            -- Toggle previous & next buffers stored within Harpoon list
            vim.keymap.set("n", "<C-p>", function() harpoon:list():prev() end)
            vim.keymap.set("n", "<C-n>", function() harpoon:list():next() end)
        end,
    }
