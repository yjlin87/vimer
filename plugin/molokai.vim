" => Theme and coloring {{{
" Turn on syntax highlighting
syntax on
" Advertise that our terminal supports 256 colors
if (&term =~ "xterm") || (&term =~ "screen")
  set t_Co=256
endif
" Use the Molokai colorscheme
colorscheme molokai
" and a dark background
set background=dark
" }}}

