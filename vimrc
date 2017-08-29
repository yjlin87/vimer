""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Copyright (c) 2017 Yujiang Lin(linyujiang@hotmail.com)
"
" MIT License
"
" Permission is hereby granted, free of charge, to any person obtaining
" a copy of this software and associated documentation files (the
" "Software"), to deal in the Software without restriction, including
" without limitation the rights to use, copy, modify, merge, publish,
" distribute, sublicense, and/or sell copies of the Software, and to
" permit persons to whom the Software is furnished to do so, subject to
" the following conditions:
"
" The above copyright notice and this permission notice shall be
" included in all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
" EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
" MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
" NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
" LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
" OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
" WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Advertise that our terminal supports 256 colors
if (&term =~ "xterm") || (&term =~ "screen")
  set t_Co=256
endif

" Use the Molokai colorscheme
if (&t_Co == 256)
  colorscheme molokai
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Don't use Ex mode, use Q for formatting
map Q gq

" w!! to sudo & write a file
cmap w!! w !sudo tee >/dev/null %

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim plugin manager
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 1. Automatic installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" 2. Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" 3. Declare the list of plugins.
Plug 'yianwillis/vimcdoc'
Plug 'gmarik/github-search.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" 4. List ends here. Plugins become visible to Vim after this call.
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug 'asins/vimcdoc'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vim/plugged/vimcdoc/syntax/help_cn.vim"))
  " Vim plugin to set the default help language to Chinese
  if version >= 603
    set helplang=cn
    set encoding=utf-8
  endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug 'tomasr/molokai'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vim/plugged/molokai/colors/molokai.vim"))
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
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug 'scrooloose/nerdcommenter' " 快速注释代码
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if isdirectory(expand("~/.vim/plugged/nerdcommenter"))
  let g:NERDSpaceDelims=1    " 注释的时候自动加个空格
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug 'scrooloose/nerdtree'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if isdirectory(expand("~/.vim/plugged/nerdtree"))
  nnoremap <silent> <leader>nt :NERDTreeToggle<CR>
  " How can I close vim if the only window left open is a NERDTree?
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug 'majutsushi/tagbar'      " 标签导航
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if isdirectory(expand("~/.vim/plugged/tagbar/"))
  nnoremap <silent> <leader>tt :TagbarToggle<CR>
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 智能补全和模板补全
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if isdirectory(expand("~/.vim/plugged/neocomplete.vim"))
  " NeoBundle 'Shougo/neocomplete.vim'
  let g:acp_enableAtStartup = 0
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#enable_auto_delimiter = 1
  let g:neocomplete#max_list = 15
  let g:neocomplete#force_overwrite_completefunc = 1

elseif isdirectory(expand("~/.vim/plugged/neocomplcache.vim"))
  " NeoBundle 'Shougo/neocomplcache.vim'
  let g:acp_enableAtStartup = 0
  let g:neocomplcache_enable_at_startup = 1
  let g:neocomplcache_enable_camel_case_completion = 1
  let g:neocomplcache_enable_smart_case = 1
  let g:neocomplcache_enable_underbar_completion = 1
  let g:neocomplcache_enable_auto_delimiter = 1
  let g:neocomplcache_max_list = 15
  let g:neocomplcache_force_overwrite_completefunc = 1
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug 'vim-airline/vim-airline'  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if isdirectory(expand("~/.vim/plugged/vim-airline"))
  set laststatus=2
  " enable/disable enhanced tabline
  let g:airline#extensions#tabline#enabled = 1
  " enable/disable displaying index of the buffer.
  let g:airline#extensions#tabline#buffer_idx_mode = 1
  nmap <leader>1 <Plug>AirlineSelectTab1
  nmap <leader>2 <Plug>AirlineSelectTab2
  nmap <leader>3 <Plug>AirlineSelectTab3
  nmap <leader>4 <Plug>AirlineSelectTab4
  nmap <leader>5 <Plug>AirlineSelectTab5
  nmap <leader>6 <Plug>AirlineSelectTab6
  nmap <leader>7 <Plug>AirlineSelectTab7
  nmap <leader>8 <Plug>AirlineSelectTab8
  nmap <leader>9 <Plug>AirlineSelectTab9
  nmap <leader>- <Plug>AirlineSelectPrevTab
  nmap <leader>+ <Plug>AirlineSelectNextTab

  " Set configuration options for the statusline plugin vim-airline.
  " Use the powerline theme and optionally enable powerline symbols.
  " To use the symbols , , , , , , and .in the statusline
  " segments add the following to your .vimrc.before.local file:
  " let g:airline_powerline_fonts=1
  " If the previous symbols do not render for you then install a
  " powerline enabled font.
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Highlighting that moves with the cursor
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cursorline cursorcolumn
autocmd WinLeave * setlocal nocursorline nocursorcolumn
autocmd WinEnter * setlocal cursorline cursorcolumn
" SignColumn should match background
highlight clear SignColumn
" Current line number row will have same background color in relative mode
highlight clear LineNr
" Remove highlight color from current line number
highlight clear CursorLineNr


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 一键去除所有尾部空白
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
imap <leader>rb <ESC>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
nmap <leader>rb :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
vmap <leader>rb <ESC>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 一键去除^M字符
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
imap <leader>rm <ESC>:%s/<c-v><c-m>//g<CR>
nmap <leader>rm :%s/<c-v><c-m>//g<CR>
vmap <leader>rm <ESC>:%s/<c-v><c-m>//g<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim 自身命令行模式智能补全
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" From Janus, http://git.io/PLbAlw
" Better command-line completion
set wildmenu " {{{
" Complete like most shells – longest substring first, then iterate through
" full matches
set wildmode=longest:full,full
" set wildmode=list:longest,list:full
" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
" Disable temp and backup files
set wildignore+=*.swp,*~,._*
" }}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 中文文件编码
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设置vim内部编码格式
set encoding=utf-8

" 让vim自动识别文件格式
set fileformats=unix,dos,mac
" 查看文件格式
" set fileformat
" 设置（转换）文件格式
" set fileformat=unix

" Vim可以自动判断文件的编码
if v:version >= 700
  " 设置新文件的编码为 UTF-8
  set fileencoding=utf8
  " 自动判断编码时，依次尝试以下编码：
  set fileencodings=ucb-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1,default
endif

" 如遇Unicode值大于255的文本，不必等到空格再折行。
set formatoptions+=m
" 合并两行中文时，不在中间加空格：
set formatoptions+=B

" 解决windows下，当encoding设置utf-8，菜单乱码的问题
if has('win32') || has('win64')
  set langmenu=zh_CN.UTF-8
  language message zh_CN.UTF-8
  source $VIMRUNTIME/delmenu.vim
  source $VIMRUNTIME/menu.vim
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The end
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim: set ts=2 sw=2 tw=78 et :
