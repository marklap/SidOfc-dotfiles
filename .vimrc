"' Init / Plugins {{{
  set nocompatible

  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif

  call plug#begin('~/.vim/plugged')
  Plug 'w0rp/ale'
  Plug 'sheerun/vim-polyglot'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'AndrewRadev/splitjoin.vim'
  Plug 'chriskempson/base16-vim'
  Plug 'itchyny/lightline.vim'
  Plug 'jreybert/vimagit'
  Plug 'benmills/vimux'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'haya14busa/incsearch.vim'
  Plug 'junegunn/vim-easy-align'
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
  Plug $VIM_DEV ? '~/Dev/sidney/viml/mkdx' : 'SidOfc/mkdx'
  if $VIM_DEV | Plug 'edkolev/tmuxline.vim' | endif
  call plug#end()
" }}}

" General {{{
  let mapleader = ' '

  set path+=**                    " add cwd and 1 level of nesting to path
  set hidden                      " allow switching from unsaved buffer without '!'
  set ignorecase                  " ignore case in search
  set nohlsearch                  " do not highlight searches, incsearch plugin does this
  set smartcase                   " use case-sensitive if a capital letter is included
  set noshowmode                  " statusline makes -- INSERT -- info irrelevant
  set number                      " show line numbers
  set relativenumber              " show relative number
  set cursorline                  " highlight cursor line
  set splitbelow                  " split below instead of above
  set splitright                  " split after instead of before
  set termguicolors               " enable termguicolors for better highlighting
  set list                        " show invisibles
  set lcs=tab:·\                  " show tab as that thing
  set background=dark             " set bg dark
  set nobackup                    " do not keep backups
  set noswapfile                  " no more swapfiles
  set clipboard=unnamed           " copy into osx clipboard by default
  set encoding=utf-8              " utf-8 files
  set fileencoding=utf-8          " utf-8 files
  set fileformat=unix             " use unix line endings
  set fileformats=unix,dos        " try unix line endings before dos, use unix
  set expandtab                   " softtabs, always (e.g. convert tabs to spaces)
  set shiftwidth=2                " tabsize 2 spaces (by default)
  set softtabstop=2               " tabsize 2 spaces (by default)
  set tabstop=2                   " tabsize 2 spaces (by default)
  set laststatus=2                " always show statusline
  set showtabline=0               " never show tab bar
  set backspace=2                 " restore backspace
  set nowrap                      " do not wrap text at `textwidth`
  set noerrorbells                " do not show error bells
  set visualbell                  " do not use visual bell
  set t_vb=                       " do not flash screen with visualbell
  set timeoutlen=400              " mapping delay
  set ttimeoutlen=10              " keycode delay
  set wildignore+=.git,.DS_Store  " ignore files (netrw)
  set scrolloff=10                " show 10 lines of context around cursor
  colorscheme base16-default-dark " apply color scheme

  " change cursor shape in various modes
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

  " remap bad habits to do nothing
  imap <Up>    <Nop>
  imap <Down>  <Nop>
  imap <Left>  <Nop>
  imap <Right> <Nop>
  nmap <Up>    <Nop>
  nmap <Down>  <Nop>
  nmap <Left>  <Nop>
  nmap <Right> <Nop>
  nmap <S-s>   <Nop>
  nmap >>      <Nop>
  nmap <<      <Nop>
  vmap >>      <Nop>
  vmap <<      <Nop>
  map  $       <Nop>
  map  ^       <Nop>
  map  {       <Nop>
  map  }       <Nop>
  map <C-z>    <Nop>

  " easier navigation in normal / visual / operator pending mode
  noremap K     {
  noremap J     }
  noremap H     ^
  noremap L     $

  " save using <C-s> in every mode
  " when in operator-pending or insert, takes you to normal mode
  nnoremap <C-s> :write<Cr>
  vnoremap <C-s> <C-c>:write<Cr>
  inoremap <C-s> <Esc>:write<Cr>
  onoremap <C-s> <Esc>:write<Cr>

  " close pane using <C-w> since I know it from Chrome / Atom (cmd+w) and do
  " not use the <C-w> mappings anyway
  noremap  <C-w> :bd<Cr>

  " easier navigation in insert mode
  inoremap <C-k> <Up>
  inoremap <C-j> <Down>
  inoremap <C-h> <Left>
  inoremap <C-l> <Right>

  " make Y consistent with C and D
  nnoremap Y y$

  " use qq to record, q to stop, Q to play a macro
  nnoremap Q @q

  " use tab and shift tab to indent and de-indent code
  nnoremap <Tab>   >>
  nnoremap <S-Tab> <<
  vnoremap <Tab>   >><Esc>gv
  vnoremap <S-Tab> <<<Esc>gv

  " add i| and a| operator pending motions for pipe characters
  onoremap i\| :<C-u>normal! f\|lvt\|<Cr>
  onoremap a\| :<C-u>normal! f\|vf\|<Cr>

  " when pairing some braces or quotes, put cursor between them
  inoremap <>   <><Left>
  inoremap \|\| \|\|<Left>
  inoremap ()   ()<Left>
  inoremap {}   {}<Left>
  inoremap []   []<Left>
  inoremap ""   ""<Left>
  inoremap ''   ''<Left>
  inoremap ``   ``<Left>

  if &diff
    " use familiar C-n and C-p binds to move between hunks
    nnoremap <C-n> ]c
    nnoremap <C-p> [c
  endif

  " fix jsx highlighting of end xml tags
  hi link xmlEndTag xmlTag

  " delete existing notes in ~/notes
  if !exists('*s:DeleteNote')
    function! s:DeleteNote(paths)
      call delete(a:paths)
    endfunction
  endif

  " create a new note in ~/notes
  if !exists('*s:NewNote')
    function! s:NewNote()
      call inputsave()
      let l:fname = input('Note name: ')
      call inputrestore()

      if strlen(l:fname) > 0
        let l:fpath = expand('~/notes/' . fnameescape(substitute(tolower(l:fname), ' ', '-', 'g')))
        exe "tabe " . l:fpath . ".md"
      endif
    endfunction
  endif

  " convenience function for setting filetype specific spacing
  if !exists('*s:IndentSize')
    function! s:IndentSize(amount)
      exe "setlocal expandtab ts=" . a:amount . " sts=" . a:amount . " sw=" . a:amount
    endfunction
  endif

  " use ripgrep as grepprg
  if executable('rg')
    set grepprg=rg\ --vimgrep\ --hidden\ --no-ignore-vcs
    set grepformat=%f:%l:%c:%m,%f:%l:%m
  endif
" }}}

" Development {{{{
  if $VIM_DEV
    nmap <Leader>R :so ~/Dev/sidney/viml/mkdx/autoload/mkdx.vim<Cr>
    let g:tmuxline_preset = {
          \ 'a':    '⊞',
          \ 'win':  '#I #W',
          \ 'cwin': '#I #W',
          \ 'y':    '%d·%m·%Y',
          \ 'z':    '%R',
          \ 'options': { 'status-justify': 'left' }
          \ }
  endif
" }}}

" Netrw {{{
  let g:netrw_banner    = 0
  let g:netrw_winsize   = 20
  let g:netrw_liststyle = 3
  let g:netrw_altv      = 1
" }}}

" Ale {{{
  let g:ale_echo_msg_error_str = 'E'                       " error sign
  let g:ale_echo_msg_warning_str = 'W'                     " warning sign
  let g:ale_echo_msg_format = '[%linter%] %s [%severity%]' " status line format
  let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']   " error status format
  let g:ale_lint_delay = 2000                              " relint max once per second
  let g:ale_linters = {
        \ 'ruby': ['rubocop'],
        \ 'javascript': ['eslint']
        \ }
" }}}

" Incsearch {{{
  let g:incsearch#auto_nohlsearch = 1                   " auto unhighlight after searching
  let g:incsearch#magic = '\v'                          " sheer awesomeness
  let g:incsearch#do_not_save_error_message_history = 1 " do not store incsearch errors in history
  let g:incsearch#consistent_n_direction = 1            " when searching backward, do not invert meaning of n and N

  map / <Plug>(incsearch-forward)
  map ? <Plug>(incsearch-backward)
" }}}

" Lightline {{{
  let g:lightline = {
        \ 'colorscheme':      'wombat',
        \ 'separator':        { 'left': "\ue0b0", 'right': "\ue0b2" },
        \ 'subseparator':     { 'left': "\ue0b1", 'right': "\ue0b3" },
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'modified', 'fugitive', 'filename' ] ],
        \   'right': [ [ 'lineinfo'],
        \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
        \ },
        \ 'component': {
        \   'mode':     '%{lightline#mode()[0]}',
        \   'readonly': '%{&filetype=="help"?"":&readonly?"!":""}',
        \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
        \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
        \ },
        \ 'component_visible_condition': {
        \   'paste':    '(&paste!="nopaste")',
        \   'readonly': '(&filetype!="help"&& &readonly)',
        \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
        \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
        \ }
        \ }
" }}}

" Vimux {{{
  let g:VimuxPromptString = '% '         " change default vim prompt string
  let g:VimuxResetSequence = 'q C-u C-l' " clear output before running a command

  noremap <Leader>p  :VimuxRunCommand("git pull")<Cr>
  noremap <Leader>P  :VimuxRunCommand("git push")<Cr>
  noremap <Leader>rt :VimuxRunCommand("clear;" . &ft . " " . bufname("%"))<Cr>
  noremap <Leader>rr :VimuxPromptCommand<Cr>
  noremap <Leader>rl :VimuxRunLastCommand<Cr>
  noremap <Leader>re :VimuxCloseRunner<Cr>
" }}}

" Splitjoin {{{
  let g:splitjoin_split_mapping = '' " reset splitjoin mappings
  let g:splitjoin_join_mapping = ''  " reset splitjoin mappings

  noremap <Leader>j :SplitjoinJoin<Cr>
  noremap <Leader>J :SplitjoinSplit<Cr>
" }}}

" Fzf {{{
  " use bottom positioned 20% height bottom split
  let g:fzf_layout = { 'down': '~20%' }
  let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Clear'],
    \ 'hl':      ['fg', 'String'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }

  " simple notes bindings using fzf wrapper
  nnoremap <silent> <Leader>n :call fzf#run(fzf#wrap({'source': 'rg --files ~/notes', 'options': '--header="[notes:search]" --preview="cat {}"'}))<Cr>
  nnoremap <silent> <Leader>N :call <SID>NewNote()<Cr>
  nnoremap <silent> <Leader>nd :call fzf#run(fzf#wrap({'source': 'rg --files ~/notes', 'options': '--header="[notes:delete]" --preview="cat {}"', 'sink': function('<SID>DeleteNote')}))<Cr>

  command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

  " only use FZF shortcuts in non diff-mode
  if !&diff
    nnoremap <C-p> :Files<Cr>
    nnoremap <C-g> :Rg<Cr>
  endif
" }}}

" Vimagit {{{
  noremap  <Leader>m :MagitO<Cr>
" }}}

" Easyalign {{{
  " some additional easyalign patterns to use with `ga` mapping
  let g:easy_align_delimiters = {
        \ '?': {'pattern': '?'},
        \ '>': {'pattern': '>>\|=>\|>'}
        \ }

  xmap gr <Plug>(EasyAlign)
  nmap gr <Plug>(EasyAlign)
" }}}

" Autocommands {{{
  augroup Windows
    au!
    au BufEnter,WinEnter,WinNew,VimResized *,*.*
          \ let &scrolloff=getwininfo(win_getid())[0]['height']/2 " keep cursor centered
    au VimResized * wincmd =                                      " auto resize splits on resize
  augroup END

  augroup Files
    au!
    au BufWritePre *                %s/\s\+$//e          " remove trailing whitespace before saving buffer
    au FileType javascript,jsx,json call s:IndentSize(4) " 4 space indents for JS/JSX/JSON
    au FileType markdown,python     call s:IndentSize(4) " 4 space indents for markdown and python
    au FileType help                nmap <buffer> q :q<Cr>
  augroup END
" }}}
