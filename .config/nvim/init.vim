" ---------------------------------------------------------------neovim-options
" NOTE: Moved to ~/.config/nvim/lua/init.lua

"-------------------------------------------------------------------vim-imports
source ~/.config/nvim/plugins.vim

"-------------------------------------------------------------------lua-imports
" ~/.config/nvim/lua/pluings.lua
lua require("init")

"-------------------------------------------------------------------keybindings


" cmap <S-Insert> <C-R>+

" SOURCE MSWIN compatiblity shortcuts 
" source $VIMRUNTIME/mswin.vim


" DEPRECATED, USE LUA FOR BINDIGNS
" This was taken directly from $VIMRUNTIME/mswin.vim
" Use CTRL-S for saving, also in Insert mode (<C-O> doesn't work well when
" using completions).
" noremap <C-S>			:update<CR>
" vnoremap <C-S>		<C-C>:update<CR>
" inoremap <C-S>		<Esc>:update<CR>gi
"imap <C-S-BS> <ESC>v<C-Left>
"imap <S-BS> <ESC>v<C-Left>
"imap <C-BS> <ESC>v<C-Left>
"imap <BS> <ESC>v<C-Left>

" vnoremap '<C-S-n>' 'tabnew'
"-------------------------------------------------------------------help-config
" This opens help in vertically split window
" Pipe  (i.g. '|' ) here means multiple commands
" See: https://www.reddit.com/r/neovim/comments/ctrdtq/always_open_help_in_a_vertical_split/

" TODO: Move this to the plugins-legendary.lua
" autocmd! BufAdd * if (&ft ==# 'help' || &ft ==# 'man') | wincmd L | end | " <- This should always be end!
