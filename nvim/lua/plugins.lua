local functions = require "functions"

return {
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",

  -- colorscheme
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      integrations = {
        gitsigns = true,
        treesitter = true,
        mason = true,
        which_key = true,
      }
    },
  },

  -- line at the bottom
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      theme = 'catppuccin',
      sections = {
        lualine_x = { 'filetype' },
        lualine_y = { functions.lsp_progress, }
      },
    },
  },

  -- git signs
  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    opts = {
      signcolumn = true,
      update_debounce = 500,
    },
  },

  -- syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {
          "bash",
          "c",
          "css",
          "dockerfile",
          "fish",
          "gitignore",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "nix",
          "proto",
          "terraform",
          "tsx",
          "xml",
          "yaml",
        },
        auto_install = true,
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- file searching -- super fast!
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>ff", "<cmd>lua require('fzf-lua').files()<cr>", { silent = true } },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      winopts = {
        preview = {
          hidden = "hidden"
        }
      }
    },
  },

  -- tabufline
  {
    'akinsho/bufferline.nvim',
    after = "catppuccin",
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = function()
      local mocha = require("catppuccin.palettes").get_palette "mocha"
      return {
        options = {
          -- mode = "buffers",
          themable = true,
          diagnostics = "nvim_lsp",
        },
        highlights = {
          fill = { bg = mocha.base },
          background = { bg = mocha.mantle },
          buffer_visible = { bg = mocha.surface0 },
          buffer_selected = { bg = mocha.surface1 },
          separator = { bg = mocha.base },
          close_button_selected = { bg = mocha.surface1, fg = mocha.red },
          close_button_visible = { bg = mocha.surface0 },
          indicator_visible = { bg = mocha.yellow },
          indicator_selected = { bg = mocha.green },
        },
      }
    end,
  },

  -- to enable language server autodownloading & setup
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      -- we'd like to disable lsp logging, however
      -- still provide the ability to enable debug
      -- logging if required
      vim.lsp.set_log_level("off")
      -- vim.lsp.set_log_level("debug")
      -- enforce a specific loading order
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ansiblels",
          "bashls",
          "cssls",
          "dockerls",
          "eslint",
          "html",
          "jsonls",
          "markdown_oxide",
          "pyright",
          "taplo",
          "terraformls",
          "tflint",
          "lemminx",
          "yamlls",
          "tsserver",
        },
        automatic_installation = true,
      })
      require("mason-lspconfig").setup_handlers {
        function (server_name)
          require("lspconfig")[server_name].setup {
            on_attach = function(client, bufnr)
              local function opts(desc)
                return { buffer = bufnr, desc = "LSP " .. desc }
              end
              vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "go to definition" })
            end
          }
        end,
      }
    end
  },

  -- autocompletion
   {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    config = function()
      local cmp = require'cmp'
      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<cr>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
        }, {
          { name = 'buffer' },
        })
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })

    end,
  },

  -- present all the file errors in a window
  {
    "folke/trouble.nvim",
    keys = {
      { "<leader>p", "<cmd>TroubleToggle<cr>", desc = "Toggle trouble window" }
    },
    opts = {
      auto_open = true,
      auto_close = true,
      height = 7,
      severity = vim.diagnostic.severity.ERROR,
    }
  },

  -- symbols available in the file
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = { -- Example mapping to toggle outline
      { "<leader>o", "<cmd>Outline<cr>", desc = "Toggle outline" },
    },
    opts = {
      -- Your setup opts here
    },
  },

  -- file exploring
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    keys = {
      { "<leader>n", "<cmd>Neotree toggle=true<cr>", desc = "Open file explorer" }
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      window = {
        position = "right",
      }
    }
  }
}
