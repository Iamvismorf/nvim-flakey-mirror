-- vim.api.nvim_create_autocmd("BufWinEnter", {
-- 	pattern = "*",
-- 	callback = function()
-- 		if vim.bo.filetype == "help" then
-- 			vim.bo.buflisted = true
-- 			vim.cmd.only()
-- 		end
-- 	end,
-- })

local last_cursor_positions = {}
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

		last_cursor_positions[e.buf] = last_cursor_positions[e.buf] or {}
		last_cursor_positions[e.buf].cursor = vim.api.nvim_win_get_cursor(0)
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "BufferSwitch",
	callback = function(e)
		if vim.bo[e.buf].buftype ~= "" or vim.fn.win_gettype() ~= "" or last_cursor_positions[e.buf] == nil then
			return
		end
		vim.api.nvim_win_set_cursor(0, last_cursor_positions[e.buf].cursor)
	end,
})
