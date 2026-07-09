-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here
--
-- Guard against malformed diagnostics with an end position before their
-- start (seen from gopls staticcheck/U1000 unused-var checks reporting an
-- explicit end_lnum=0/end_col=0). Neovim core only fills in *missing*
-- end fields, not invalid-but-present ones, and crashes trying to render
-- an inverted range. Clamp instead of crashing.
--
-- What it does: wraps vim.diagnostic.set (the function every LSP client and
-- linter ultimately calls to publish diagnostics into a buffer).
-- Before passing diagnostics through to the real function, it checks each one
-- for an end position that's earlier than its start position — which is exactly
-- the invalid state gopls was sending for those U1000 unused-var hits
-- (end_lnum = 0 while lnum = 8).
-- If it finds one, it clamps the end position to match the start instead of
-- leaving it inverted, which is what was crashing Neovim's internal extmark
-- placement code. Everything else about the diagnostic (message, severity,
-- source, line number shown to you) is untouched — only the invalid end-of-range
-- value gets corrected.
local orig_diagnostic_set = vim.diagnostic.set
vim.diagnostic.set = function(namespace, bufnr, diagnostics, opts)
  for _, d in ipairs(diagnostics) do
    if d.end_lnum and d.lnum and d.end_lnum < d.lnum then
      d.end_lnum, d.end_col = d.lnum, d.col
    elseif d.end_lnum == d.lnum and d.end_col and d.col and d.end_col < d.col then
      d.end_col = d.col
    end
  end
  return orig_diagnostic_set(namespace, bufnr, diagnostics, opts)
end
