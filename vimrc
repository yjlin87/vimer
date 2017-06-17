"---------------------------------------------------------------------------------------------------------------------
" 作者：林育江
" 邮箱：linyujiang@hotmail.com
" 版本：2017.05
"---------------------------------------------------------------------------------------------------------------------
" 配合NERDTree、CtrlP、ctags、taglist等插件，Vim可以成为一款优秀的代码浏览工具。

" => 用户定义函数 {

  " Setting up the directories {
    function! s:get_cache_dir(suffix)
      return resolve(expand('~/.cache/vim' . '/' . a:suffix))
    endfunction

    function! EnsureExists(path)
      if !isdirectory(expand(a:path))
        call mkdir(expand(a:path), 'p')
      endif
    endfunction
  " }

" }

" Key (re)Mappings {
" 说明：使用:map命令，可以列出所有键盘映射。

  " The default leader is '\', but many people prefer ',' as it's in a standard location.
  let mapleader = ','

  " pastetoggle (sane indentation on pastes)
  set pastetoggle=<F12>

" }

" => 插件管理 {
  " http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
  " Setting up Vundle - the vim plugin bundler
  if !filereadable(expand('~/.vim/bundle/neobundle.vim/README.md'))
    echo "Installing NeoBundle"
    echo ""
    silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
  endif

  " Required:
  " set the runtime path to include Vundle and initialize
  set runtimepath+=~/.vim/bundle/neobundle.vim/

  " Required:
  call neobundle#begin(expand('~/.vim/bundle/'))

  " Required:
  " Let NeoBundle manage NeoBundle
  NeoBundleFetch 'Shougo/neobundle.vim'

  " Recommended to install {

    " 显示目录 (The NERD Tree)
    NeoBundle 'scrooloose/nerdtree'
    " 按 F2 即可显示或隐藏NerdTree
    map <F2> :NERDTreeToggle<CR>

    NeoBundle 'majutsushi/tagbar'
    map <F3> :Tagbar<CR>

    " 批量注释 (NERD Commenter)
    NeoBundle 'scrooloose/nerdcommenter'
    let NERDSpaceDelims = 1
    let NERDRemoveExtraSpaces = 1

    " github-search.vim is a Vim plugin to search Github within Vim.
    NeoBundle 'gmarik/github-search.vim'

    " 状态栏 (vim-airline)
    if has('statusline')
      NeoBundle 'vim-airline/vim-airline'
      set laststatus=2
    endif

    " 文件查找 (CtrlP)
    NeoBundle 'ctrlpvim/ctrlp.vim'
    NeoBundle 'tacahiroy/ctrlp-funky'

    " 智能补全和模板补全
    if has('lua')
      NeoBundle 'Shougo/neocomplete.vim'
    else
      NeoBundle 'Shougo/neocomplcache.vim'
    endif

    " 显示中文帮助
    if version >= 603
      NeoBundle 'asins/vimcdoc'
      set helplang=cn
      set encoding=utf-8
    endif

    " Verilog HDL/SystemVerilog HDVL indent file
    NeoBundle 'verilog.vim'
    " Syntax highlighting for Xilinx Vivado TCL scripts
    NeoBundle 'vim-xtcl-syntax'
    " Syntax highlighting for Xilinx Design Constraints
    NeoBundle 'vim-xdc-syntax'

  " }

  " Required:
  call neobundle#end()

  " Required:
  " All of your Plugins must be added before the following line
  filetype plugin indent on

  " Brief help
  " :NeoBundleList          - list configured bundles
  " :NeoBundleInstall(!)    - install(update) bundles
  " :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

  " If there are uninstalled bundles found on startup,
  " this will conveniently prompt you to install them.
  NeoBundleCheck

" }

" General {
  set hidden                                 " Allow buffer switching without saving
  set nowrap                                 " Do not wrap long lines
  set t_ti= t_te=                            " 退出vim后，内容显示在终端屏幕
" }

" Wild settings —— vim 自身命令行模式智能补全 {
  " From Janus, http://git.io/PLbAlw
  " Better command-line completion
  set wildmenu
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
" }

" Match and search {
  set hlsearch        " Highlight search results
  set incsearch       " Makes search act like search in modern browsers
  set ignorecase      " Ignore case when searching
  set smartcase       " When searching try to be smart about cases
" }

" => 语法高亮 {
  " Vim5 and later versions support syntax highlighting. Uncommenting the next
  " line enables syntax highlighting by default.
  if has("syntax")
    " 开启语法高亮功能
    syntax enable
    " 允许用指定语法高亮配色方案替换默认方案
    syntax on
  endif
" }

" Highlight problematic whitespace {
  " Show trailing spaces as dots and carrots for extended lines.
  " From Janus, http://git.io/PLbAlw
  "
  " displaying listchars
  "set list " {
    " Reset the listchars
    set listchars=""
    " make tabs visible
    set listchars=tab:››
    " show trailing spaces as dots
    set listchars+=trail:•
    " The character to show in the last column when wrap is off and the line
    " continues beyond the right of the screen
    set listchars+=extends:>
    " The character to show in the last column when wrap is off and the line
    " continues beyond the right of the screen
    set listchars+=precedes:<
  " }
" }

" => Highlighting that moves with the cursor {
  set cursorline cursorcolumn
  autocmd WinLeave * setlocal nocursorline nocursorcolumn
  autocmd WinEnter * setlocal cursorline cursorcolumn
  " SignColumn should match background
  highlight clear SignColumn
  " Current line number row will have same background color in relative mode
  highlight clear LineNr
  " Remove highlight color from current line number
  highlight clear CursorLineNr
" }

" => 主题风格 {
  " Explicitly tell vim that the terminal supports 256 colors,
  " need before setting the colorscheme
  if &term == 'xterm' || &term == 'screen'
      set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
  endif
  "if (&term =~ "xterm") || (&term =~ "screen")
    "set t_Co=256
  "endif
  " Colorscheme
  colorscheme molokai
  " If using a dark background within the editing area and syntax highlighting
  " turn on this option as well
  set background=dark         " Assume a dark background
" }

" => 解决编码问题 {
  " 让vim自动识别文件格式
  set fileformats=unix,dos,mac
  " 查看文件格式
  " set fileformat
  " 设置（转换）文件格式
  set fileformat=unix

  " 自动判断编码时，依次尝试以下编码：
  set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1,default
  " 设置新文件的编码为 UTF-8
  set fileencoding=utf-8

  " 解决Windows下乱码问题
  if has('win32') || has('win64')
    set encoding=utf-8
    set langmenu=zh_CN.UTF-8
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    language message zh_CN.UTF-8
  endif
" }

" 查看自定义函数原型：vim 配合 ctags/cocope 实现函数原型快速定位 {
  if executable('ctags')
    " 该功能依赖于ctags工具。[9]安装好ctags后，在存放代码的文件夹
    "   ctags -R .
    " 即可生成一个描述代码结构的tags文件。
    " 实现vim对tags的自动递归查找:
    set autochdir    " 自动切换目录
    set tags=tags;   " 自动查找
    " 设置好后，可在Vim中使用如下功能:Ctrl-]转至最佳匹配的相应Tag，Ctrl-T返回上一个匹配。
    " 如果有多个匹配，g Ctrl-]可显示所有备选的tags。
    " 注意：tags文件不会自动更新，所以当你中途修改了代码时，应该手动重新生成tags文件，
    " vim会随时更新加载tags文件所以不用重启。当前重新生成ctags的快捷键为<Ctrl-F12>
    map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
  endif

  " This tests to see if vim was configured with the '--enable-cscope' option
  " when it was compiled.  If it wasn't, time to recompile vim...
  if has("cscope")
    " cscope find的用法:
    "
    " cs find c|d|e|f|g|i|s|t name
    "
    " s: 查找C语言符号，即查找函数名、宏、枚举值等出现的地方
    " g: 查找函数、宏、枚举等定义的位置，类似ctags所提供的功能
    " d: 查找本函数调用的函数
    " c: 查找调用本函数的函数
    " t: 查找指定的字符串
    " e: 查找egrep模式，相当于egrep功能，但查找速度快多了
    " f: 查找并打开文件，类似vim的find功能
    " i: 查找包含本文件的文件

    "  < cscope 工具配置 >
    " 指定用来执行 cscope 的命令
    " set csprg=/usr/bin/cscope

    " 设定可以使用 quickfix 窗口来查看 cscope 结果
    " 可以用下面的命令来跳转:
    " :cw      // 打开quickfix
    " :cn      // 切换到下一个结果
    " :cp      // 切换到上一个结果
    " :cclose  // 关闭quickfix
    set cscopequickfix=s-,c-,d-,i-,t-,e-

    " 使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳转
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=1

    " 实现vim对tags的自动递归查找
    " 通过 .vim/plugin 目录下的 autoload_cscope.vim 实现的。

    " 在当前目录中添加任何数据库
    if filereadable("cscope.out")
      cs add cscope.out
      "否则添加数据库环境中所指出的
    elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
    endif

    " 显示添加成功与否
    set cscopeverbose

  endif
" }

" => vim file/folder management {
  " persistent undo
  if exists('+undofile')
    set undofile                " So is persistent undo ...
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
    let &undodir = s:get_cache_dir('undo.vim')
    call EnsureExists(&undodir)
  endif

  " backups
  set backup
  let &backupdir = s:get_cache_dir('backup.vim')
  call EnsureExists(&backupdir)

  " swap files
  set swapfile
  let &directory = s:get_cache_dir('swap.vim')
  call EnsureExists(&directory)
" }

" => VIM 7.3+ has support for highlighting a specified column {
  if exists('+colorcolumn')
    set colorcolumn=120
  else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>120v.\+', -1)
  endif
" }

" 一键去除所有尾部空白 {
  imap <leader>rb <ESC>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
  nmap <leader>rb :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
  vmap <leader>rb <ESC>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
" }

" 一键去除^M字符 {
  imap <leader>rm <ESC>:%s/<c-v><c-m>//g<CR>
  nmap <leader>rm :%s/<c-v><c-m>//g<CR>
  vmap <leader>rm <ESC>:%s/<c-v><c-m>//g<CR>
" }

" Super retab -- tab和space之间的互相转换 {
  " http://vim.wikia.com/wiki/Super_retab#Script
  " Return indent (all whitespace at start of a line), converted from
  " tabs to spaces if what = 1, or from spaces to tabs otherwise.
  " When converting to tabs, result has no redundant spaces.
  function! Indenting(indent, what, cols)
    let spccol = repeat(' ', a:cols)
    let result = substitute(a:indent, spccol, '\t', 'g')
    let result = substitute(result, ' \+\ze\t', '', 'g')
    if a:what == 1
      let result = substitute(result, '\t', spccol, 'g')
    endif
    return result
  endfunction
  " Convert whitespace used for indenting (before first non-whitespace).
  " what = 0 (convert spaces to tabs), or 1 (convert tabs to spaces).
  " cols = string with number of columns per tab, or empty to use 'tabstop'.
  " The cursor position is restored, but the cursor will be in a different
  " column when the number of characters in the indent of the line is changed.
  function! IndentConvert(line1, line2, what, cols)
    let savepos = getpos('.')
    let cols = empty(a:cols) ? &tabstop : a:cols
    execute a:line1 . ',' . a:line2 . 's/^\s\+/\=Indenting(submatch(0), a:what, cols)/e'
    call histdel('search', -1)
    call setpos('.', savepos)
  endfunction

  command! -nargs=? -range=% Space2Tab call IndentConvert(<line1>,<line2>,0,<q-args>)
  command! -nargs=? -range=% Tab2Space call IndentConvert(<line1>,<line2>,1,<q-args>)
  command! -nargs=? -range=% RetabIndent call IndentConvert(<line1>,<line2>,&et,<q-args>)

" }


" 状态栏 (vim-airline) {
  if isdirectory(expand("~/.vim/bundle/vim-airline"))
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
  endif
" }

" 智能补全和模板补全
" neocomplete {
  if has('lua')
    " NeoBundle 'Shougo/neocomplete.vim'
    let g:acp_enableAtStartup = 0
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_auto_delimiter = 1
    let g:neocomplete#max_list = 15
    let g:neocomplete#force_overwrite_completefunc = 1
" }
" neocomplcache {
  else
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
" }


