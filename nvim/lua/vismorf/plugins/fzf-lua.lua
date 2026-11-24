-- todo: path shortener
-- todo: replace this with quickfix
-- '-- *.lua *.nix' to filter by filetype
return {
	"fzf-lua",
	event = { "DeferredUIEnter", "LspAttach" },
	keys = {
		{
			"<leader>f",
			function()
				require("fzf-lua").files({ cwd = _G.PRoot })
				vim.api.nvim_echo({ { "seach: " .. _G.PRoot, "MsgArea" } }, false, {})
			end,
		},
		{
			"<leader>g",
			function()
				require("fzf-lua").live_grep({ cwd = _G.PRoot, resume = true, no_esc = true })
				vim.api.nvim_echo({ { "grep: " .. _G.PRoot, "MsgArea" } }, false, {})
			end,
		},
		{
			"<C-b>",
			function()
				require("fzf-lua").buffers({
					winopts = {
						preview = {
							hidden = true,
						},
					},
					actions = { ["ctrl-b"] = function() end },
					-- fzf_opts = { ["--header-lines"] = 0 },
				})
			end,
		},
	},
	after = function()
		require("fzf-lua").setup({
			fzf_opts = {
				["--cycle"] = true,
			},
			files = {
				hidden = true,
				follow = true,
				cwd_prompt = false,
			},
			grep = {
				hidden = true,
				follow = true,
			},
			winopts = {
				preview = {
					wrap = true,
				},
			},
		})
	end,
}
