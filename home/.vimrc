set nocompatible              " be iMproved
filetype off                  " required!

"==================="
" Vundle            "
"==================="
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/Vundle.vim'

" Colors
Bundle 'tomasr/molokai'

" misc && settings
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-unimpaired'

" search
Bundle 'mileszs/ack.vim'
Bundle 'rking/ag.vim'

" Navigation
Bundle 'kien/ctrlp.vim'
Bundle 'xolox/vim-misc'
Bundle 'majutsushi/tagbar'
Bundle 'ludovicchabant/vim-gutentags'
Bundle 'scrooloose/nerdtree'

" Buffers
Bundle 'vim-scripts/bufkill.vim'
Bundle 'duff/vim-bufonly'
Bundle 'jeetsukumaran/vim-buffergator'

" Editing
Bundle 'tpope/vim-surround'
Bundle 'godlygeek/tabular'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-sleuth'
Bundle 'tpope/vim-commentary'
Bundle 'Valloric/YouCompleteMe'
Bundle 'sjl/gundo.vim'
"Bundle 'vim-scripts/vim-auto-save'

" Git
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'

" UI
Bundle 'kien/rainbow_parentheses.vim'
"Bundle 'itchyny/lightline.vim'
Bundle 'bling/vim-airline'

" Javascript
Bundle 'kchmck/vim-coffee-script'
Bundle 'pangloss/vim-javascript'
Bundle 'leshill/vim-json'

" Ruby
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rake'
Bundle 'jgdavey/vim-blockle'
Bundle 'tpope/vim-endwise'
Bundle 'jgdavey/vim-turbux'

" Clojure
Bundle 'guns/vim-clojure-static'
Bundle 'tpope/vim-fireplace'
Bundle 'tpope/vim-classpath'
Bundle 'tpope/vim-leiningen'
Bundle 'venantius/vim-cljfmt'
Bundle 'guns/vim-clojure-highlight'
Bundle 'snoe/vim-sexp'
Bundle 'tpope/vim-sexp-mappings-for-regular-people'
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.
call vundle#end()

filetype plugin indent on
" 
"==================="
" Pixie             "
"==================="
autocmd BufNewFile,BufRead *.pxi set syntax=clojure

"==================="
" Settings          "
"==================="
set enc=utf-8
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set history=50                  " keep 50 lines of command line history
set hidden                      " you can change buffers without saving
set nobackup
set nowrap                      " Don't wrap text
set scrolloff=2                 " Keep 2 lines top/bottom visible for scope
set shiftwidth=2
set tabstop=2
set expandtab                   " Auto convert tabs to spaces
set showcmd                     " display incomplete commands
set shell=zsh
set incsearch                   " do incremental searching
set smartcase                   " case sensitive only if search contains uppercase
set ignorecase                  " Needs to be present for smartcase to work as intended
set wildmenu                    " :e tab completion file browsing
set wildmode=list:longest,full  " List all matches on first TAB, complete/cycle on second TAB
set cf                          " Enable error files & error jumping.
set listchars=tab:▸\ ,eol:¬     " Use the same symbols as TextMate for tabstops and EOLs
"set listchars=tab:>-,trail:.,eol:$
set vb                          " turns off visual bell
set splitbelow                  " Open new horizontal split windows below current
set splitright                  " Open new vertical split windows to the right
set laststatus=2                " Always show status line
set ruler                       " show the cursor position in the status line
set number                      " turn on line numbers
"set formatoptions=rq            " Automatically insert comment leader on return, and let gq format comments
set autoread                    " Don't prompt to reread the file if it is unchanged in the editor but modified externally.
set mouse=a                     " Enable mouse scrolling
set cursorline                  " Highlight current line
set cursorcolumn                " Highlight current column

if exists('+colorcolumn')
  set colorcolumn=81
endif

if !has('gui_running')
  set t_Co=256
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  set guifont=Inconsolata-dz\ for\ Powerline:h12
endif

" dem rainbow parens
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
"
" vim-clojure-static
let g:clojure_align_multiline_strings = 1
let g:clojure_align_subforms = 1

" Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/tmp

colorscheme molokai

if !exists("autocommands_loaded")
  let autocommands_loaded = 1
  let project_path = getcwd()
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  "Reload vimrc on write.  Nice if it was opened within a tab/window of the same
  "vim instance
  autocmd! bufwritepost .vimrc source %

  " Go up a level in the git repository in fugitive using ..
  autocmd User fugitive
    \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
    \   nnoremap <buffer> .. :edit %:h<CR> |
    \ endif

  " Auto cleanup fugitive buffers
  autocmd BufReadPost fugitive://* set bufhidden=delete


  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif
  augroup END
else
  set autoindent		" always set autoindenting on
endif " has("autocmd")

" let g:auto_save = 1
" let g:auto_save_in_insert_mode = 0
" let g:auto_save_no_updatetime = 1

let g:ackprg = 'ag --nogroup --nocolor --column'

"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#buffer_nr_show = 1
"let g:airline#extensions#tabline#buffer_nr_format = '%s|'
"let g:airline#extensions#hunks#enabled = 0
let g:airline_powerline_fonts = 1
set laststatus=2
let g:ctrlp_root_markers = ['project.clj', 'Gemfile']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'
     
" Use the right side of the screen
let g:buffergator_viewport_split_policy = 'R'

" I want my own keymappings...
"let g:buffergator_suppress_keymaps = 1

" Looper buffers
"let g:buffergator_mru_cycle_loop = 1

" Tag stuff
let g:gutentags_ctags_tagfile = 'vimtags'
set tags=./vimtags;
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"==================="
" Keyboard Mappings "
"==================="

let mapleader=","

" Use a leader instead of the actual named binding
nmap <leader>p :CtrlP<cr>

" Easy bindings for its various modes
"nmap <leader>bb :CtrlPBuffer<cr>
"nmap <leader>bm :CtrlPMixed<cr>
"nmap <leader>bs :CtrlPMRU<cr>

" Go to the previous buffer open
"nmap <leader>jj :BuffergatorMruCyclePrev<cr>

" Go to the next buffer open
"nmap <leader>kk :BuffergatorMruCycleNext<cr>

" View the entire list of buffers open
"nmap <leader>bl :BuffergatorOpen<cr>
"nmap <leader>bq :bp <BAR> bd #<cr>

" Gundo
nnoremap <F6> :GundoToggle<CR>

nmap <F8> :TagbarToggle<CR>
" Split Edit / Reload Vim Config (short for Configure Vim)
map <leader>cv :tabnew $MYVIMRC<CR>

" bubble up selected text
vmap <C-up> [egv
vmap <C-k> [egv

" bubble down selected text
vmap <C-down> ]egv
vmap <C-j> ]egv

" Turnoff search highlighting by pressing enter key
" Note this breaks the ability to press enter in the quickfix window to jump to a file.
" Use <C-Enter> as a workaround.
nnoremap <CR> :nohlsearch<CR>/<BS>

" Append closing characters
inoremap (( ()<Left>
inoremap [[ []<Left>
inoremap {{ {}<Left>
inoremap "" ""<Left>
inoremap '' ''<Left>

map <leader>nt :NERDTreeToggle<CR>
map <leader>nf :NERDTreeFind<CR>
map <leader>fa :Ack
let NERDTreeShowHidden=1

" Nerd Tree auto stuff
autocmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))
autocmd FocusGained * call s:UpdateNERDTree()
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

" If the parameter is a directory, cd into it
function! s:CdIfDirectory(directory)
  let explicitDirectory = isdirectory(a:directory)
  let directory = explicitDirectory || empty(a:directory)

  if explicitDirectory
    exe "cd " . a:directory
  endif

  if directory
    NERDTree
    wincmd p
    bd
  endif

  if explicitDirectory
    wincmd p
  endif
endfunction

" NERDTree utility function
function! s:UpdateNERDTree(...)
  let stay = 0

  if(exists("a:1"))
    let stay = a:1
  end

  if exists("t:NERDTreeBufName")
    let nr = bufwinnr(t:NERDTreeBufName)
    if nr != -1
      exe nr . "wincmd w"
      exe substitute(mapcheck("R"), "<CR>", "", "")
      if !stay
        wincmd p
      end
    endif
  endif

  if exists(":CommandTFlush") == 2
    CommandTFlush
  endif
endfunction

" macvim specific bindings
if has("gui_macvim")
  set guioptions-=T
  set fuoptions=maxvert,maxhorz		" fullscreen maximizes vertically AND horizontally
  map <D-F> :Ack<space>
endif
