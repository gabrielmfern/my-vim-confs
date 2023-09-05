
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.nu = {
  install_info = {
    url = "https://github.com/nushell/tree-sitter-nu",
    files = { "src/parser.c" },
    branch = "main",
  },
  filetype = "nu",
}

require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "nu",
    "javascript",
    "dockerfile",
    "typescript",
    "html",
    "json",
    "markdown",
    "python",
    "scss",
    "sql",
    "vim",
    "c",
    "lua",
    "css",
    "rust",
  },

  sync_install = true,

  auto_install = true,

  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["if"] = "@function.inner",
        ["af"] = "@function.outer",

        ["ip"] = "@parameter.inner",
        ["ap"] = "@parameter.outer",

        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",

        ["as"] = {
          query = "@scope",
          query_group = "locals",
          desc = "Select language scope"
        }
      },
      include_surrounding_whitespace = false
    },
    swap = {
      enable = true,
      swap_next = {
        ["<C-m>"] = "@parameter.inner"
      },
      swap_previous = {
        ["<C-n>"] = "@parameter.inner"
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_previous_start = {
        ["<C-a>"] = "@parameter.inner"
      },
      goto_next_start = {
        ["<C-s>"] = "@parameter.inner"
      }
    }
  },
  ident = {
    enable = true
  },

  highlight = {
    enable = true,

    additional_vim_regex_highlighting = false,
  },
}
