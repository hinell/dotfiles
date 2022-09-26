-- ctrl-s oseuuuo save chage

-- print 'keymaps got loaded!'
local table = require "table"
local keymaps = {
  { { 'n', 'v' }, '<C-S-B>', '<C-S-Q>'        ,{ desc="Mode: Visual Block" } } -- CTRL+V
, { { 'n', 'v' }, '<C-S-V>', '<C-S-Q>'        ,{ desc="Mode: Visual Block" } } -- CTRL+V
, { { 'n', 'v' }, '<C-S-B>', '<C-S-Q>'        ,{ desc="Mode: Visual Block" } } -- CTRL+V

----------------------------------------------------------------------clipboard
-- Win32 Style - Copy/Paste 
, { { 'n', 'v' }, '<C-V>', '"+p'        ,{ desc="Clipboard: insert text from" } } -- CTRL+V
, { { 'c' }, '<C-V>', '<C-R>"'          ,{ desc="Clipboard: insert text from" } } -- CTRL+V
, { { 'i' }, '<C-V>', '<ESC>"+pgi'      ,{ desc="Clipboard: insert text from" } } -- CTRL+V
, { { 'v' }, '<C-X>', '"+d'             ,{ desc="Clipboard: cut  selection into clipboard" } }                -- CTRL+X 
, { { 'v' }, '<C-C>', '"+y'             ,{ desc="Clipboard: copy selection into clipboard" } } -- CTRL+C

--------------------------------------------------------------line-manipulation
, { { 'n', 'v' }, '<C-S-K>', '""dd', { desc="Line: delete" } }         -- CTRL+SHIFT+K
, { { 'i' }, '<C-S-K>', '<ESC>""dd<CR>gi', { desc="Line: delete" } }   -- CTRL+SHIFT+K

,{ { "n", "v"  }, "<A-Up>"    , ":MoveLine(-1)<CR>", { desc="Line: move up (Plugin fedepujol/move)", silent=true, noremap=true } }
,{ { "n", "v"  }, "<A-Down>"  , ":MoveLine(1)<CR>",  { desc="Line: move dn (Plugin fedepujol/move)", silent=true, noremap=true } }
,{ { "i" }, "<A-up>",   "<ESC>:MoveLine(-1)<CR>gi", { desc="Line: move up (Plugin fedepujol/move)", silent=true, noremap=true } }
,{ { "i" }, "<A-Down>", "<ESC>:MoveLine(1)<CR>gi",  { desc="Line: move dn (Plugin fedepujol/move)", silent=true, noremap=true } }
-- , { { 'n' }, '<c-s-p>', ':' }

-- disable c-z for
-- , { { 'n' }, '<del>', 'd<Right>' }
-- , { { 'n' }, '<c-n>', 'tabnew' }
--

, { { 'n' }, '<BS>'         , 'a<BS><ESC>'          , { desc="Line: remove previous char"} } 
, { { 'n' }, '<SPACE>'      , 'a<SPACE><ESC><RIGHT>', { desc="Line: inser whitespace"} } 
, { { 'n' }, '<ENTER>'      , 'o'                   , { desc="Line: new" } } -- ENTER
, { { 'n' }, '<C-ENTER>'    , 'O'                   , { desc="Line: new upwards" } } -- SHIFT+ENTER

---------------------------------------------------------------------------tabs
, { { 'n' }, '<C-T>', ':tabnew<CR>' }
, { { 'n' }, '<F28>', ':tabclose<CR>' }
, { { "n", "v" }, "E[5;6~", ":tabmove -1<ESC>", { desc="Tabs: move to the left" } }
, { { "n", "v" }, "E[6;6~", ":tabmove +1<ESC>", { desc="Tabs: move to the right" } }
---------------------------------------------------------------------navigation
, { { 'n' }, '<S-ENTER>', ''   , { desc="Line: scroll page (disabled)" } } -- SHIFT+ENTER

--Scrolling
-- TODO: Replace by built-in command or set up via plugin
, { { 'n', "v" }, '<C-Up>'  , '<C-Y>', { desc="Buffer: scroll up  " } } -- CTRL+UP - Scroll up 
, { { 'n', "v" }, '<C-Down>', '<C-E>', { desc="Buffer: scroll down" } } -- CTRL+DOWN - Scroll down

, { { 'i' }, "<C-Up>"   , "<ESC><C-Y>gi", { desc="Buffer: scroll up  " } } 
, { { 'i' }, '<C-Down>' , '<ESC><C-E>gi', { desc="Buffer: scroll down" } }

-- Buffer: jump to start/middle/end

-- , { { 'v', 'n' }, ''             , '<ESC><M>gi' ,{ desc="Buffer: jump to the middle of the window" } }
, { { 'v', 'n' }, '<C-S-Home>' , '<S-H>'                   ,{ desc="Buffer: jump to the top of the window"    } }
, { { 'v', 'n' }, '<C-S-End>'  , '<S-L>'                   ,{ desc="Buffer: jump to the bottom of the window" } }
, { { 'v', 'n' }, 'E[1;6H' , 'echo "CTRL+HOM is hit"'      ,{ desc="Buffer: jump to the bottom of the window" } }
, { { 'v', 'n' }, 'E[1;6F' , 'echo "CTRL+END is hit"'      ,{ desc="Buffer: jump to the bottom of the window" } }


, { { 'v' }, '<C-A>', '<ESC><C-A>'        ,{ desc="Buffer: select all text" } } -- CTRL+A
, { { 'n' }, '<C-A>', '0ggv<C-End>'      ,{ desc="Buffer: select all text" } } -- CTRL+A
, { { 'v', 'n' }, '<A-Left>'    , '<C-O>', { desc="History: jump to prev cursor pos" } } -- ALT+LEFT 
, { { 'v', 'n' }, '<A-Right>'   , '<C-I>', { desc="History: jump to next cursor pos" } } -- ALT+RIGHT

, { { 'i' }, '<A-Left>'    , '<ESC><C-O>gi', { desc="History: jump to prev cursor pos" } } -- ALT+LEFT 
, { { 'i' }, '<A-Right>'   , '<ESC><C-I>gi', { desc="History: jump to next cursor pos" } } -- ALT+RIGHT

------------------------------------------------------------------------history
-- Win32-style shortcuts
, { { 'n', 'v' }, '<C-S>', ':update<CR><ESC>', { desc="File: save" } } -- CTRL+S 
, { { 'i'      }, '<C-S>', '<ESC>:update<CR>gi', { desc="File: save" } } -- CTRL+S 

, { { 'i' }, '<C-Z>', '<ESC>:undo<CR>gi', { desc="History: undo" } } -- CTRL+Z 
, { { 'i' }, '<C-S-Z>', '<ESC>:redo<CR>gi', { desc="History: redo" } } -- CTRL+SHIFT+Z

, { { 'n', 'v' }, '<C-Z>', ':undo<CR>', { desc="History: undo" } } -- CTRL+Z 
, { { 'n', 'v' }, '<C-S-Z>', ':redo<CR>', { desc="History: redo" } } -- CTRL+SHIFT+Z
, { { 'n', 'v' }, '<C-S-Z>', function() vim.cmd "redo" end, { desc="History: redo" } } -- CTRL-SHIFT+Z

--------------------------------------------------------------line-manipulaiton

-- Removal of a word separated by space or puncutation
-- CTRL +DEL/BS- Remove space-separated world
-- SHIFT+DEL/BS- Remove punct-separated world
-- E[27;6;8  -      SHIFT+BS
-- E[27;6;10 - CTRL+SHIFT+BS
, { { 'i', 'c', 'n', 'v'  }, 'E[27;6;10~', '<Nop>'                  ,{ desc="" } } -- CTRL+SHIFT+BACKSPACE - DISABLED
, { { 'i' }, '<C-Del>', '<ESC><Right>v<C-Right><Left>""di'          ,{ desc="Line: remove next word (inbetween [0-9]|[<>?\"] etc.)" } } -- CTRL+DEL
, { { 'i' }, '<S-Del>', '<ESC><Right>v<S-Right><Left>""di'          ,{ desc="Line: remove next WORD (inbetween blank-chars)" } } -- CTRL+DEL

, { { 'n', 'v'  }, 'E[27;6;8~' , 'v<Right><S-Left>""di'            ,{ desc="Line: remove previous word [0-9]|[<>?\"] etc.)" } } --      SHIFT+BACKSPACEE
, { { 'n', 'v'  }, 'E[27;6;10~', 'v<Right><C-S-Left>""di'          ,{ desc="Line: remove previous word [0-9]|[<>?\"] etc.)" } } -- CTRL+SHIFT+BACKSPACE

, { { 'i'       }, '\b', '<ESC>v<Right><C-Left>""di'             ,{ desc="Line: remove previous word [0-9]|[<>?\"] etc.)" } } -- CTRL+BACKSPACE
, { { 'i'       }, 'E[27;6;8~' , '<ESC>v<Right><S-Left>""di'     ,{ desc="Line: remove previous word [0-9]|[<>?\"] etc.)" } } --      SHIFT+BACKSPACE

-- Visual mode
, { { 'n', 'v' }, '<C-S-A-UP>', 
    function()
    local cursor =  vim.fn.getcurpos()
                    vim.fn.append(cursor[2]-1, vim.fn.getline(cursor[2]));
                    vim.fn.cursor(cursor[2],cursor[3])
    end
    , { desc="Line: duplicate up" } } -- CTRL+SHIFT+ALT+DOWN
, { { 'n', 'v' }, '<C-S-A-DOWN>',
    function()
    local cursor =  vim.fn.getcurpos()
                    vim.fn.append(cursor[2], vim.fn.getline(cursor[2]));
                    vim.fn.cursor(cursor[2]+1,cursor[3])
    end
    , { desc="Line: duplicate down" } } -- CTRL+SHIFT+ALT+DOWN
, { { 'i' }, '<C-S-A-UP>'  , '<ESC>yy:put<CR><UP>gi' , { desc="Line: duplicate up" } } -- CTRL+SHIFT+ALT+DOWN
, { { 'i' }, '<C-S-A-DOWN>', '<ESC>yy:put<CR>gi'     , { desc="Line: duplicate down" } } -- CTRL+SHIFT+ALT+DOWN
-- , { { 'n', 'v' }, '<C-M-S-Down>', '<S-v>' }

, { { 'i' }, '<S-Tab>', '<ESC>yy:put<CR>gi'     , { desc="Line: duplicate" } } -- CTRL+SHIFT+ALT+DOWN
--nvim-tree-lua
, { { 'n', 'v' }, '<M-1>', ':NvimTreeToggle<CR><ESC>', { desc="File: explorer: toggle (nvim-tree)" } } -- ALT+1
--[[ , { { 'n', 'v' }, '<M-1>', function()
    print(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()))
end, { desc="File: explorer: toggle (nvim-tree)" } } -- ALT+1 ]]
---------------------------------------------------------------------completion
, { { 'i' }, '<C-Space>', '<C-P>', { desc="Buffer: show completion prompt" } }

} -- Keybindings END




-- @brief I initialize keybinings either via built-in API or by Plugin
function keymaps:init(isLegendaryPlugin)
        local keymaps = self
        if isLegendaryPlugin then  
                -- Conver to Legendary-friendly entry
                for i=1,#keymaps do
                        -- Convert to full description field
                        local   entry = keymaps[i]
                        local   eKeyMap={}
                        entry.mode = entry[1];
                        entry[1] = nil;
----            for ei = 1,#(entry[1]) do       
----                    local mode=entry[1][ei]
----                    eKeyMap[mode] = entry[3]
----            end
                        -- entry[3] = nil
                        entry[1] = entry[2]
                        -- entry[2] = eKeyMap
                        entry[2] = entry[3]
                        if entry[4] then
                                entry.description = entry[4].desc;
                                entry[4].desc = nil;
                                entry.opts=entry[4];
                                entry[3]=nil
                        end
                end
        end

        if not isLegendaryPlugin then

                for i=1,#keymaps do
                        local mode = keymaps[i][1]
                        local key  = keymaps[i][2]
                        local cmd  = keymaps[i][3]
                        local opt  = keymaps[i][4] 
                        -- print(mode, key, cmd, opt.des)
                        vim.keymap.set( mode, key, cmd, opt)
                end
        end
        return keymaps
end
-- sdfsdf
return keymaps
