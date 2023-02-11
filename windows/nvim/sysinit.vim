set number " number of lines
set encoding=utf-8
set relativenumber 
set autoindent " автооступ
set tabstop=4 " ширина таба
set shiftwidth=4 
set smarttab 
set softtabstop=4
set mouse=a " активация мыши


call plug#begin('C:\PortableApps\nvim\share\nvim\runtime\plugged')

Plug 'vim-airline/vim-airline' " status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree' "	файловый менеджер
Plug 'ryanoasis/vim-devicons' " icons
Plug 'neovim/nvim-lspconfig'
Plug 'Pocco81/auto-save.nvim' " autosave

" Git
Plug 'nvim-lua/plenary.nvim'
Plug 'tanvirtin/vgit.nvim', {'do': ':TSUpdate'}

" Autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" Highlight code (scoop instal zig for windows)
Plug 'nvim-treesitter/nvim-treesitter'
" Org-mode
Plug 'nvim-orgmode/orgmode'
call plug#end()

set completeopt-=preview
set t_Co=256
set t_ut=
let g:gruvbox_italic=1
set background=dark
colorscheme gruvbox
" truecolor support. Make some tex visible
if (has("termguicolors"))
    set termguicolors
  endif

nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-y> :vs <CR>
" turn off search highlight
nnoremap ,<space> :nohlsearch<CR>
" Go to next or prev tab by H and L accordingly
nnoremap H gT
nnoremap L gt
nnoremap <Esc> <C-\><C-n>

set guifont="Hack NFM"

" set numberwidth=3
" set foldcolumn=4
set foldmethod=manual

lua << EOF
require'lspconfig'.pyright.setup{}
EOF

lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })
  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
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
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }
EOF

lua << EOF
require("auto-save").setup(
    {
    }
)
EOF

lua << EOF

require 'nvim-treesitter.install'.compilers = { 'zig' }
-- Load custom tree-sitter grammar for org filetype
require('orgmode').setup_ts_grammar()

-- Tree-sitter configuration
require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
  }
}

require('orgmode').setup({
  org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
  org_default_notes_file = '~/Dropbox/org/refile.org',
})

require'cmp'.setup({
  sources = {
    { name = 'orgmode' }
  }
})
EOF

