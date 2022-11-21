require("treesitter")
require("plugins")
require("set")
require("remap")

local function on_attach(client, buf)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer = buf})
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer = buf})
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer = buf})
    vim.keymap.set("n", "gr", vim.lsp.buf.references, {buffer = buf})
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer = buf})
    vim.keymap.set("n", "rn", vim.lsp.buf.rename, {buffer = buf})
    vim.keymap.set("n", "<C-Space>", vim.lsp.buf.code_action, {buffer = buf})
    vim.keymap.set("n", "<Leader>df", vim.diagnostic.goto_next, {buffer = buf})
    vim.keymap.set("n", "<Leader>dt", vim.diagnostic.goto_prev, {buffer = buf})
    vim.keymap.set("n", "<Leader>dl", "<cmd>Telescope diagnostics<cr>", {})
    vim.keymap.set("n", "<Leader>ff", "<cmd>Telescope find_files<cr>", {})
    vim.keymap.set("n", "<Leader>fg", "<cmd>Telescope live_grep<cr>", {})
    vim.keymap.set("n", "<Leader>fb", "<cmd>Telescope buffers<cr>", {})
    vim.keymap.set("n", "<Leader>fh", "<cmd>Telescope help_tags<cr>", {})
    vim.keymap.set("n", "<Leader>fr", "<cmd>Telescope lsp_references<cr>", {})
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local rt = {
    server = {
        settings = {
            capabilities = capabilities,
            on_attach = on_attach,
            ["rust-analyzer"] = {
                lens = {
                    enable = false
                },
                checkOnSave = {
                    command = "clippy",
                    target = "/tmp/rust-analyzer-check"
                },
            }
        }
    },
}
require('rust-tools').setup(rt)

require('lspconfig').gopls.setup{
    capabilities = capabilities,
    on_attach = on_attach
}

-- LSP Diagnostics Options Setup 
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.lsp.util.open_float = false

-- Completion Plugin Setup
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
    { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '🖫',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
})

require("telescope").setup()
