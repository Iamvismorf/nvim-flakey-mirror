return {
	"crates.nvim",
	ft = "toml",
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
