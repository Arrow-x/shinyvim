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
	use({ "wbthomason/packer.nvim", commit = "e4c2afb37d31e99b399425e102c58b091fbc16be" })
	use({ "nvim-lua/plenary.nvim", commit = "986ad71ae930c7d96e812734540511b4ca838aa2" })
	use({ "windwp/nvim-autopairs", commit = "fa6876f832ea1b71801c4e481d8feca9a36215ec" })
	use({ "numToStr/Comment.nvim", tag = "v0.6.1" })
	use({ "lewis6991/impatient.nvim", commit = "969f2c5c90457612c09cf2a13fee1adaa986d350" })
	use({ "kylechui/nvim-surround" })
	use({ "Darazaki/indent-o-matic", commit = "bf37c6e4ccd17197d32dee69cffab4f5bbe4cbf2" })
	use({ "mbbill/undotree" })

	-- ColorSchemes
	use({ "folke/tokyonight.nvim" })
	use("gruvbox-community/gruvbox")

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp", commit = "9897465a7663997b7b42372164ffc3635321a2fe" })
	use({ "hrsh7th/cmp-buffer", commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323" })
	use({ "hrsh7th/cmp-path", commit = "466b6b8270f7ba89abd59f402c73f63c7331ff6e" })
	use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" })
	use({ "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" })
	use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" })
	use({ "hrsh7th/cmp-cmdline", commit = "c36ca4bc1dedb12b4ba6546b96c43896fd6e7252" })
	use({ "f3fora/cmp-spell", commit = "5602f1a0de7831f8dad5b0c6db45328fbd539971" })

	-- snippets
	use({ "L3MON4D3/LuaSnip", commit = "79b2019c68a2ff5ae4d732d50746c901dd45603a" })
	use({ "rafamadriz/friendly-snippets", commit = "d27a83a363e61009278b6598703a763ce9c8e617" })

	-- LSP
	use({ "neovim/nvim-lspconfig", commit = "148c99bd09b44cf3605151a06869f6b4d4c24455" })
	use({ "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" })
	use({ "jose-elias-alvarez/null-ls.nvim", commit = "ff40739e5be6581899b43385997e39eecdbf9465" })
	use({ "RRethy/vim-illuminate", commit = "c82e6d04f27a41d7fdcad9be0bce5bb59fcb78e5" }) -- Illuminate other uses of current word/symbol under cursor

	--Debug
	use({ "mfussenegger/nvim-dap", commit = "014ebd53612cfd42ac8c131e6cec7c194572f21d" })
	use({ "rcarriga/nvim-dap-ui", commit = "d76d6594374fb54abf2d94d6a320f3fd6e9bb2f7" })
	use({ "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" })
	use({ "mfussenegger/nvim-dap-python", commit = "2911f31f0ac830b95112a642a0fccd2b1a5d967a" })
	use({ "theHamsta/nvim-dap-virtual-text", commit = "9b731b9748d243b60e61eecbe2d114c39554486e" })

	-- Telescope
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		commit = "518e27589c0463af15463c9d675c65e464efc2fe",
	})

	use({ "p00f/nvim-ts-rainbow", commit = "18cb3a45e0ff843d48e8637a36b9cc6cd89d71b0" })

	-- Git
	use({ "lewis6991/gitsigns.nvim", commit = "c18e016864c92ecf9775abea1baaa161c28082c3" })

	-- UI
	use({ "kyazdani42/nvim-tree.lua", commit = "bdb6d4a25410da35bbf7ce0dbdaa8d60432bc243" })
	use({ "kyazdani42/nvim-web-devicons", commit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e" })
	use({ "akinsho/bufferline.nvim", commit = "c78b3ecf9539a719828bca82fc7ddb9b3ba0c353" })
	use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })
	use({ "nvim-lualine/lualine.nvim", commit = "3362b28f917acc37538b1047f187ff1b5645ecdd" })
	use({ "akinsho/toggleterm.nvim", commit = "aaeed9e02167c5e8f00f25156895a6fd95403af8" })
	use({ "ahmedkhalf/project.nvim", commit = "541115e762764bc44d7d3bf501b6e367842d3d4f" })
	use({ "lukas-reineke/indent-blankline.nvim", commit = "6177a59552e35dfb69e1493fd68194e673dc3ee2" })
	use({ "goolord/alpha-nvim", commit = "ef27a59e5b4d7b1c2fe1950da3fe5b1c5f3b4c94" })
	use({ "antoinemadec/FixCursorHold.nvim", commit = "1bfb32e7ba1344925ad815cb0d7f901dbc0ff7c1" }) -- This is needed to fix lsp doc highlight
	use({ "folke/which-key.nvim", commit = "bd4411a2ed4dd8bb69c125e339d837028a6eea71" })
	use({ "SmiteshP/nvim-gps" })
	use("vimwiki/vimwiki")
	use("Pocco81/TrueZen.nvim")
	use("tools-life/taskwiki")
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
