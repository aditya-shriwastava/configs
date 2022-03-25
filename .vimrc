 colorscheme morning

 " Plugins Start
 call plug#begin()
 Plug 'dpelle/vim-LanguageTool'
 Plug 'godlygeek/tabular' 
 Plug 'tpope/vim-surround'
 Plug 'tpope/vim-commentary'
 Plug 'ctrlpvim/ctrlp.vim'
 Plug 'udalov/kotlin-vim'
 Plug 'SidOfc/mkdx'
 Plug 'francoiscabrol/ranger.vim'
 call plug#end()

 let g:languagetool_jar='/opt/LanguageTool-5.2/languagetool-commandline.jar'
 set spelllang=en_us

 let g:ctrlp_working_path_mode = 'ra'

 let g:vim_markdown_folding_disabled = 1
 set conceallevel=2
 let g:vim_markdown_conceal = 2
 " Plugins End

" Turn on syntax highlighting.
 syntax on

 set hlsearch
 hi Search cterm=NONE ctermfg=black ctermbg=cyan
 hi MatchParen cterm=none ctermbg=black ctermfg=cyan
 set incsearch
 
 set wildmenu
 set hidden

" copy and paste
" Note: Install vim-gtk for x11 clipboard
 vmap <C-C> "+y
 vmap <C-V> "+p

let g:mkdx#settings     = { 'highlight': { 'enable': 1 },
                        \ 'enter': { 'shift': 1 },
                        \ 'links': { 'external': { 'enable': 1 } },
                        \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
                        \ 'fold': { 'enable': 1 } }
let g:polyglot_disabled = ['markdown'] " for vim-polyglot users, it loads Plasticboy's markdown
                                       " plugin which unfortunately interferes with mkdx list indentation. 
 set number
 set relativenumber
 set ruler
 set ai
 set tabstop=4
 set softtabstop=4
 set shiftwidth=4
 set expandtab
 set mouse=a
