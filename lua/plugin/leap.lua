local vim = require("vim")
require("qutil")

vim.api.nvim_create_autocmd("User", {
	pattern = "LeapEnter",
	command = "BeaconOff",
})
vim.api.nvim_create_autocmd("User", {
	pattern = "LeapLeave",
	command = "BeaconOn",
})
vim.api.nvim_create_autocmd("User", {
	pattern = "LeapLeave",
	command = "Beacon",
})

-- Searching in all windows (including the current one) on the tab page:
QUtil.leap_all_windows = function()
	require("leap").leap({
		target_windows = vim.tbl_filter(function(win)
			return vim.api.nvim_win_get_config(win).focusable
		end, vim.api.nvim_tabpage_list_wins(0)),
	})
end

-- Bidirectional search in the current window is just a specific case of the
-- multi-window mode - set `target-windows` to a table containing the current
-- window as the only element:
QUtil.leap_bidirectional = function()
	require("leap").leap({ target_windows = { vim.api.nvim_get_current_win() } })
end
