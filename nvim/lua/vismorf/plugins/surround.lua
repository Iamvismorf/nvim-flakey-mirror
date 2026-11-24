vim.g.nvim_surround_no_normal_mappings = true
return {
	"nvim-surround",
	event = "DeferredUIEnter",
	keys = {
		{
			mode = "n",
			"<leader>s",
			"<Plug>(nvim-surround-normal)",
		},
		{
			mode = "n",
			"<leader>ds",
			"<Plug>(nvim-surround-delete)",
			desc = "ds`closing or opening brackets`. This will always delete the previous pair. NOT NEXT PAIR",
		},
		{
			mode = "n",
			"<leader>rs",
			"<Plug>(nvim-surround-change)",
		},
	},
	after = function()
		require("nvim-surround").setup()
	end,
}
