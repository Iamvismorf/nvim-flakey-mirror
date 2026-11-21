return {
	"crates.nvim",
	after = function()
		require("crates").setup({
			lsp = {
				enabled = true,
				completion = true,
				hover = true,
			},
		})
	end,
}
