colorscheme pyte

" Plugins Start
call plug#begin()
Plug 'dpelle/vim-LanguageTool'
Plug 'godlygeek/tabular' 
Plug 'tpope/vim-commentary'
Plug 'udalov/kotlin-vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'dkarter/bullets.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'PhilRunninger/nerdtree-buffer-ops'
Plug 'taketwo/vim-ros'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-repeat'
Plug 'kshenoy/vim-signature'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-signify'
Plug 'preservim/tagbar'
Plug 'preservim/vim-markdown'
Plug 'vimwiki/vimwiki'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install()  }, 'for': ['markdown', 'vim-plug'] }
" Plug 'SidOfc/mkdx'
Plug 'rhysd/vim-grammarous'
call plug#end()

set encoding=UTF-8

let g:languagetool_jar='/opt/LanguageTool-5.2/languagetool-commandline.jar'
set spelllang=en_us

let g:vim_markdown_folding_disabled = 1
set conceallevel=2
let g:vim_markdown_conceal = 2
" Plugins End

let g:tex_conceal = ""
let g:vim_markdown_math = 1

" Turn on syntax highlighting.
syntax on

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
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set mouse=a

set splitbelow splitright

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

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

noremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

inoremap <leader>g <Esc>:NERDTreeToggle<cr>
nnoremap <leader>g <Esc>:NERDTreeToggle<cr>

nmap <silent> gd <Plug>(coc-definition)


let g:vimwiki_list = [{'path': '~/Documents/Notes',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

nmap /b :Lines!<CR>
nmap /p :Rg!<CR>

nmap cc :Commands<CR>

map <C-p> :Files<CR>
map <C-b> :Buffers<CR>
map <C-n> :Windows<CR>

" let g:airline#extensions#tabline#enabled = 1
highlight clear SignColumn

map <leader>c :TagbarToggle<CR>

let g:vimwiki_markdown_link_ext = 1

let g:airline_theme='deus'

set hlsearch
hi Search cterm=none ctermfg=black ctermbg=yellow
hi MatchParen cterm=none ctermbg=white ctermfg=cyan
hi Pmenu ctermfg=blue ctermbg=white
set incsearch

set pastetoggle=<F5>
