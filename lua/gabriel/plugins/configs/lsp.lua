local lsp = require('lsp-zero').preset({})

require("neodev").setup()

lsp.ensure_installed({
  'tsserver',
  'rust_analyzer',
  'angularls',
  'cssls',
  'pyright',
  'cssmodules_ls',
  'dockerls',
  'html',
  'jsonls',
  'sqlls',
  'yamlls',
})

local luasnip = require('luasnip')

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<Tab>'] = cmp.mapping(function(fallback)
    if luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    else
      fallback()
    end
  end),
  ['<S-Tab>'] = cmp.mapping(function(fallback)
    if luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end),
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
  ["<C-q>"] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.abort(),
  ['<C-u>'] = cmp.mapping.scroll_docs(-4),
  ['<C-d>'] = cmp.mapping.scroll_docs(4),
})


local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

cmp.setup({
  completion = {
    completeopt = "menu,menuone",
  },
  experimental = {
    ghost_text = true,
  },
  window = {
    completion = {
      side_padding = 1,
      scrollbar = true,
    },
    documentation = {
      border = border "CmpDocBorder",
    },
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer",                 keyword_length = 5 },
  },
  mapping = cmp_mappings,
  snippet = {
    expand = function(args)
      if not luasnip then
        return
      end
      luasnip.lsp_expand(args.body)
    end
  },
})

lsp.set_preferences({
  suggest_lsp_servers = true,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

lsp.on_attach(function(_client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set(
    'n',
    'FF',
    function()
      vim.lsp.buf.format({
        timeout_ms = 4000,
        filter = function(client)
          local has_null_ls = false
          for _, active_client in pairs(vim.lsp.get_active_clients()) do
            if active_client.name == 'null-ls' then
              has_null_ls = true
              break
            end
          end

          if has_null_ls then
            return client.name == 'null-ls'
          else
            return true
          end
        end,
      })
    end,
    bufopts
  )
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, bufopts)

  vim.keymap.set('n', 'gD', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)

  vim.keymap.set('n', 'g[', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', 'g]', vim.diagnostic.goto_prev, bufopts)
  vim.diagnostic.config({ virtual_text = false })
end)

lsp.setup()
