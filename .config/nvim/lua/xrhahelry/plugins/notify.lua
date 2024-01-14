return {
    "rcarriga/nvim-notify",
    config = function ()
        require('notify').setup {
            render = "compact",
            stages = "slide",
            top_down = false,
            timeout = 2300,
        }
    end
}
