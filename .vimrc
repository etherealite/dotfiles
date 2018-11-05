" Do nothing if we are running VIM compiled with VI compatible flag
if !has("compatible")

  " set encoding options
  if has("multi_byte")
    if &termencoding == ""
      let &termencoding = &encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8
    "setglobal bomb
    set fileencodings=ucs-bom,utf-8,latin1
  endif

  set history=256                " Number of things to remember in history.
  set timeoutlen=250             " Time to wait after ESC (default causes an annoying delay)
  set clipboard+=unnamed         " Yanks go on clipboard instead.
  set pastetoggle=<F10>          " toggle between paste and normal: for 'safer' pasting from keyboard
  set shiftround                 " round indent to multiple of 'shiftwidth'
  set tags=./tags;$HOME          " walk directory tree upto $HOME looking for tags

  set modeline
  set modelines=5                " default numbers of lines to read for modeline instructions

  set autowrite                  " Writes on make/shell commands
  set autoread

  set nobackup
  set nowritebackup
  set directory=/tmp//           " prepend(^=) $HOME/.tmp/ to default path; use full path as backup filename(//)
  set noswapfile                 "

  set hidden                     " The current buffer can be put to the background without writing to disk
  set switchbuf=usetab,newtab    " switch to existing window if exists else existing tab containing buffer

  set hlsearch                   " highlight search
  set ignorecase                 " need this for smartcase to work?
  set smartcase                  " be case sensitive when input has a capital letter
  set incsearch                  " show matches while typing and move cursor to match
  set wrapscan                   " continue search from top when reached end of file.
  nnoremap <CR> :noh<CR><CR>

  let g:is_posix = 1             " vim's default is archaic bourne shell, bring it up to the 90s
  let mapleader = ','
  " "}}}
  " Formatting "{{{
  set fo+=o                      " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
  set fo-=r                      " Do not automatically insert a comment leader after an enter
  set fo-=t                      " Do no auto-wrap text using textwidth (does not apply to comments)

  set nowrap
  set textwidth=0                " Don't wrap lines by default

  set tabstop=2                  " tab size eql 2 spaces
  set softtabstop=2
  set shiftwidth=2               " default shift width for indents
  set expandtab                  " replace tabs with ${tabstop} spaces
  set smarttab                   "

  set backspace=indent
  set backspace+=eol
  set backspace+=start

  set autoindent
  set cindent
  set indentkeys-=0#            " do not break indent on #
  set cinkeys-=0#
  set cinoptions=:s,ps,ts,cs
  set cinwords=if,else,while,do
  set cinwords+=for,switch,case
  " "}}}

  " Visual "{{{
  syntax enable                      " enable syntax
  set background=dark

  "set spell                      " highlight misspelled words

  set mouse=                    "fuck the mouse
  set mousehide                 " Hide mouse after chars typed

  set nonumber                  " line numbers Off
  set showmatch                 " Show matching brackets.
  set matchtime=2               " Bracket blinking.

  set wildmode=longest,list     " At command line, complete longest common string, then list alternatives.

  set completeopt+=preview

  set novisualbell              " No blinking
  set noerrorbells              " No noise.
  set vb t_vb=                  " disable any beeps or flashes on error

  set laststatus=2              " always show status line.
  set shortmess=atI             " shortens messages
  set showcmd                   " display an incomplete command in statusline

  "set statusline=%<%f\          " custom statusline
  "set stl+=[%{&ff}]             " show fileformat
  "set stl+=%y%m%r%=
  "set stl+=%-14.(%l,%c%V%)\ %P


  set foldenable                " Turn on folding
  set foldmethod=marker         " Fold on the marker
  set foldlevel=100             " Don't autofold anything (but I can still fold manually)

  set foldopen=block,hor,tag    " what movements open folds
  set foldopen+=percent,mark
  set foldopen+=quickfix

  set splitbelow
  set splitright

  set list                      " display unprintable characters f12 - switches
  set listchars=tab:\ ·,eol:¬
  set listchars+=trail:·
  set listchars+=extends:»,precedes:«
  map <silent> <F12> :set invlist<CR>
  " "}}}

  " Environment
  set directory=$XDG_CACHE_HOME/vim,~/,/tmp
  set backupdir=$XDG_CACHE_HOME/vim,~/,/tmp
  set viminfo+=n$XDG_CACHE_HOME/vim/viminfo
  set runtimepath=$XDG_CONFIG_HOME/vim,$XDG_CONFIG_HOME/vim/after,$VIM,$VIMRUNTIME
  " Changes location of the vim rc file
  " to force vim to read it on startup you need to export a shell variable as follows
  " export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
  " let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc"

  if exists("*plug#begin")
    " Specify a directory for plugins
    " - For Neovim: ~/.local/share/nvim/plugged
    " - Avoid using standard Vim directory names like 'plugin'
    call plug#begin('~/.vim/plugged')


    " project file tree
    Plug 'scrooloose/nerdtree'

    " visual yank register selection
    Plug 'vim-scripts/YankRing.vim'

    " easy buffer nav, swap lines
    Plug 'tpope/vim-unimpaired'

    " semantic auto-complete
    Plug 'shougo/neocomplete.vim'

    "  provides automatic closing of quotes, parenthesis, brackets, etc.
    Plug 'raimondi/delimitmate'

    " highlight the current tag pairs enclsosig cursor
    Plug 'valloric/matchtagalways'

    " fuzzy search files buffers and tags
    Plug 'kien/ctrlp.vim'

    " colors
    Plug 'altercation/vim-colors-solarized'
    "not using atm
    "colorscheme solarized

    " Adds operator to comment vim objects
    Plug 'tpope/vim-commentary'

    " super awesome motion
    Plug 'Lokaltog/vim-easymotion'

    " new motions for words sperated by Camel and snake case
    Plug 'vim-scripts/camelcasemotion'

    " auto align text 
    Plug 'godlygeek/tabular'

    " allow % motion to match words and regex
    Plug 'vim-scripts/matchit.zip'

    " allow supporting plugins to work with .
    Plug 'tpope/vim-repeat'

    " like EMAC's Helm
    Plug 'Shougo/unite.vim'

    " Instant feed back for string search
    Plug 'pelodelfuego/vim-swoop'

    " visual indentation levels
    Plug 'nathanaelkane/vim-indent-guides'
    let g:indent_guides_guide_size = 1
    " allow saving files as root user
    Plug 'vim-scripts/sudo.vim'

    " syntax highling for ansible playbooks
    Plug 'pearofducks/ansible-vim'

    " respect setting in .editorconfig files
    Plug 'editorconfig/editorconfig-vim'


    " initialize plugin system
    call plug#end()

    filetype plugin indent on    " required
    " to ignore plugin indent changes, instead use:
    "filetype plugin on

    " plugin setup stuff
    let g:neocomplcache_enable_at_startup = 1
  endif
endif