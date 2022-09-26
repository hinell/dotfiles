-------------------------------------------------------------plugins-nvim-tree

-- nvim-tree END
--      nvim-tree.lua mappings
local   nvimtreemappings = require("nvim-tree.keymap").keymaps
-- This is from PR 1858 
-- local   nvimtreemappings = require("nvim-tree.api").config.mappings.default()
--        print(vim.inspect(nvimtreemappings))
-- local   keystodisable    = vim.tbl_map(function(e) return e.key end, nvimtreemappings)
            
        -- disable netrw at the very start of your init.lua (strongly advised)
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        require("nvim-tree").setup({
          sort_by = "case_sensitive",
          sync_root_with_cwd = true,
          open_on_tab = true,
          open_on_setup = true,
--        on_attach = function(bufnr)
--              local inject_node = require("nvim-tree.utils").inject_node
--
--              vim.keymap.set("n", "t", inject_node(function(node)
--                  if node then
--                      print(node.absolute_path)
--                  end
--              end), { buffer = bufnr, noremap = true })
--
--              vim.bo[bufnr].path = "/tmp"
--              
--              -- Set up Legendary plugin keybindigns
--              local keymaps = vim.tbl_map(function(e)
--                  local entry = {}
--                  entry.mode  = "n"
--                  entry[1]    = e.key        -- Key
--                  if type(e.key) == "table" then entry[1] = e.key[1] end
--                  entry[2]    = e.callback
--                  entry.description = "Nvim-tree: " .. e.desc
--                  entry.opts = { buffer = bufnr, noremap = true }
--                  return entry
--              end, nvimtreemappings)
--              
--              require("legendary").setup({
--                  keymaps = {
--                      { itemgroup="Nvim-tree: ", keymaps = keymaps }
--                  }
--              })
--            end,
          actions = {
            use_system_clipboard = true
          },
          view = {
            adaptive_size = true,
            side  = "right",
            width = 40
          },
          renderer = {
            group_empty = true,
            icons = {
              webdev_colors = false, 
            }
          },
          filters = {
            dotfiles = false,
          },
          -- Disable all keys to be set up by Legendary 
          remove_keymaps = keystodisable
        })

-- TODO: Move this to legendary Commands
vim.api.nvim_create_autocmd('FileType', {
  pattern =  "NvimTree",
  --NOTE: Turning this one doesn't work 
  --once = true,
  callback = function(event)
        --TODO: Update this to new API: https://github.com/nvim-tree/nvim-tree.lua/issues/1858 
        local   nvimtreemappings = require("nvim-tree.keymap").keymaps
        --local   nvimtreemappings = require("nvim-tree.api").config.mappings.default()
        print("callback activated!")
        --
        -- print(vim.inspect(event))
        --local   keystodisable    = vim.tbl_map(function(e) return e.key end, nvimtreemappings)
        -- Set up Legendary plugin keybindigns
        local keymaps = vim.tbl_map(function(e)
            -- just set up a description-only keymap
            local entry = {}
            entry.mode  = "n"
            entry[1]    = e.key        -- Key
            if type(e.key) == "table" then entry[1] = e.key[1] end
            entry.description = "Nvim-tree: " .. e.desc
            entry.opts = { buffer = event.buf, noremap = true }
            return entry
        end, nvimtreemappings)
        require("legendary").setup({
            keymaps = keymaps
            --[[ keymaps = {
                { itemgroup="Nvim-tree: ", keymaps = keymaps }
            } ]]
        })
  end
})
