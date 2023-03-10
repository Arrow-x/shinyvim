local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	require("packer").packadd = "packer.nvim"
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
local group = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | PackerSync",
	pattern = "plugins.lua",
	group = group,
})

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	use({ "wbthomason/packer.nvim" })
	use({ "nvim-lua/plenary.nvim" })
	use({ "windwp/nvim-autopairs" })
	use({ "numToStr/Comment.nvim" })
	use({ "lewis6991/impatient.nvim" })
	use({ "kylechui/nvim-surround" })
	use({ "Darazaki/indent-o-matic" })
	use({ "mbbill/undotree" })
	use({ "MunifTanjim/nui.nvim" })

	-- ColorSchemes
	use({ "folke/tokyonight.nvim" })
	use({ "gruvbox-community/gruvbox" })

	-- cmp plugins
	use({ "Arrow-x/nvim-cmp" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "saadparwaiz1/cmp_luasnip" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lua" })
	use({ "hrsh7th/cmp-cmdline" })
	use({ "f3fora/cmp-spell" })

	-- snippets
	use({ "L3MON4D3/LuaSnip" })
	use({ "rafamadriz/friendly-snippets" })

	-- LSP
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	use({ "neovim/nvim-lspconfig" })
	use({ "jose-elias-alvarez/null-ls.nvim" })
	use({ "RRethy/vim-illuminate" }) -- Illuminate other uses of current word/symbol under cursor
	use({ "folke/trouble.nvim" })

	--Debug
	use({ "mfussenegger/nvim-dap" })
	use({ "rcarriga/nvim-dap-ui" })
	use({ "ravenxrz/DAPInstall.nvim" })
	use({ "mfussenegger/nvim-dap-python" })
	use({ "theHamsta/nvim-dap-virtual-text" })

	-- Telescope
	use({ "nvim-telescope/telescope.nvim" })

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter" })

	use({ "p00f/nvim-ts-rainbow" })

	-- Git
	use({ "lewis6991/gitsigns.nvim" })

	-- UI
	use({ "kyazdani42/nvim-web-devicons" })
	-- use({ "kyazdani42/nvim-tree.lua" })
	use({ "nvim-neo-tree/neo-tree.nvim" })

	use({ "ThePrimeagen/harpoon" })

	use({ "akinsho/bufferline.nvim" })
	use({ "moll/vim-bbye" })
	use({ "nvim-lualine/lualine.nvim" })
	use({ "akinsho/toggleterm.nvim" })
	use({ "ahmedkhalf/project.nvim" })
	use({ "lukas-reineke/indent-blankline.nvim" })
	use({ "goolord/alpha-nvim" })
	use({ "antoinemadec/FixCursorHold.nvim" }) -- This is needed to fix lsp doc highlight
	use({ "folke/which-key.nvim" })
	use({ "SmiteshP/nvim-navic" })
	use({ "utilyre/barbecue.nvim" })
	use({ "vimwiki/vimwiki" })
	use({ "Pocco81/TrueZen.nvim", commit = "c88840bf8f01bdf48c55c7a7d31de806837856ff" })
	use({ "tools-life/taskwiki" })
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
