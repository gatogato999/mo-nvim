-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      { "<Leader>xX", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
      {
        "<Leader>xx",
        "<cmd>Trouble diagnostics toggle filter.severity=1<cr>",
        desc = "Diagnostics (errors only)",
      },
      { "<Leader>xq", "<cmd>Trouble quickfix toggle<cr>", desc = "Quickfix" },
    },
  },

  { "mhinz/vim-signify", init = function() vim.g.signify_vcs_list = { "svn", "git" } end },
  -- todo
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      signs = true,
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "END" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", alt = { "START" } },
        WARN = { icon = " ", color = "warning", alt = { "WARNING" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
    },
  },
  {
    "sphamba/smear-cursor.nvim",
    opts = {
      -- Smear cursor color. Defaults to Cursor GUI color if not set.
      -- Set to "none" to match the text color at the target cursor position.
      cursor_color = "#ff8800",
      -- Smear cursor when switching buffers or windows.
      smear_between_buffers = true,

      -- Smear cursor when moving within line or to neighbor lines.
      -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
      smear_between_neighbor_lines = true,

      -- Draw the smear in buffer space instead of screen space when scrolling
      scroll_buffer_space = true,

      -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
      -- Smears will blend better on all backgrounds.
      legacy_computing_symbols_support = false,

      -- Smear cursor in insert mode.
      -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
      smear_insert_mode = true,
    },
  },
  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
      },
    },
    keys = function()
      local keys = {
        { "<Leader>h", desc = "harpoon2", silent = true },
        {
          "<Leader>ha",
          function() require("harpoon"):list():add() end,
          desc = "add item",
          silent = true,
        },
        {
          "<Leader>hl",
          function()
            local harpoon = require "harpoon"
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "quick menu",
          silent = true,
        },
        {
          "<Leader>hn",
          function() require("harpoon"):list():next() end,
          desc = "next item",
          silent = true,
        },
        {
          "<Leader>hv",
          function() require("harpoon"):list():prev() end,
          desc = "prev item",
          silent = true,
        },
      }

      for i = 1, 5 do
        table.insert(keys, {
          "<Leader>h" .. i,
          function() require("harpoon"):list():select(i) end,
          desc = "item" .. i,
          silent = true,
        })
      end
      return keys
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup {
        size = 10,
        shell = "bash",
        direction = "horizontal", -- 'float', --"horizontal",
        start_in_insert = true,
        -- hide_numbers = true, -- hide the number column in toggleterm buffers
      }
    end,
  },
}

-- ---@type LazySpec
-- return {
--
--   -- == Examples of Adding Plugins ==
--
--   "andweeb/presence.nvim",
--   {
--     "ray-x/lsp_signature.nvim",
--     event = "BufRead",
--     config = function() require("lsp_signature").setup() end,
--   },
--
--   -- == Examples of Overriding Plugins ==
--
--   -- customize dashboard options
--   {
--     "folke/snacks.nvim",
--     opts = {
--       dashboard = {
--         preset = {
--           header = table.concat({
--             " █████  ███████ ████████ ██████   ██████ ",
--             "██   ██ ██         ██    ██   ██ ██    ██",
--             "███████ ███████    ██    ██████  ██    ██",
--             "██   ██      ██    ██    ██   ██ ██    ██",
--             "██   ██ ███████    ██    ██   ██  ██████ ",
--             "",
--             "███    ██ ██    ██ ██ ███    ███",
--             "████   ██ ██    ██ ██ ████  ████",
--             "██ ██  ██ ██    ██ ██ ██ ████ ██",
--             "██  ██ ██  ██  ██  ██ ██  ██  ██",
--             "██   ████   ████   ██ ██      ██",
--           }, "\n"),
--         },
--       },
--     },
--   },
--
--   -- You can disable default plugins as follows:
--   { "max397574/better-escape.nvim", enabled = false },
--
--   -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
--   {
--     "L3MON4D3/LuaSnip",
--     config = function(plugin, opts)
--       require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
--       -- add more custom luasnip configuration such as filetype extend or custom snippets
--       local luasnip = require "luasnip"
--       luasnip.filetype_extend("javascript", { "javascriptreact" })
--     end,
--   },
--
--   {
--     "windwp/nvim-autopairs",
--     config = function(plugin, opts)
--       require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
--       -- add more custom autopairs configuration such as custom rules
--       local npairs = require "nvim-autopairs"
--       local Rule = require "nvim-autopairs.rule"
--       local cond = require "nvim-autopairs.conds"
--       npairs.add_rules(
--         {
--           Rule("$", "$", { "tex", "latex" })
--             -- don't add a pair if the next character is %
--             :with_pair(cond.not_after_regex "%%")
--             -- don't add a pair if  the previous character is xxx
--             :with_pair(
--               cond.not_before_regex("xxx", 3)
--             )
--             -- don't move right when repeat character
--             :with_move(cond.none())
--             -- don't delete if the next character is xx
--             :with_del(cond.not_after_regex "xx")
--             -- disable adding a newline when you press <cr>
--             :with_cr(cond.none()),
--         },
--         -- disable for .vim files, but it work for another filetypes
--         Rule("a", "a", "-vim")
--       )
--     end,
--   },
-- }
