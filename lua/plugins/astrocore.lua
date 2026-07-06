-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    no_comment_continuation = {
      event = "FileType",
      pattern = "*",
      desc = "disable comment continuatoin on newline",
      -- callback = function()
      --   vim.opt_local.formatoptions:remove { "r", "o" }
      --   -- vim.cmd [[autocmd FileType * set formatoptions-=ro]],
      -- end,
    },
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        foo = "fooscript",
      },
      filename = {
        [".foorc"] = "fooscript",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
        termguicolors = true,
        colorcolumn = "80",
        scrolloff = 8,
        sidescrolloff = 8,
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
        clipboard = {
          name = "wl-clipboard",
          -- copy = {
          --   ["+"] = { "wl-copy", "--trim-newline" },
          --   ["*"] = { "wl-copy", "--primary", "--trim-newline" },
          -- },
          --
          -- paste = {
          --   ["+"] = { "wl-paste", "--no-newline" },
          --   ["*"] = { "wl-paste", "--no-newline", "--primary" },
          -- },

          copy = {
            ["+"] = { "wl-copy", "--foreground", "--type", "text/plain" },
            ["*"] = { "wl-copy", "--foreground", "--primary", "--type", "text/plain" },
          },

          paste = {
            ["+"] = { "wl-paste", "--no-newline" },
            ["*"] = { "wl-paste", "--no-newline", "--primary" },
          },

          cache_enabled = 1,
        },
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        ["\\"] = { function() require("todo-comments").jump_next() end, desc = "jump to next todo" },

        ["|"] = { function() require("todo-comments").jump_prev() end, desc = "jump to prev todo" },

        ["Q"] = { "o<Esc>k", desc = "add an empty line under" },
        ["<Leader>Q"] = { "O<Esc>j", desc = "add an empty line upove" },

        ["<Leader>c"] = false,

        -- break the line
        ["<Leader>q"] = { "gqj", desc = "break the long lines" },
        -- copy to system clipboard
        -- ["<Leader>y"] = {"\"+y", desc = "copy to system clipboar"},
        -- ["<Leader>Y"] = {"\"+Y", desc = "copy to own clipboar"},
        -- navigate buffer tabs
        ["<Leader>]"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["<Leader>["] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },
        -- move buffer
        ["<Leader>bp"] = {
          function() require("astrocore.buffer").move(1) end,
          desc = "move next buffer",
        },

        ["<Leader>bq"] = {
          function() require("astrocore.buffer").move(-1) end,
          desc = "move prev buffer",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,

        -- window management
        ["<C-h>"] = { "<C-w>h", desc = "jump to left window" },
        ["<C-l>"] = { "<C-w>l", desc = "jump to right window" },
        ["<C-k>"] = { "<C-w>k", desc = "jump to up window" },
        ["<C-j>"] = { "<C-w>j", desc = "jump to bottom window" },

        -- resize windows
        ["C-Left"] = { "<C-w><", desc = "resize window to left" },
        ["C-Right"] = { "<C-w>>", desc = "resize window to right" },
        ["C-Up"] = { "<C-w>+", desc = "resize window to up" },
        ["C-Down"] = { "<C-w>-", desc = "resize window to bottom" },

        -- removing the disorientation with zz
        ["n"] = { "nzzzv", desc = "center after search" },
        ["N"] = { "Nzzzv", desc = "center after search" },
        ["<C-d>"] = { "<C-d>zz", desc = "scroll down half page" },
        ["<C-u>"] = { "<C-u>zz", desc = "scroll up half page" },
        ["J"] = { "mzJ`z", desc = "append the line below" },

        -- split window
        ["<Leader>s"] = { desc = "Splitting windows" },
        ["<Leader>sh"] = { ":split<CR>", desc = "horizontal split" },
        ["<Leader>sv"] = { ":vsplit<CR>", desc = "vertical split" },
        ["<Leader>sn"] = { ":only<CR>", desc = "no split" },

        -- indentation
        ["<Leader>i"] = { ">>", desc = "indent to right" },
        ["<Leader>I"] = { "<<", desc = "indent to left" },

        -- go to file under course or create it
        -- ["gf"] = {function ()
        --   require("gf_create").gf_create()
        -- end,
        --   noremap = true ,
        --   desc = "go file or create it"},

        -- delete to void register
        ["<Leader>D"] = { '"_D', desc = "delete to void" },

        -- change word under courser for the entire file
        ["<Leader>O"] = {
          ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
          desc = "rename under courser",
        },

        -- harpoon
        ["<Leader>h"] = { desc = "harpoon" },
        ["<Leader>hl"] = {
          function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end,
          desc = "quick menu",
          silent = true,
        },

        -- ToggleTerm
        ["<Leader>8"] = { "<cmd>ToggleTerm size=80 direction=vertical <CR>", desc = "ToggleTerm" },
      },
      v = {
        -- copy to system clipboard
        ["<Leader>y"] = { '"+y', desc = "copy to system clipboar" },
        ["<Leader>Y"] = { '"+Y', desc = "copy to own clipboar" },

        -- move highlighted text with up and down
        ["J"] = { ":m '>+1<CR>gv=gv", desc = "move selected down" },
        ["K"] = { ":m '<-2<CR>gv=gv", desc = "move selected up" },

        -- indentation
        ["<Leader>i"] = { ">>", desc = "indent to right" },
        ["<Leader>I"] = { "<<", desc = "indent to left" },

        -- delete to void register
        ["<Leader>D"] = { '"_D', desc = "delete to void" },
      },

      -- paste mode
      x = {
        ["<Leader>P"] = { '"_db', desc = "paste to void" },
        ["<Leader>D"] = { '"_D', desc = "delete to void" },
      },
      -- terminal mode
      t = {
        ["<Leader>8"] = { [[<C-\><C-n><cmd>ToggleTerm size=80 direction=vertical <CR>]], desc = "ToggleTerm " },
      },
    },
  },
}
