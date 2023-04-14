set number " number of lines
set encoding=utf-8
set relativenumber 
set autoindent " автооступ
set tabstop=4 " ширина таба
set shiftwidth=4 
set smarttab 
set softtabstop=4
set mouse=a " активация мыши
set clipboard=unnamedplus " use system clipboard


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
Plug 'hrsh7th/vim-vsnip'

" Tag autoclose
Plug 'windwp/nvim-ts-autotag'

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
" truecolor support. Make some text visible
if (has("termguicolors"))
    set termguicolors
  endif

"Enable arrows in statusbar
let g:airline_powerline_fonts = 1

nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-y> :vs <CR>
" turn off search highlight
nnoremap ,<space> :nohlsearch<CR>
" Go to next or prev tab by H and L accordingly
nnoremap H gT
nnoremap L gt
nnoremap <Esc> <C-\><C-n>

set guifont="Hack NFM"

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
    cmp.setup.filetype('org', {
      sources = {
        { name = 'orgmode' }
	}
  })

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
require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,
    -- Required for spellcheck, some LaTex highlights and
    -- code block highlights that do not have ts grammar
		additional_vim_regex_highlighting = {'org'},
	},
	ensure_installed = {'org'},
    autotag = {
		enable = true,
	},
}
EOF


lua << EOF
-- Load custom treesitter grammar for org filetype
require('orgmode').setup_ts_grammar()

require('orgmode').setup({
  org_agenda_files = {"D:\\08_NOTES\\Agenda\\*.org"},
  org_default_notes_file = 'D:\\08_NOTES\\Agenda\\!refile.org',
  mappings = {
    global = {
      org_agenda = 'gA',
      org_capture = 'gC'
    },
	org = {
		org_toggle_checkbox = '<Leader><Space>'
	}
  }
})
EOF


lua << EOF
 require('vgit').setup({
      keymaps = {
        ['n <C-k>'] = function() require('vgit').hunk_up() end,
        ['n <C-j>'] = function() require('vgit').hunk_down() end,
        ['n <leader>gs'] = function() require('vgit').buffer_hunk_stage() end,
        ['n <leader>gr'] = function() require('vgit').buffer_hunk_reset() end,
        ['n <leader>gp'] = function() require('vgit').buffer_hunk_preview() end,
        ['n <leader>gb'] = function() require('vgit').buffer_blame_preview() end,
        ['n <leader>gf'] = function() require('vgit').buffer_diff_preview() end,
        ['n <leader>gh'] = function() require('vgit').buffer_history_preview() end,
        ['n <leader>gu'] = function() require('vgit').buffer_reset() end,
        ['n <leader>gg'] = function() require('vgit').buffer_gutter_blame_preview() end,
        ['n <leader>glu'] = function() require('vgit').buffer_hunks_preview() end,
        ['n <leader>gls'] = function() require('vgit').project_hunks_staged_preview() end,
        ['n <leader>gd'] = function() require('vgit').project_diff_preview() end,
        ['n <leader>gq'] = function() require('vgit').project_hunks_qf() end,
        ['n <leader>gx'] = function() require('vgit').toggle_diff_preference() end,
      },
      settings = {
        git = {
          cmd = 'git', -- optional setting, not really required
          fallback_cwd = vim.fn.expand("$HOME"),
          fallback_args = {
            "--git-dir",
            vim.fn.expand("$HOME/dots/yadm-repo"),
            "--work-tree",
            vim.fn.expand("$HOME"),
          },
        },
        hls = {
          GitBackground = 'NormalFloat',
          GitHeader = 'NormalFloat',
          GitFooter = 'NormalFloat',
          GitBorder = 'LineNr',
          GitLineNr = 'LineNr',
          GitComment = 'Comment',
          GitSignsAdd = {
            gui = nil,
            fg = '#d7ffaf',
            bg = nil,
            sp = nil,
            override = false,
          },
          GitSignsChange = {
            gui = nil,
            fg = '#7AA6DA',
            bg = nil,
            sp = nil,
            override = false,
          },
          GitSignsDelete = {
            gui = nil,
            fg = '#e95678',
            bg = nil,
            sp = nil,
            override = false,
          },
          GitSignsAddLn = 'DiffAdd',
          GitSignsDeleteLn = 'DiffDelete',
          GitWordAdd = {
            gui = nil,
            fg = nil,
            bg = '#5d7a22',
            sp = nil,
            override = false,
          },
          GitWordDelete = {
            gui = nil,
            fg = nil,
            bg = '#960f3d',
            sp = nil,
            override = false,
          },
        },
        live_blame = {
          enabled = true,
          format = function(blame, git_config)
            local config_author = git_config['user.name']
            local author = blame.author
            if config_author == author then
              author = 'You'
            end
            local time = os.difftime(os.time(), blame.author_time)
              / (60 * 60 * 24 * 30 * 12)
            local time_divisions = {
              { 1, 'years' },
              { 12, 'months' },
              { 30, 'days' },
              { 24, 'hours' },
              { 60, 'minutes' },
              { 60, 'seconds' },
            }
            local counter = 1
            local time_division = time_divisions[counter]
            local time_boundary = time_division[1]
            local time_postfix = time_division[2]
            while time < 1 and counter ~= #time_divisions do
              time_division = time_divisions[counter]
              time_boundary = time_division[1]
              time_postfix = time_division[2]
              time = time * time_boundary
              counter = counter + 1
            end
            local commit_message = blame.commit_message
            if not blame.committed then
              author = 'You'
              commit_message = 'Uncommitted changes'
              return string.format(' %s • %s', author, commit_message)
            end
            local max_commit_message_length = 255
            if #commit_message > max_commit_message_length then
              commit_message = commit_message:sub(1, max_commit_message_length) .. '...'
            end
            return string.format(
              ' %s, %s • %s',
              author,
              string.format(
                '%s %s ago',
                time >= 0 and math.floor(time + 0.5) or math.ceil(time - 0.5),
                time_postfix
              ),
              commit_message
            )
          end,
        },
        live_gutter = {
          enabled = true,
          edge_navigation = true,  -- This allows users to navigate within a hunk
        },
        authorship_code_lens = {
          enabled = true,
        },
        scene = {
          diff_preference = 'unified',
          keymaps = {
            quit = 'q'
          }
        },
       diff_preview = {
          keymaps = {
            buffer_stage = 'S',
            buffer_unstage = 'U',
            buffer_hunk_stage = 's',
            buffer_hunk_unstage = 'u',
            toggle_view = 't',
          },
        },
        project_diff_preview = {
          keymaps = {
            buffer_stage = 's',
            buffer_unstage = 'u',
            buffer_hunk_stage = 'gs',
            buffer_hunk_unstage = 'gu',
            buffer_reset = 'r',
            stage_all = 'S',
            unstage_all = 'U',
            reset_all = 'R',
          },
        },
        project_commit_preview = {
          keymaps = {
            save = 'S',
          },
        },
        signs = {
          priority = 10,
          definitions = {
            GitSignsAddLn = {
              linehl = 'GitSignsAddLn',
              texthl = nil,
              numhl = nil,
              icon = nil,
              text = '',
            },
            GitSignsDeleteLn = {
              linehl = 'GitSignsDeleteLn',
              texthl = nil,
              numhl = nil,
              icon = nil,
              text = '',
            },
            GitSignsAdd = {
              texthl = 'GitSignsAdd',
              numhl = nil,
              icon = nil,
              linehl = nil,
              text = '┃',
            },
            GitSignsDelete = {
              texthl = 'GitSignsDelete',
              numhl = nil,
              icon = nil,
              linehl = nil,
              text = '┃',
            },
            GitSignsChange = {
              texthl = 'GitSignsChange',
              numhl = nil,
              icon = nil,
              linehl = nil,
              text = '┃',
            },
          },
          usage = {
            screen = {
              add = 'GitSignsAddLn',
              remove = 'GitSignsDeleteLn',
            },
            main = {
              add = 'GitSignsAdd',
              remove = 'GitSignsDelete',
              change = 'GitSignsChange',
            },
          },
        },
        symbols = {
          void = '⣿',
        },
      }
    })
EOF
:VGit toggle_diff_preference
