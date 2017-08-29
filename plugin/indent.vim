" http://nodsw.com/content/vim
" https://www.cs.oberlin.edu/~kuperman/help/vim/indenting.html

"
" Tab settings for filetypes that should be set even if ftplugin is off.
"
set tabstop=4 softtabstop=4 shiftwidth=4 shiftround expandtab " default

" Tabs are four columns wide. Each indentation level is one tab.
" (Popular with Windows developers using Visual Studio.)
" map \t <Esc>:set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab<CR>
map \t <Esc>:set tabstop=4 softtabstop=4 shiftwidth=4 expandtab<CR>

" Tabs are eight columns wide. Each indentation level is one tab.
" (Popular with the Linux kernel.)
" set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab
" map \T <Esc>:set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab<CR>
map \T <Esc>:set tabstop=8 softtabstop=8 shiftwidth=8 expandtab<CR>

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Use filetype detection and file-based automatic indenting.
  filetype plugin indent on

  " Syntax of these languages is fussy over tabs & spaces
  autocmd FileType make setlocal tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab
  autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd Filetype python setlocal tabstop=8 softtabstop=4 shiftwidth=4 expandtab

  " Customisations based on house-style (arbitrary)
  autocmd FileType sh setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
  autocmd FileType vim setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
  autocmd FileType css setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd FileType javascript setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab

endif

" Some variables you might want to set:
set autoindent                  " Indent at the same level of the previous line

" To indent the current line, or a visual block:
" ctrl-t, ctrl-d  - indent current line forward, backwardsb(insert mode)
" visual > or <   - indent block by sw (repeat with . )

" To stop indenting when pasting with the mouse, add this to your .vimrc:
" set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
" then try hitting the F5 key while in insert mode (or just :set paste).


" vim: set ts=2 sw=2 tw=78 et :

" " Only do this part when compiled with support for autocommands.
" if has("autocmd")

  " " Enable file type detection.
  " " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " " 'cindent' is on in C files, etc.
  " " Also load indent files, to automatically do language-dependent indenting.
  " filetype plugin indent on

  " " Put these in an autocmd group, so that we can delete them easily.
  " augroup vimrcEx
  " au!

  " " For all text files set 'textwidth' to 78 characters.
  " autocmd FileType text setlocal textwidth=78

  " autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  " autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  " " Customisations based on house-style (arbitrary)
  " autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  " autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  " autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab

  " " Treat .rss files as XML
  " autocmd BufNewFile,BufRead *.rss setfiletype xml

  " " When editing a file, always jump to the last known cursor position.
  " " Don't do it when the position is invalid or when inside an event handler
  " " (happens when dropping a file on gvim).
  " " Also don't do it when the mark is in the first line, that is the default
  " " position when opening a file.
  " autocmd BufReadPost *
    " \ if line("'\"") > 1 && line("'\"") <= line("$") |
    " \   exe "normal! g`\"" |
    " \ endif

  " augroup END

" else

  " set autoindent        " always set autoindenting on

" endif " has("autocmd")
