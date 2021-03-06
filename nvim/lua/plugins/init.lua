
local fn = vim.fn

-- some bootstrapping
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if fn.empty(fn.glob(install_path)) > 0 then
	is_bootstrap = true
	fn.system {'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path}
end

vim.cmd.packadd 'packer.nvim'

-- packer.nvim iss180
fn.setenv('MACOSX_DEPLOYMENT_TARGET', '10.15')

return require('packer').startup(
	function(use)

		-- load package manager
		use 'wbthomason/packer.nvim'

		use 'nvim-lua/plenary.nvim'

		-- telescope
		use {
			'nvim-telescope/telescope.nvim',
			config = function () require'plugins.configs.telescope' end,
			module = 'telescope'
		}

		-- treeshitter
		use {
			'nvim-treesitter/nvim-treesitter',
			run = ':TSUpdate',
			config = function ()
				local present, treesitter = pcall(require, 'nvim-treesitter.configs')
				if not present then return end
				treesitter.setup {
					ensure_installed = {
						'lua'
					},
					highlight = {
						enable = true,
						use_languagetree = true,
					},
				}
			end,
		}

		-- indentation guides
		use {
			event = 'BufRead',
			'lukas-reineke/indent-blankline.nvim',
			config = function ()
				require'indent_blankline'.setup {
					show_first_indent_level = false,
					show_current_context = true,
					filetype_exclude = {'terminal', 'help', 'packer', 'man'},
					bufname_exclue = {'README.md'},
					show_end_of_line = true,
					space_char_blankline = ' '
				}
			end
		}

		use {
			'kyazdani42/nvim-web-devicons',
			config = function() 
				local present, devicons = pcall(require, 'nvim-web-devicons')
				if present then
					devicons.setup()
				end
			end,
		}

		-- zen mode
		use {
			{
				'folke/twilight.nvim',
				module = 'twilight',
				config = function () require'twilight'.setup() end,
				disabled = true
			},
			{
				'folke/zen-mode.nvim',
				cmd = 'ZenMode',
				config = function () require'zen-mode'.setup() end,
				disabled = true
			}
		}

		-- status line
		use {
			'nvim-lualine/lualine.nvim',
			after = {
				'github-nvim-theme'
			},
			config = function ()
				require'lualine'.setup {
					options = {
						theme = 'auto'
					},
					sections = {
						lualine_x = {'filetype'}
					}
				}
			end
		}

		-- git signs in the number column
		use {
			'lewis6991/gitsigns.nvim',
			requires = { 'nvim-lua/plenary.nvim' },
			event = {"BufEnter", "BufWinEnter", "BufRead", "BufNewFile"},
			config = function()
				local present, gitsigns = pcall(require, 'gitsigns')
				if present then
					gitsigns.setup()
				end
			end,
		}

		-- file tree
		use {
			'kyazdani42/nvim-tree.lua',
			config = function () require'nvim-tree'.setup{} end,
			module = 'nvim-tree'
		}

		-- colorschemes
		use {
			'projekt0n/github-nvim-theme',
			config = function ()
				require'github-theme'.setup {
					theme_style = 'dark_default',
					dark_sidebar = false,
					function_style = 'italic',
					variable_style = 'italic'
				}
			end,
			after = 'nvim-web-devicons',
		}
		use {
			'catppuccin/nvim', as = 'catppuccin',
			opt = true,
			disabled = true
		}

		use {
			'williamboman/mason-lspconfig.nvim',
			requires = { 'williamboman/mason.nvim' },
			config = function()
				local present1, mason = pcall(require, 'mason')
				local present2, mason_lspconfig = pcall(require, 'mason-lspconfig')
				if present1 and present2 then
					mason.setup()
					mason_lspconfig.setup()
				end
			end,
			cmd = {
				'LspInstall',
				'LspUninstall',
				'Mason',
				'MasonInstall',
				'MasonInstallAll',
				'MasonUninstall',
				'MasonUninstallAll',
				'MasonLog'
			}
		}

		-- lspconfigs
		use {
			'neovim/nvim-lspconfig',
			event = {"BufEnter", "BufWinEnter", "BufRead", "BufNewFile"}
		}

		-- completion and snippets
		use {
			{
				'hrsh7th/nvim-cmp',
				after = 'nvim-lspconfig',
				requires = { 'hrsh7th/cmp-nvim-lsp' },
				config = function() require 'plugins.configs.cmp' end,
			},
			{'hrsh7th/cmp-buffer', after = 'nvim-cmp'},
			{'hrsh7th/cmp-path', after = 'nvim-cmp'},
			{'hrsh7th/cmp-cmdline', after = 'nvim-cmp'},
			{'L3MON4D3/LuaSnip', after = 'nvim-cmp'},
			{'saadparwaiz1/cmp_luasnip', after = 'LuaSnip'},
		}

		-- autopairs
		use {
			'windwp/nvim-autopairs',
			config = function () require'plugins.configs.autopairs' end,
			after = 'nvim-cmp'
		}

		if is_bootstrap then
			require('packer').sync()
		end

	end)
