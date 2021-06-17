 colorscheme morning

 " Plugins Start
 call plug#begin()
 Plug 'dpelle/vim-LanguageTool'
 Plug 'godlygeek/tabular' 
 Plug 'plasticboy/vim-markdown' 
 Plug 'tpope/vim-surround'
 Plug 'tpope/vim-commentary'
 Plug 'ctrlpvim/ctrlp.vim'
 Plug 'udalov/kotlin-vim'
 call plug#end()

 let g:languagetool_jar='/opt/LanguageTool-5.2/languagetool-commandline.jar'
 set spelllang=en_us

 let g:ctrlp_working_path_mode = 'ra'

 let g:vim_markdown_folding_disabled = 1
 set conceallevel=2
 let g:vim_markdown_conceal = 2
 " Plugins End
 
 set tabstop=2
 set shiftwidth=2
 set expandtab

" Turn on syntax highlighting.
 syntax on

" Show line numbers.
 set number
 set ruler
 set relativenumber
 set ai

 set hlsearch
 hi Search cterm=NONE ctermfg=black ctermbg=cyan
 hi MatchParen cterm=none ctermbg=black ctermfg=cyan
 set incsearch
 
 set wildmenu
 set hidden

" copy and paste
 vmap <C-C> "+y
 vmap <C-V> "+p
