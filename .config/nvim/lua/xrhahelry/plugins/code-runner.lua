return {
    "CRAG666/code_runner.nvim",
    dependencies = {
        "preservim/vimux",
    },
    config = function ()
        require('code_runner').setup({
            mode = "vimux",
            filetype = {
                haskell = "runghc $dir/$fileName",
                julia = "julia --project=$dir $dir/$fileName",
                python = "python -u '$dir/$fileName'",
                cpp = "cd $dir && ./build.sh",
            }
        })
        vim.keymap.set('n', '<leader>rf', function()
            require('code_runner').run_code()
        end,
        { noremap = true, silent = false, desc = "Run Current File" })
        vim.g.VimuxHeight = "30%"
    end
}
