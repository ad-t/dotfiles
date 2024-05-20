local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- space as leader key
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`

-- set the termguicolors before anything else
vim.opt.termguicolors = true

require("lazy").setup({
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",

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
      theme = 'catppuccin'
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

  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
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
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      }
    }
  },

  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true } },
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
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
      options = {
        -- mode = "buffers",
        themable = true,
        diagnostics = "nvim_lsp",
      }
    }
  },

  -- to enable language server autodownloading & setup
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
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
          require("lspconfig")[server_name].setup {}
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
          ['<CR>'] = cmp.mapping.confirm({
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

      -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
      -- Set configuration for specific filetype.
      --[[ cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
      { name = 'git' },
      }, {
      { name = 'buffer' },
      })
      })
      require("cmp_git").setup() ]]-- 

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
});

-- things that need to happen after all plugins have loaded

-- redundancy for : character
vim.keymap.set("n", ";", ":", { desc = "enter cmd mode" })
-- better escape key
vim.keymap.set("i", "jk", "<ESC>", { desc = "escape insert mode" })
vim.keymap.set("i", "kj", "<ESC>", { desc = "escape insert mode" })
-- moving between buffers
vim.keymap.set("n", "<tab>", ":bnext<CR>", { desc = "move to next buffer", silent = true })
vim.keymap.set("n", "<S-tab>", ":bprevious<CR>", { desc = "move to previous buffer", silent = true })
-- close buffer
vim.keymap.set("n", "<leader>x", ":bdelete<CR>", { desc = "close buffer", silent = true })
-- show signcolumn all the time (TODO: figure out if this is actually doing anything)
vim.cmd.signcolumn = yes
-- block cursor
vim.opt.guicursor = ""
-- make sure undos don't leak between sessions
vim.o.undofile = false
-- change colorscheme
vim.cmd.colorscheme "catppuccin"
-- show the cursorline where your cursor is
vim.o.cursorline = true
-- enable mouse input
vim.o.mouse = "a"
-- interval for writing wraps to disk (used also by gitsigns)
vim.o.updatetime = 500
-- indenting
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.softtabestop = 2
vim.o.number = true
vim.o.numberwidth = 5
