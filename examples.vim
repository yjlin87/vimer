"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Tips Wiki
" http://vim.wikia.com/wiki/Vim_Tips_Wiki
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on   " Automatically detect file types.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" <F8> or \a
" yank all lines
nnoremap <silent><F8> gg"+yG
nnoremap <silent><leader>a gg"+yG

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" <F3> toggle between dark and light backgrounds
nnoremap <silent><F3> :let &background=(&background == "dark"?"light":"dark")<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark         " Assume a dark background

" Allow to trigger background
function! ToggleBG()
    let s:tbg = &background
    " Inversion
    if s:tbg == "dark"
        set background=light
    else
        set background=dark
    endif
endfunction
noremap <leader>bg :call ToggleBG()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('clipboard')
    if has('unnamedplus')  " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else         " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" In this example, the F12 key is mapped to either enable or disable the mouse.
nnoremap <F12> :call ToggleMouse()<CR>
function! ToggleMouse()
  if &mouse == 'a'
    set mouse=
    echo "Mouse usage disabled"
  else
    set mouse=a
    echo "Mouse usage enabled"
  endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" It's easier to toggle a boolean option, for example:
nnoremap <F12> :set number!<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! HighlightTabs()
    if &filetype!="help"
        syntax match TAB /\t/ containedin=ALL
        highlight TAB ctermbg=red ctermfg=white cterm=underline
    endif
endfunction
function! HighlightTrailingWhitespace()
    if &filetype!="help"
        syntax match TRAILING /[\t ]*$/ containedin=ALL
        highlight TRAILING ctermbg=red ctermfg=white cterm=underline
    endif
endfunction
function! HighlightParens()
    "Level1(Level2(Level3(Level4(Level5(Level6())))))
    syntax region par1 matchgroup=par1 start=/(/ end=/)/ contains=par2 containedin=ALL
    syntax region par2 matchgroup=par2 start=/(/ end=/)/ contains=par3 contained
    syntax region par3 matchgroup=par3 start=/(/ end=/)/ contains=par4 contained
    syntax region par4 matchgroup=par4 start=/(/ end=/)/ contains=par5 contained
    syntax region par5 matchgroup=par5 start=/(/ end=/)/ contains=par6 contained
    syntax region par6 matchgroup=par6 start=/(/ end=/)/ contains=par1 contained
    highlight par1 ctermfg=red guifg=red
    highlight par2 ctermfg=blue guifg=blue
    highlight par3 ctermfg=darkgreen guifg=darkgreen
    highlight par4 ctermfg=yellow guifg=yellow
    highlight par5 ctermfg=DarkMagenta guifg=DarkMagenta
    highlight par6 ctermfg=white guifg=white
endfunction
au BufEnter,BufRead * call HighlightTabs()
au BufEnter,BufRead * call HighlightTrailingWhitespace()
au BufEnter,BufRead * call HighlightParens()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 相对行号: 行号变成相对，可以用 nj/nk 进行跳转
set relativenumber number
au FocusLost * :set norelativenumber number
au FocusGained * :set relativenumber
" 插入模式下用绝对行号, 普通模式下用相对
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber number
  else
    set relativenumber
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>















" vim: set ts=2 sw=2 tw=2 et :
