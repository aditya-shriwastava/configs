colorscheme pyte

" Plugins Start
call plug#begin()
Plug 'dpelle/vim-LanguageTool'
Plug 'godlygeek/tabular' 
Plug 'tpope/vim-commentary'
Plug 'udalov/kotlin-vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'dkarter/bullets.vim'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-repeat'
Plug 'kshenoy/vim-signature'
Plug 'mhinz/vim-signify'
Plug 'preservim/tagbar'
Plug 'preservim/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install()  }, 'for': ['markdown', 'vim-plug'] }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'lervag/vimtex'
Plug 'uarun/vim-protobuf'
Plug 'ycm-core/YouCompleteMe'
Plug 'itchyny/lightline.vim'
Plug 'chrisbra/unicode.vim'
call plug#end()
" Plugins End

set encoding=UTF-8

let g:languagetool_jar='/opt/LanguageTool-5.2/languagetool-commandline.jar'
set spelllang=en_us

set conceallevel=1
let g:vim_markdown_conceal = 1

let g:tex_conceal = ""
let g:vim_markdown_math = 1

let g:vim_markdown_folding_disabled = 1

" Turn on syntax highlighting.
syntax on

set wildmenu
set hidden

" copy and paste
" Note: Install vim-gtk for x11 clipboard
vmap <C-C> "+y
vmap <C-V> "+p

set number
set relativenumber
set ruler
set ai
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set mouse=a

set splitbelow splitright

set incsearch
set hlsearch

" Make adjusing split sizes a bit more friendly
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>

if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" use <tab> for trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap /b :Lines!<CR>
nmap /p :Rg!<CR>

nmap cc :Commands<CR>

map <C-p> :Files<CR>
map <C-b> :Buffers<CR>
map <C-n> :Windows<CR>

set hlsearch
hi Search cterm=none ctermfg=black ctermbg=cyan
hi MatchParen cterm=none ctermbg=black ctermfg=cyan
hi Pmenu ctermfg=blue ctermbg=white
hi Visual ctermfg=blue ctermbg=white
hi Error ctermfg=white ctermbg=red
hi YcmErrorLine ctermbg=black ctermfg=red
set incsearch

set pastetoggle=<F5>

nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+<CR>

let g:UltiSnipsEditSplit="vertical"

" Tab
nnoremap <Tab> gt
nnoremap <S-Tab> gT
map <Leader>t :tabnew<CR>

" ycm
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_clangd_uses_ycmd_caching = 0
let g:ycm_clangd_binary_path = exepath("clangd")
nmap <leader>yfw <Plug>(YCMFindSymbolInWorkspace)
nmap <leader>yfd <Plug>(YCMFindSymbolInDocument)
nnoremap <leader>jd :YcmCompleter GoTo<CR>
