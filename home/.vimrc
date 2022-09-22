set nocompatible
syntax on
set t_Co=256
 set cursorline
colorscheme onedark
"colorscheme nord
"colorscheme one
"colorscheme monokai-pro
"hi CursorLine term=none cterm=none ctermbg=3
hi Conceal      term=reverse    cterm=none      ctermfg=237     ctermbg=none
"hi cursorline   term=underline  cterm=bold      ctermfg=none    ctermbg=238
hi NonText      term=reverse    cterm=none      ctermfg=237     ctermbg=none
hi Normal       term=none       cterm=none      ctermfg=252     ctermbg=234
hi SpecialKey   term=reverse    cterm=none      ctermfg=14      ctermbg=23

set number
set nowrap
set autoindent
set smartindent
"set nocindent
set shiftwidth=4 ts=4 et
set softtabstop=4
set expandtab
set hlsearch
    :nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
set virtualedit=all,block,onemore
set history=1000
set showmatch
set incsearch
set ignorecase
set showcmd
set backspace=indent,eol,start
set nostartofline

set confirm
set backup
set undofile
set undolevels=200
set backupdir=$HOME/.vimbackup

set visualbell
set t_vb=

set cmdheight=1
set number

"set spell
set laststatus=2
set ruler
set wildmenu
"set wildmode=longest:list,full
set mouse=a

filetype indent on
filetype plugin indent on
scriptencoding utf-8
highlight link RedundantSpaces Error
au BufEnter,BufRead * match RedundantSpaces "\t"
au BufEnter,BufRead * match RedundantSpaces "[[:space:]]\+$"
let g:is_sh = 1				                                        " Set default sh

map Y y$                                                            " Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy, which is the default
cmap w!! %!sudo tee > /dev/null %	                                " Will allow you to use :w!! to write to a file using sudo
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
 map <S-Right> :tabn<CR>
 map <S-Left>  :tabp<CR>
 map <S-n>     :tabnew<CR>
 map <S-c>     :tabclose<CR>
 nnoremap <C-q> :close<CR>

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif


call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'ryanoasis/vim-devicons'

" Initialize plugin system
call plug#end()

call pathogen#infect()
let g:lightline = {
      \ 'colorscheme': '16color',
      \ }
if &term == 'xterm-kitty'
    let &t_ut=''
endif
if &term == 'rxvt-unicode-256color'
    let &t_ut=''
endif

let g:NERDTreeIndicatorMapCustom = { "Modified" : "✹", "Staged" : "✚", "Untracked" : "✭", "Renamed" : "➜", "Unmerged" : "═", "Deleted" : "✖", "Dirty" : "✗", "Clean" : "✔", 'Ignored' : '☒', "Unknown" : "?", }
let g:webdevicons_enable = 1
let g:webdevicons_enable_unite = 1
