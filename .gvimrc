source $VIMRUNTIME/gvimrc_example.vim
if has("gui_gtk2")
    set guifont=Ubuntu\ Mono\ 12
elseif has("gui_win32")
    set guifont=Consolas:h12
endif
