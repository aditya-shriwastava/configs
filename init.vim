" =============================
" BASIC SETTINGS
" =============================
set nocompatible          " Disable Vi compatibility
set number                " Show line numbers
set relativenumber        " Show relative line numbers
set showcmd               " Show command in the last line
set cursorline            " Highlight current line
set ruler                 " Show cursor position
set wildmenu              " Tab-completion menu in commands
set clipboard=unnamedplus " Use system clipboard

" =============================
" INDENTATION & FORMATTING
" =============================
set tabstop=4             " 4 spaces per tab
set shiftwidth=4          " 4 spaces for indentation
set expandtab             " Use spaces instead of tabs
set autoindent            " Auto-indent new lines
set smartindent           " Smarter auto-indenting
set nowrap                " Don’t wrap long lines
set formatoptions+=cro    " Better comment formatting

" =============================
" SEARCH
" =============================
set ignorecase            " Case-insensitive search
set smartcase             " But case-sensitive if uppercase used
set incsearch             " Show search matches as you type
set hlsearch              " Highlight all search results
nnoremap <leader><space> :nohlsearch<CR>  " Clear highlights

" =============================
" FILE MANAGEMENT
" =============================
set backup                " Enable backups
set backupdir=~/.vim/backup//
set undofile              " Persistent undo
set undodir=~/.vim/undo//
set swapfile              " Enable swap files
set directory=~/.vim/swap//

" =============================
" MAPPINGS
" =============================
let mapleader=" "         " Set leader key to space

" Quick Save
nnoremap <leader>w :w<CR>

" Toggle Line Numbers
nnoremap <leader>n :set number! relativenumber!<CR>

" =============================
" FOLDING
" =============================
set foldmethod=syntax     " Fold based on syntax
set foldlevel=99          " Open all folds by default
nnoremap <space> za       " Toggle fold with spacebar

" =============================
" BETTER NAVIGATION
" =============================
" Move by display lines when lines are wrapped
nnoremap j gj
nnoremap k gk

" =============================
" VISUAL ENHANCEMENTS
" =============================
syntax on                 " Enable syntax highlighting
set background=dark       " Suitable for dark themes
colorscheme desert        " Built-in colorscheme (you can try others like 'elflord', 'evening', 'murphy')
