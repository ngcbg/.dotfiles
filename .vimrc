set nocompatible
set nocindent
set cul                                                             " highlight current line
hi CursorLine term=none cterm=none ctermbg=3                        " adjust color
set nu                                                              " Line numbers on
set nowrap                                                          " Don't wrap long lines
"set wrap                                                           " Wrap long lines
set autoindent                                                      " Indent at the same level of the previous line e.g.- new lines inherit the indentation of previous lines.
set shiftwidth=4 ts=4 et                                            " use indents of 4 spaces plus an indentation every four columns
set hlsearch                                                        " highlight search terms
set smartindent
set virtualedit=onemore                                             " allow for cursor beyond last character
set history=1000                                                    " Store a ton of history (default is 20)
set showmatch                                                       " show matching brackets/parenthesis
set incsearch                                                       " find as you type search

set ignorecase                                                      " perform case insensitive search
set showcmd                                                         " Show partial commands in the last line of the screen
set backspace=indent,eol,start                                      " Allow backspacing over autoindent, line breaks and start of insert action
set nostartofline                                                   " Stop certain movements from always going to the first character of a line.
                                                                        " - While this behaviour deviates from that of Vi, it does what most users
                                                                        " - coming from other editors would expect.
set confirm                                                         " Instead of failing a command because of unsaved changes, instead raise a
                                                                        " - dialogue asking if you wish to save changed files.
set visualbell                                                      " Use visual bell instead of beeping when doing something wrong
set t_vb=                                                           " Reset the terminal code for the visual bell. If visual bell is set, and
                                                                        " - this line is also included, vim will neither flash nor beep. If visual bell
                                                                        " - is unset, this does nothing.
set cmdheight=2                                                     " Set the command window height to 2 lines, to avoid many cases of having to 'press <Enter> to continue'
set number                                                          " Display line numbers on the left
                                                                        " - Do not change tabstop from its default value of 8 with this setup.
set softtabstop=4
set expandtab                                                        " Convert tabs to spaces.
"set spell                                                           " Enable spell checking
""""""""""
"   UX
""""""""""
set laststatus=2                                                     " Always display the status bar.
set ruler                                                            " Display the cursor position on the last line of the screen or in the status line of a window
set wildmenu                                                        " show list instead of just completing
"colorscheme onedark                                                 " Preferred color scheme
colorscheme nord                                                     " Preferred color scheme
set mouse=a                                                         " Automatically enable mouse usage
syntax on                                                           " syntax highlighting

set statusline=...%r%{VarExists('b:gzflag','\ [GZ]')}%h...
set statusline=%<%f%=\ [%1*%M%*%n%R%H]\ %-19(%3l,%02c%03V%)%O'%02b'
hi  User1 term=inverse,bold cterm=inverse,bold ctermfg=red
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

filetype plugin indent on                                           " Automatically detect file types.

scriptencoding utf-8

highlight link RedundantSpaces Error		                        " Highlight trailing whitespace and tabs
au BufEnter,BufRead * match RedundantSpaces "\t"
au BufEnter,BufRead * match RedundantSpaces "[[:space:]]\+$"

let g:is_sh = 1				                                        " Set default sh

"function! s:DiffWithSaved()
"    let filetype=&ft
"    diffthis
"    vnew | r # | normal! 1Gdd
"    diffthis
"    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
"endfunction
"com! DiffSaved call s:DiffWithSaved()

map Y y$                                                            " Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy, which is the default
cmap w!! %!sudo tee > /dev/null %	                                " Will allow you to use :w!! to write to a file using sudo
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

call pathogen#infect()
syntax on
filetype plugin indent on
map <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let NERDTreeShowHidden=1
" Start NERDTree and put the cursor back in the other window.
"autocmd VimEnter * NERDTree | wincmd p
" Start NERDTree when Vim is started without file arguments.
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
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

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

" Initialize plugin system
call plug#end()
