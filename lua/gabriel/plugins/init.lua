local function setup_lazy()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
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
end

setup_lazy()

require("lazy").setup({
  -- packer itself
  {
    'nvim-telescope/telescope.nvim',
    cmd = "Telescope",
    init = function()
      vim.api.nvim_set_keymap('n', 'ff', ':Telescope find_files<CR>', {})
      vim.api.nvim_set_keymap('n', 'fg', ':Telescope live_grep<CR>', {})
    end,
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- colorscheme
  -- {
  --   'folke/tokyonight.nvim',
  --   init = function()
  --     require("gabriel.plugins.configs.colorscheme")
  --   end
  -- },
  {
    'savq/melange-nvim',
    init = function()
      require("gabriel.plugins.configs.colorscheme")
    end
  },

  -- plugins to make things prettier
  {
    "lewis6991/hover.nvim",
    config = function()
      require("hover").setup {
        init = function()
          -- Require providers
          require("hover.providers.lsp")
          require('hover.providers.gh')
          -- require('hover.providers.gh_user')
          require('hover.providers.jira')
          require('hover.providers.man')
          require('hover.providers.dictionary')
        end,
        preview_opts = {
          border = nil
        },
        -- Whether the contents of a currently open hover window should be moved
        -- to a :h preview-window when pressing the hover keymap.
        preview_window = false,
        title = true
      }

      -- Setup keymaps
      vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
      vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
    end
  },
  {
    'petRUShka/vim-opencl',
    ft = 'opencl'
  },
  'nvim-tree/nvim-web-devicons',
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    lazy = false,
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons"
    },
    opts = {
      theme = 'tokyonight',
      exclude_filetypes = { "toggleterm", "netrw", "neo-tree", "lazy", "Lazygit" },
      show_dirname = false
    }
  },
  {
    'feline-nvim/feline.nvim',
    config = function()
      require("gabriel.plugins.configs.feline")
    end
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      char = "▏",
      filetype_exclude = { "help", "Neo-tree", "Trouble", "Lazy" },
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
  },
  {
    'echasnovski/mini.indentscope',
    lazy = false,
    opts = {
      try_as_border = true,
      symbol = '▏',
    },
    cond = function()
      if vim.bo.filetype == 'Neo-tree' then
        return false
      end

      return true
    end,
    version = '*'
  },
  {
    'stevearc/dressing.nvim',
    opts = {
      select = {
        enabled = true,
        backend = { "telescope" }
      }
    }
  },
  {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    config = function()
      require('lsp_lines').setup()
    end,
    lazy = false
  },

  -- some cool stuff that helps me out
  {
    'johmsalas/text-case.nvim',
    keys = "ga",
    opts = {
      prefix = "ga"
    }
  },
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false

      local opts = { noremap = true, silent = true }
      map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
      map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)

      map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
      map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
      map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
      map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
      map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
      map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
      map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
      map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
      map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
      map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)

      map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
      map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)

      map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
      map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
      sidebar_filetypes = {
        ['neo-tree'] = { event = 'BufWipeout' },
        Outline = { event = 'BufWinLeave', text = 'symbols-outline' },
      },
      animation = false
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
  {
    'glacambre/firenvim',

    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    lazy = false, --not vim.g.started_by_firenvim,
    build = function()
      vim.fn["firenvim#install"](0)
    end
  },
  {
    'RRethy/vim-illuminate',
    config = function()
      require('illuminate').configure()
    end,
  },
  {
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        bypass_session_save_file_types = nil, -- table: Bypass auto save when only buffer open is one of these file types
        pre_save_cmds = {
          "Neotree close"
        },
        cwd_change_handling = {            -- table: Config for handling the DirChangePre and DirChanged autocmds, can be set to nil to disable altogether
          restore_upcoming_session = true, -- boolean: restore session for upcoming cwd on cwd change
          pre_cwd_changed_hook = nil,      -- function: This is called after auto_session code runs for the `DirChangedPre` autocmd
          post_cwd_changed_hook = nil,     -- function: This is called after auto_session code runs for the `DirChanged` autocmd
        },
      }
    end,
    lazy = false
  },
  {
    'windwp/nvim-autopairs',
    lazy = false
  },
  {
    'tpope/vim-surround',
    keys = "cs"
  },
  {
    'numToStr/Comment.nvim',
    lazy = false,
    opts = {
      pre_hook = function(ctx)
        -- Only calculate commentstring for tsx filetypes
        if vim.bo.filetype == 'typescriptreact' or vim.bo.filetype == 'Typescriptreact' then
          local U = require('Comment.utils')

          -- Determine whether to use linewise or blockwise commentstring
          local type = ctx.ctype == U.ctype.linewise and '__default' or '__multiline'

          -- Determine the location where to calculate commentstring from
          local location = nil
          if ctx.ctype == U.ctype.blockwise then
            location = require('ts_context_commentstring.utils').get_cursor_location()
          elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = require('ts_context_commentstring.utils').get_visual_start_location()
          end

          return require('ts_context_commentstring.internal').calculate_commentstring({
            key = type,
            location = location,
          })
        end
      end,
    },
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring'
    }
  },
  'xolox/vim-misc',
  'matze/vim-move',
  'gpanders/editorconfig.nvim',
  {
    'folke/trouble.nvim',
    init = function()
      vim.api.nvim_set_keymap("n", "<C-x>t", ":TroubleToggle<cr>",
        { silent = true, noremap = true }
      )

      vim.api.nvim_set_keymap("n", "<C-x>d", ":TroubleToggle document_diagnostics<cr>",
        { silent = true, noremap = true }
      )

      vim.api.nvim_set_keymap("n", "<C-x>w", ":TroubleToggle workspace_diagnostics<cr>",
        { silent = true, noremap = true }
      )
    end,
    cmd = "TroubleToggle"
  },

  -- tree sitter
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-tree-docs',
      -- 'nvim-treesitter/nvim-treesitter-context',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    lazy = false,
    config = function()
      require("gabriel.plugins.configs.treesitter")
    end
  },

  -- file tree plugin
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    init = function()
      vim.api.nvim_set_keymap("n", "<C-c>", ":Neotree<CR>", {})
    end,
    config = function()
      require("gabriel.plugins.configs.neo-tree")
    end
  },
  {
    "folke/neodev.nvim",
    ft = "lua"
  },

  -- some git plugins
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        signs = {
          add          = { text = '▏' },
          change       = { text = '▏' },
          delete       = { text = '▏' },
          topdelete    = { text = '▏' },
          changedelete = { text = '▏' },
          untracked    = { text = '▏' },
        }
      })
    end,
    lazy = false
  },
  {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = "LazyGit",
    init = function()
      vim.api.nvim_set_keymap("n", "<C-l>g", ":LazyGit<CR>", {})
    end
  },
  { 'f-person/git-blame.nvim', lazy = false },

  -- the cherry on the top: LSP
  {
    'jose-elias-alvarez/null-ls.nvim',
    lazy = false,
    config = function()
      local null_ls = require("null-ls")

      local function on_attach(client, _)
        if client.server_capabilities.document_formatting then
          vim.cmd("command! -buffer Formatting lua vim.lsp.buf.formatting()")
          vim.cmd("command! -buffer FormattingSync lua vim.lsp.buf.formatting_sync()")
        end
      end

      local eslint_opts = {
        condition = function(utils)
          return utils.has_file({ ".eslintrc.js", ".eslintrc.json", ".eslintrc" })
        end
      }

      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.eslint_d.with(eslint_opts),
          null_ls.builtins.code_actions.eslint_d.with(eslint_opts),
          null_ls.builtins.formatting.eslint_d.with(eslint_opts),
          -- null_ls.builtins.formatting.prettier_d_slim,
        },
        on_attach = on_attach,
      })
    end,
  },

  {
    "chrisgrieser/nvim-early-retirement",
    config = true,
    event = "VeryLazy",
  },

  {
    'VonHeikemen/lsp-zero.nvim',
    lazy = false,
    config = function()
      require("gabriel.plugins.configs.lsp")
    end,
    dependencies = {
      -- LSP Support
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Autocompletion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',

      -- Snippets
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',

      -- Misc
      'SmiteshP/nvim-navic',
    }
  },
})
