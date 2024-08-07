return {
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup({
			-- INFO
			level = "WARN",
			render = "minimal",
			stages = "slide",
			top_down = true,
			timeout = 2300,
		})
	end,
}
