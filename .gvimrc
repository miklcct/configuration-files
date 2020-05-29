source $VIMRUNTIME/gvimrc_example.vim
if has("gui_gtk2")
    set guifont=Ubuntu\ Mono\ 18
elseif has("gui_win32")
    set guifont=Consolas:h18
endif
