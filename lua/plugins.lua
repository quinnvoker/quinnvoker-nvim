local vim = vim

-- packer bootstrap
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

-- start packer
vim.cmd('packadd packer.nvim')
local packer = require'packer'
local util = require'packer.util'
packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})
--- startup and add configure plugins
packer.startup(function()
  local use = use
  -- package manager
  use 'wbthomason/packer.nvim'
  -- color theme
  use 'sainnhe/sonokai'
  -- file navigation
  use 'preservim/nerdtree'
  use 'xuyuanp/nerdtree-git-plugin'
  -- project-wide search
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'}
    }
  }
  -- LSP and general syntax highlighting
  use 'nvim-treesitter/nvim-treesitter'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  -- language-specific syntax highlighting
  use 'slim-template/vim-slim'
  -- autocompletion
  use 'hrsh7th/nvim-compe'
  -- allow vim and plugins to use text-based icons
  use 'ryanoasis/vim-devicons'
  use 'vwxyutarooo/nerdtree-devicons-syntax'
  -- status bar
  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    config = function() require'galaxyline/quline' end,
    requires = {'ryanoasis/vim-devicons', opt = true}
  }
  -- git management
  use 'tpope/vim-fugitive'
  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'}
  }
  -- autoformatting and code stylers
  use 'mhartington/formatter.nvim'
  use 'windwp/nvim-autopairs'
  -- snippets
  use 'sirver/ultisnips'
  use 'honza/vim-snippets'
  end
)

-- autopair config
local npairs = require'nvim-autopairs'
local Rule = require'nvim-autopairs.rule'
npairs.setup({
  check_ts = true,
  ts_config = {
    lua = {'string'},
    javascript = {'template_string'}
  }
})

-- Treesitter config
local ts_config = require'nvim-treesitter.configs'
ts_config.setup {
  ensure_installed = 'maintained',
  highlight = {
    enable = true,
  },
  autopairs = {enable = true}
}

-- autopair+Treesitter config
local ts_conds = require'nvim-autopairs.ts-conds'
npairs.add_rules({
  Rule("%", "%", "lua")
    :with_pair(ts_conds.is_ts_node({'string','comment'})),
  Rule("$", "$", "lua")
    :with_pair(ts_conds.is_not_ts_node({'function'}))
})

-- Compe setup
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = false;
    ultisnips = true;
    luasnip = false;
  };
}

-- autopairs+compe config
require'nvim-autopairs.completion.compe'.setup({
  map_cr = true,
  map_complete = true
})

-- LSP setup
local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {}

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)

-- Include the servers you want to have installed by default below
local servers = {
  "bash",
  "css",
  "html",
  "jsonls",
  "tsserver",
  "sumneko_lua",
  "pyright",
  "yamlls",
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      print("Installing " .. name)
      server:install()
    end
  end
end

-- Setup LSP diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

--- Setup gitsigns
require'gitsigns'.setup()

--- Setup formatter
require'formatter'.setup({
  logging = true,
  filetype = {
    javascript = {
      -- prettier
      function()
        return {
          exe = './node_modules/.bin/prettier',
          args = {'--stdin-filepath', vim.api.nvim_buf_get_name(0)},
          stdin = true,
        }
      end
    },
    javascriptreact = {
      -- prettier
      function()
        return {
          exe = './node_modules/.bin/prettier',
          args = {'--stdin-filepath', vim.api.nvim_buf_get_name(0)},
          stdin = true,
        }
      end
    },
    ruby = {
      -- rubocop
      function()
        return {
          exe = "rubocop", -- might prepend `bundle exec `
          args = { '--auto-correct', '--stdin', '%:p', '2>/dev/null', '|', "awk 'f; /^====================$/{f=1}'"},
          stdin = true,
          cwd = vim.fn.expand('%:p:h')
        }
      end
    }
  }
})

-- Auto-format on write
vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.jsx,*.rb FormatWrite
augroup END
]], true)
