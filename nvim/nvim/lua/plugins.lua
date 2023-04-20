local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use("nvim-lua/plenary.nvim")
	use("nvim-tree/nvim-web-devicons")
	use("MunifTanjim/nui.nvim")
	use({"nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = { 
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
		},
	config = function() require('plugins.neotree') end,
	})

	use({"nvim-treesitter/nvim-treesitter",
		config = function() require('plugins.treesitter') end,	
	}) -- Treesitter Syntax Highlighting

	-- Productivity
	use({"nvim-orgmode/orgmode", config = function() require('plugins.orgmode') end})


	-- File management --
	use("tiagofumo/vim-nerdtree-syntax-highlight")
	use("ryanoasis/vim-devicons")

	-- Themes
	use ({ "bluz71/vim-moonfly-colors", as = "moonfly" })
	use ({"nvim-lualine/lualine.nvim",  
		config = function() require('plugins.lualine') end,
	}) -- A better statusline

	-- Autocomplete
	use ('hrsh7th/cmp-nvim-lsp')
	use ('hrsh7th/cmp-buffer')
	use ('hrsh7th/cmp-path')
	use ('hrsh7th/cmp-cmdline')
	use ({'hrsh7th/nvim-cmp',
		config = function() require('plugins.cmp') end,
	})
	use ('hrsh7th/vim-vsnip')


	-- Mason
	use ({"williamboman/mason.nvim",
		config = function() require('plugins.mason') end,
		run = ":MasonUpdate", -- :MasonUpdate updates registry contents
	})

	use ({
    	"williamboman/mason-lspconfig.nvim",
    	"neovim/nvim-lspconfig",
	})

	-- Autotag, autopairs
	use ({
	"windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
	})
	use({'windwp/nvim-ts-autotag', 
	config = function() require("nvim-ts-autotag").setup {} end
	})

	if packer_bootstrap then
		packer.sync()
	end
end)

