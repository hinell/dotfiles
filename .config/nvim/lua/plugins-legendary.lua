local toolbox   = require('legendary.toolbox')
local filters   = require('legendary.filters')

local legendary = require('legendary.filters')
                  require('platform')
                  
local keymaps = {
    -- map keys to a command
--    { 'ff', ':Telescope find_files<CR>', description = 'Find files' },
    -- map keys to a function
 --   { 'h', function() print('hello world!') end, description = 'Say hello' },
    -- keymaps have opts.silent = true by default, but you can override it
 --   { 's', ':SomeCommand<CR>', description = 'Non-silent keymap', opts = { silent = false } },
    -- create keymaps with different implementations per-mode
--  {
--      'c',
--    { n = ':LinewiseCommentToggle<CR>', x = ":'<,'>BlockwiseCommentToggle<CR>" },
--    description = 'Toggle comment'
--  }
  
-- Plugin: Legendary 
	  { mode = { "n", "v" , "i" }, '<C-S-P>', function () require('legendary').find({ filters = { filters.current_mode() } }) end, description="Tabs: Command palette (Legendary plugin)" }
	, { mode = { "n" }, "<C-P>", '<ESC>:Telescope buffers<CR>', description="Tabs: Jump to opened tab (Telescope plugin)" }
        , { mode = { "n", "v" }, "gcc", description= "Line: toggle comment: linewise  (Comment plugin)" }
        , { mode = { "n", "v" }, "gbc", description="Block: toggle comment: blockwise (Comment plugin)" }
}

local commands = {
    -- These cannot be used to create long commands, use functions instead
   -- { 'Telescope', ':Telescope', description = 'Navigation: fuzzy search (Telescope)' },
   -- { 'Naviga go to tab (Telescope)', function() vim.cmd(':Telescope') end, description = 'Luanch Telescope menu to find files' },
   -- { 'Control: commands palette' , function() vim.cmd(':Legendary commands') end, description = 'Launch menu to select commands' },
   -- { 'Control: shortcuts palette ', function() vim.cmd(':Legendary kemaps') end, description = 'Launch menu to select keymaps/shortcuts' }
}

local autocmds = {
    -- Create autocmds and augroups
   { 'BufWritePre',
        function()
	   if #vim.lsp.get_active_clients() > 0 then
		return vim.lsp.buf.format()
	   end
	end, description = 'Format on save'
    },
    {
      name = 'MyAugroup',
      clear = true,
      -- autocmds here
    },
}

local functions = {
    -- Make arbitrary Lua functions that can be executed via the item finder
    { description = 'Clipboard: copy current file path: absolute', function() vim.fn.setreg('+', vim.fn.expand('%:p')) end }
   ,{ description = 'Clipboard: copy current file path: relative', function() vim.fn.setreg('+', vim.fn.expand('%'  )) end }
   ,{ description = 'File: fuzzy search (Telescope plugin)', function() vim.cmd(':Telescope') end }
   ,{ description = 'File: find files (Telescope plugin)'  , function() vim.cmd(':Telescope find_files') end }
   ,{
	itemgroup="Plugin manager:",
	funcs={
		 { description = 'Plugins: install (Packer plugin)', function() vim.cmd(":PackerInstall") end }
		,{ description = 'Plugins: update  (Packer plugin)', function() vim.cmd(":PackerUpdate") end }
		,{ description = 'Plugins: treesitter: install', function()
			vim.cmd(":TSInstall " .. vim.fn.input("Enter tree-sitter language name: "))
			end
		}
	}
   }
   ,{
       description = "System: insert current date",
       function()
           local cur            = vim.fn.getcurpos();
           local bufname        = vim.fn.bufname()
           local linecontent    = vim.fn.getbufline(bufname, cur[2])[1]
                 print(vim.inspect(linecontent) )
                 linecontent    = String.insert(linecontent, vim.fn.getcurpos()[3], os.date("%A, %B %e, %Y"))
                 vim.fn.setbufline(bufname, cur[2], linecontent)
        end
    },
    {
        description = "Custom selector",
        function()
            vim.ui.select({'apple', 'banana', 'mango'}, {
              prompt = "Title",
              telescope = require("telescope.themes").get_cursor(),
            }, function(selected) end)
        end
    }
-- -- Plugin Comment.nvim 
--     , { description= "Line: toggle comment: linewise  (Comment plugin)", function() vim.fn.feedkeys("gcc", 't') end }
--     , { description="Block: toggle comment: blockwise (Comment plugin)", function() vim.fn.feedkeys("gbc", 't') end }
}

return {
  keymaps   = keymaps,
  commands  = commands,
  autocmds  = autocmds, 
  funcs     = functions
}
