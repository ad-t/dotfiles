return {
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",

  -- colorscheme
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = 'soft'
      -- For better performance
      vim.g.gruvbox_material_better_performance = 1
    end,
  },

  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      theme = "dragon",
      background = {
        dark = "dragon",
        light = "lotus"
      },
    }
  },

  {
    "rebelot/heirline.nvim",
    event = "UiEnter",
    config = function()
      local statusline = require("conf.heirline.statusline")
      local colors = require("conf.heirline.colors")
      require("heirline").setup({
        statusline = statusline,
        opts = {
          colors = colors
        }
      })
    end
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
          "typescript",
          "xml",
          "yaml",
        },
        auto_install = true,
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        ignore_install = { 'org' },
      })
    end,
  },

  -- highlight in-text colors
  {
    "norcalli/nvim-colorizer.lua",
    lazy = false,
    config = function()
      require('colorizer').setup()
    end
  },

  -- file searching -- super fast!
  {
    "ibhagwan/fzf-lua",
    lazy = true,
    keys = {
      { "<leader>ff", "<cmd>lua require('fzf-lua').files()<cr>", { silent = true } },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      fzf_args = vim.env.FZF_DEFAULT_OPTS,
      winopts = {
        border = false,
        preview = {
          hidden = "hidden"
        }
      }
    },
  },

  -- tabufline
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = function()
      return {
        options = {
          mode = "buffers",
          themable = true,
          diagnostics = "nvim_lsp",
        },
      }
    end
  },

  -- to enable language server autodownloading & setup
  { "neovim/nvim-lspconfig" },
  { "mason-org/mason.nvim" },
  {
    "mason-org/mason-lspconfig.nvim",
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
          -- about to be deprecateed
          -- "bufls",
          -- in favour of this:
          "buf_ls",
          "clangd",
          "cssls",
          "dockerls",
          "eslint",
          "gopls",
          "html",
          "jsonls",
          "lua_ls",
          "markdown_oxide",
          "pyright",
          "taplo",
          "terraformls",
          "tflint",
          "lemminx",
          "yamlls",
          "vtsls",
        },
        automatic_installation = true,
      })
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
        sources = cmp.config.sources(
          {
            { name = 'nvim_lsp' },
          },
          {
            -- { name = 'buffer' },
          }
        )
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
    lazy = false,
    keys = {
      { "<leader>p", "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle trouble diagnostics window" }
    },
    opts = {
      modes = {
        diagnostics = {
          auto_open = false,
        }
      },
      warn_no_results = false,
      open_no_results = true,
      auto_close = true,
      severity = vim.diagnostic.severity.ERROR,
      height = 7,
      focus = true,
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
      },
      filesystem = {
        follow_current_file = { enabled = true },
      },
    },
  },

  -- notifications
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
    }
  },

  -- completing closing tags for html-like languages
  {
    "tronikelis/ts-autotag.nvim",
    opts = {},
    -- ft = {}, optionally you can load it only in jsx/html
    event = "VeryLazy",
  },

  -- code context
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
    config = function()
      require("treesitter-context").setup {
        enable = true,
        mode = "topline",
        max_lines = 10,
        multiline_threshold = 1,
      }
    end
  },

  -- render markdown prettier
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown' },
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },

  -- remembering things, organising thoughts and information
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      -- Setup orgmode
      require('orgmode').setup({
        org_agenda_files = '~/code/orgfiles/**/*',
        org_default_notes_file = '~/code/orgfiles/refile.org',
        org_startup_indented = true,
        org_startup_folded = 'showeverything'
      })
    end,
  }
}
