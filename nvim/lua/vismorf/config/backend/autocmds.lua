-- vim.api.nvim_create_autocmd("BufWinEnter", {
-- 	pattern = "*",
-- 	callback = function()
-- 		if vim.bo.filetype == "help" then
-- 			vim.bo.buflisted = true
-- 			vim.cmd.only()
-- 		end
-- 	end,
-- })

_G.Last_cursor_positions = {}
vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
	callback = function()
		local session_dir = vim.fn.stdpath("state") .. "/sessions/"
		local session_path = session_dir .. vim.fn.getcwd():gsub("/", "%%") .. ".vim"
		local buf_number = #vim.fn.getbufinfo({ buflisted = true })

		vim.fn.mkdir(session_dir, "p")

		if buf_number <= 1 or vim.fn.getcwd() == vim.fn.expand("~") then
			return
		end

		vim.cmd("mks! " .. vim.fn.fnameescape(session_path))
	end,
})
vim.api.nvim_create_autocmd("BufLeave", {
	callback = function(e)
		if vim.bo[e.buf].buftype ~= "" or vim.fn.win_gettype() ~= "" then
			return
		end

		_G.Last_cursor_positions[e.buf] = _G.Last_cursor_positions[e.buf] or {}
		_G.Last_cursor_positions[e.buf].cursor = vim.api.nvim_win_get_cursor(0)
	end,
})
vim.on_key(function(key, _)
	local buf_before = vim.api.nvim_win_get_buf(0)
	vim.schedule(function()
		local hr_key = vim.fn.keytrans(key)
		local buf = vim.api.nvim_win_get_buf(0)
		if (hr_key == "<Tab>" or hr_key == "<C-O>") and buf ~= buf_before then -- ctrl+i and ctrl+o
			vim.api.nvim_win_set_cursor(0, _G.Last_cursor_positions[buf].cursor)
		end
	end)
end)
