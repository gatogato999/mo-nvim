return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    features = {
      -- toggle if diagnostics are enabled on startup
      diagnostics = true,
    },
    -- Configuration passed to `vim.diagnostic.config()`
    -- All available options can be found with `:h vim.diagnostic.Opts`
    diagnostics = {
      virtual_text = true,
      virtual_lines = false,
      update_in_insert = false,
      underline = false,
      severity_sort = true,
    },
  },
}
