local   opt = vim.opt
        
        opt.clipboard="unnamed,unnamedplus"
        opt.undofile=true
        opt.undolevels=1024
        opt.wrap=true
        opt.smartindent=true
        opt.linebreak=true -- Break on 
        opt.updatetime=500 -- Time to save (in ms.)
        opt.whichwrap:append("<,>,[,]") -- Allo <Left>/<Right> to move across s
        -- opt.virtualedit="all"
---------------------------------------------------------------------ui-related
        opt.showtabline=1
        -- opt.colorcolumn="80"
        opt.splitright=true 
        opt.cursorline=false  -- highlight current line
        opt.cursorcolumn=false  -- highlight current column

        -- See also: `h :behave`
        -- opt.keymodel='startsel' -- Activate selection upton shift+arrow
        -- opt.selmode=inclusive
        opt.laststatus=3
        -- opt.completeopt="menu,menuone,preview,noselect"
        opt.completeopt="menu,menuone,preview,noinsert"
        -- opt.titlestring="%<%F%=%l/%L-%P"
        -- opt.titlestring="%t%( %M%)%( (%{expand(\"%:~:.:h\")})%)%( %a%)"
        -- opt.titlestring=" %{getcwd()} [ %t%( %M%)%( (%{expand(\"%:~:.:h\")})%)%( %a%) ]"
        opt.title=true
        opt.titlestring="%{getcwd()} : %{expand(\"%:r\")} [%M] ― Neovim"
        opt.titlelen=127
        
        -- opt.winbar="%M"
        -- opt.guicursor  -- This one should be in ginit
        opt.switchbuf="newtab"
-------------------------------------------------------------------------buffer
        -- opt.indent_blanking_char=""
        opt.number=true     -- Left pane with numbers for code
        opt.numberwidth=6
        -- Buggy
        opt.foldcolumn="auto"

        opt.listchars="tab:⇢ "
        opt.expandtab=true
        opt.softtabstop=4
        opt.shiftwidth=4
        
------------------------------------------------------------------------plugins
-- ./lua
        require("platform")
        require("plugins")

-- TODO: Don't forget to integrate keymaps from different sources!
local   legendaryCfg    = require("plugins-legendary") 
local   keymaps         = require("keymaps"):init(true)
	-- NOTE: the legendary plugin expects a table, not objects 
        -- The folloing fixes an error "not a list"
        keymaps.init = nil
        keymaps = vim.list_slice(keymaps, 1, #keymaps)

        print("DEBUG: legendary.keymaps =>", vim.inspect(#legendaryCfg.keymaps))
        print("DEBUG:           keymaps =>", vim.inspect(#keymaps))
        legendaryCfg.keymaps = vim.list_extend(legendaryCfg.keymaps, keymaps)
        print("DEBUG: legendary.keymaps =>", vim.inspect(#legendaryCfg.keymaps))
        require('legendary').setup {
          keymaps   = legendaryCfg.keymaps,
          commands  = legendaryCfg.commands,
          autocmds  = legendaryCfg.autocmds, 
          funcs     = legendaryCfg.functions
        }
        require("plugins-nvim-tree")


        opt.foldmethod="expr"
        opt.foldexpr="nvim_treesitter#foldexpr()"
        opt.foldenable=false 
 
       
