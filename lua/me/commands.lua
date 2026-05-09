return {
  vim.api.nvim_create_user_command("Logtime", function(opts)
    local action = opts.args

    if action ~= "start" and action ~= "end" then
      print "Usage: :Logtime start|end"
      return
    end

    local label = action == "start" and "START" or "END"

    -- Format similar to Linux `date`
    local time_str = os.date "%a %b %d %I:%M:%S %p %Z %Y"

    local line = string.format("<!-- %s:   %s  -->", label, time_str)

    -- Insert at current cursor line
    vim.api.nvim_put({ line }, "l", true, true)
  end, {
    nargs = 1,
    complete = function() return { "start", "end" } end,
  }),
}
