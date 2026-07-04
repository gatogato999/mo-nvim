return {
  vim.api.nvim_create_user_command("Timelog", function(opts)
    local flag = opts.args == "now" and " --now" or ""
    local timelog = vim.fn.expand "~" .. "/customedScripts/timelog.sh"

    local file = vim.fn.expand "%:p"
    local out = vim.fn.system(timelog .. " " .. file .. flag)

    -- strip ANSI escape codes
    out = out:gsub("\27%[[%d;]*m", "")

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(out, "\n"))
    local width = 72
    local height = 12
    vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      width = width,
      height = height,
      row = math.floor((vim.o.lines - height) / 2),
      col = math.floor((vim.o.columns - width) / 2),
      style = "minimal",
      border = "rounded",
    })
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf })
  end, { nargs = "?", complete = function() return { "now" } end }),
}
