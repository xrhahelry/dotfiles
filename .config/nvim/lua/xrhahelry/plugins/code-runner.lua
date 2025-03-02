return {
    "CRAG666/code_runner.nvim",
    dependencies = {
        "preservim/vimux",
    },
    config = function ()
        require('code_runner').setup({
            mode = "vimux",
            filetype = {
                haskell = "cd $dir && runghc $fileName",
                julia = "cd $dir && julia $fileName",
                python = "python -u '$dir/$fileName'",
            }
        })
        vim.keymap.set('n', '<leader>rf', function()
            require('code_runner').run_code()
        end,
        { noremap = true, silent = false, desc = "Run Current File" })
    end
}
