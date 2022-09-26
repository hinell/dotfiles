-- This file can be loaded by calling `lua require("plugins")` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

-- /home/user/.config/nvim
-- /home/user/.config/kdedefaults/nvim
-- /home/user/.local/share/nvim/site
-- /home/user/.local/share/nvim/site/after
-- /etc/xdg/xdg-plasma/nvim
-- /etc/xdg/nvim
-- /usr/share/kubuntu-default-settings/kf5-settings/nvim
-- /usr/share/plasma/nvim/site
-- /usr/local/share/nvim/site
-- /usr/share/nvim/site
-- /usr/share/nvim/runtime
-- /usr/lib/nvim
-- /usr/share/nvim/site/after
-- /usr/local/share/nvim/site/after
-- /usr/share/plasma/nvim/site/after
-- /usr/share/kubuntu-default-settings/kf5-settings/nvim/after
-- /etc/xdg/nvim/after
-- /etc/xdg/xdg-plasma/nvim/after
-- /home/user/.config/kdedefaults/nvim/after
-- /home/user/.config/nvim/after
--
-------------------------------------------------------------------------packer
-- This automatically installs packer.nvim
-- Source: https://github.com/wbthomason/packer.nvim
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

-- print("plugings got loaded")
require("packer").startup(function(use)
  -- Packer can manage itself
  -- use "wbthomason/packer.nvim"

  -- Icons
  use("nvim-tree/nvim-web-devicons") 
  -- Files explorer/tree
  use {
    "nvim-tree/nvim-tree.lua",
    requires = { "nvim-tree/nvim-web-devicons" },
    tag = "nightly" -- optional, updated every week. (see issue #1193)
  } 
-------------------------------------------------------------------------themes
  -- Dark material themes 
  use("marko-cerovac/material.nvim")
---------------------------------------------------------------------statusline
  use({
   "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons", opt = false }
  })
  use("nvim-lua/lsp-status.nvim")
  use("luukvbaal/statuscol.nvim")

  use "lukas-reineke/indent-blankline.nvim"
  use "lukas-reineke/virt-column.nvim"
  use { 
	"akinsho/bufferline.nvim",
	tag = "v3.*",
	requires = "nvim-tree/nvim-web-devicons"
  }
  use "nvim-lua/plenary.nvim"
  use {
	"folke/todo-comments.nvim",
	requires = "nvim-lua/plenary.nvim",
  }
  use({ "mrjones2014/legendary.nvim" }) 
  use {"stevearc/dressing.nvim"} -- UI Imrovements 
  -- use "karb94/neoscroll.nvim"
  use {
	"nvim-telescope/telescope.nvim",
	requires = "nvim-lua/plenary.nvim"
  }
  use("fedepujol/move.nvim")

  -- TODO: [Monday, December 12, 2022] Install & setup configs  
  use("neovim/nvim-lspconfig")
  use("nvim-treesitter/nvim-treesitter")
  use {
    "utilyre/barbecue.nvim",
    requires = {
      "neovim/nvim-lspconfig",
      "smiteshp/nvim-navic",
      "kyazdani42/nvim-web-devicons", -- optional
    },
    after = "nvim-web-devicons", -- NOTICE: keep this if you're using NvChad
    config = function()
        require("barbecue").setup()  
    end
	
  }
  use  "windwp/nvim-autopairs"
  --TODO:remove this, editorconfig is supported by deafult in 9.0
  -- use  "gpanders/editorconfig.nvim"

  use 'numToStr/Comment.nvim'
end)
----------------------------------------FUCK
require("virt-column").setup({
	virtcolumn="80,100"
})

-------------------------------------------------nvim-tree-close-after-last-tab
-- A script to close nvim after last tab is closed 
-- Source: https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
local function tab_win_closed(winnr)
  local api      = require("nvim-tree.api")
  local tabnr    = vim.api.nvim_win_get_tabpage(winnr)
  local bufnr    = vim.api.nvim_win_get_buf(winnr)
  local buf_info = vim.fn.getbufinfo(bufnr)[1]
  local tab_wins = vim.tbl_filter(function(w) return w~=winnr end, vim.api.nvim_tabpage_list_wins(tabnr))
  local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
  if buf_info.name:match(".*NvimTree_%d*$") then            -- close buffer was nvim tree
    -- Close all nvim tree on :q
    if not vim.tbl_isempty(tab_bufs) then                      -- and was not the last window (not closed automatically by code below)
      api.tree.close()
    end
  else                                                      -- else closed buffer was normal buffer
    if #tab_bufs == 1 then                                    -- if there is only 1 buffer left in the tab
      local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
      if last_buf_info.name:match(".*NvimTree_%d*$") then       -- and that buffer is nvim tree
        vim.schedule(function ()
          if #vim.api.nvim_list_wins() == 1 then                -- if its the last buffer in vim
            vim.cmd "quit"                                        -- then close all of vim
          else                                                  -- else there are more tabs open
            vim.api.nvim_win_close(tab_wins[1], true)             -- then close only the tab
          end
        end)
      end
    end
  end
end

vim.api.nvim_create_autocmd("WinClosed", {
  callback = function ()
    local winnr = tonumber(vim.fn.expand("<amatch>"))
    vim.schedule_wrap(tab_win_closed(winnr))
  end,
  nested = true
})

-- /usr/share/nvim/site/pack/packer/start/
---------------------------------------------------------------------------init

-- # nvim-tree
-- disable netrw at the very start of your init.lua (strongly advised)

-- empty setup using defaults
-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  sync_root_with_cwd = true,
  open_on_tab = false,
  on_attach = function(bufnr)
        local inject_node = require("nvim-tree.utils").inject_node

        vim.keymap.set("n", "t", inject_node(function(node)
            if node then
                print(node.absolute_path)
            end
        end), { buffer = bufnr, noremap = true })

        vim.bo[bufnr].path = "/tmp"
  end,
  actions = {
    use_system_clipboard = true
  },
  view = {
    adaptive_size = true,
    mappings = {
      list = {
	-- Mappings are going to be deprecated
        -- You have to use on_attach instead
      },
    },
    side = "right"
  },
  renderer = {
    group_empty = true,
    icons = {
      webdev_colors = false, 
    }
  },
  filters = {
    dotfiles = false,
  }
}) 
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- nvim-tree END

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true;

require"nvim-web-devicons".setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable different highlight colors per icon (default to true)
 -- if set to false all icons will have the default icon"s color
 color_icons = false;
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
} -- nvim-web-devicons END


--# THEME
require("material").setup({
      plugins = { -- Uncomment the plugins that you use to highlight them
        -- Available plugins:
        -- "dap",
        -- "dashboard",
        -- "gitsigns",
        -- "hop",
        "indent-blankline",
        -- "lspsaga",
        -- "mini",
        -- "neogit",
        -- "nvim-cmp",
        -- "nvim-navic",
        "nvim-tree",
        "nvim-web-devicons",
        -- "sneak",
        -- "telescope",
        -- "trouble",
        -- "which-key",
    },
   high_visibility = {
        lighter = false, -- Enable higher contrast text for lighter style
        darker = true    -- Enable higher contrast text for darker style
    }, 
}) -- END material

-- require("material.functions").change_style("darker")
vim.g.material_style = "darker"
vim.cmd "colorscheme material" 

require("lualine").setup({
   options = {
     theme = "auto"
   }
})

vim.opt.list = true
vim.opt.listchars:append "space:⋅"

require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
}

vim.opt.termguicolors = true
require("bufferline").setup {
	options = {
		mode="tabs", -- Disable numberline to the right
		color_icons = false
	}
	
}

--[[ require("neoscroll").setup ({
mappings={} 
}) -- neoscroll END
equire("neoscroll.config").set_mappings({
      ["<C-Up>"]   = {"scroll", {"-0.10", "false", "100"}}, 
["<C-Down>"] = {"scroll", { "0.10", "false", "100"}}
) ]]

-- TODO: Configure this to use `grep` instead of the `rg`
require("todo-comments").setup({
  search = {
    command = "grep",
    args = {
      "--color=never",
      "-n",
      "-E"
    },
    pattern = [[\b(KEYWORDS):]], -- ripgrep regex
  },
})

require("telescope").setup {
	defaults = {
		mappings = {}
	}
}

 require('dressing').setup({
  select = {
    -- Options for fzf selector
    enabled = true
    ,fzf = {
      window = {
        width = 0.4,
        height = 0.4,
      },
    }

    -- Options for fzf_lua selector
    ,fzf_lua = {
      winopts = {
        width = 0.4,
        height = 0.4,
      },
    }
    ,builtin  = {
      min_width = { 160, 0.8 }
    }
    ,get_config = function(opts)
         
      if opts.kind == 'legendary.nvim' then
        return {
          backend = {  "telescope", "builtin" }, 
          telescope = {
              -- Here should go a telescope config
          }
        }
      else
        return {
          window = {
              width= 0.6
          },
          telescope = {}
        }
      end
    end
  }
 })

-- Setup for dressing  END

-- Setup for Telescope
require('telescope').setup({
    defaults = {
        theme = "dropdown"
    }
})

--------------------------------------------------------------------tree-sitter
require('nvim-treesitter.configs').setup({
  -- A list of parser names, or "all"
  ensure_installed = {
	  "c", "cpp", "make", "cmake", "bash", "perl"
	, "regex"
	, "lua"
	, "javascript", "tsx", "html", "css", "scss"
	, "markdown", "markdown_inline"
	, "diff", "gitignore", "git_rebase"
	, "json", "jsonc", "yaml", "toml"
 	, "ebnf"
	, "sql"
	, "query"
  },
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  -- ignore_install = {  },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = {},
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 1024 * 1024 -- 1MB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,

  }
})

require("nvim-autopairs").setup {   
    check_ts=true
}

require("Comment").setup()

-- Note: available only in 9.0.0-dev versions!
-- require("lsp-status").setup()
require("statuscol").setup({
    setopt = true
})
