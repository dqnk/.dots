"plugins

call plug#begin('~/.vim/plugged')

Plug 'codota/tabnine-vim'
"Plug 'vim-clang-format'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
"Plug 'ryanoasis/vim-devicons'

call plug#end()

"
set encoding=UTF-8
syntax enable
set tabstop=8
set guifont=Hack\ 12
set signcolumn=yes
silent! colorscheme monokai-tasty
highlight Normal ctermbg=none
highlight NonText ctermbg=none
set showcmd
set smartindent
set relativenumber
set nu rnu
set foldmethod=indent
set clipboard+=unnamedplus

let g:python_highlight_all = 1
set wmh=0
let g:ale_enabled=0

let g:netrw_keepdir=0
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | set relativenumber | set nu rnu | if argc() > 0 || exists("s:std_in") | wincmd p | endif

autocmd FileType arduino nmap <F8> :!arduino-cli compile --fqbn arduino:avr:uno
autocmd FileType arduino nmap <F9> :!arduino-cli upload -p /dev/ttyUSB0 --fqbn arduino:avr:uno

silent! autocmd VimEnter :CocDisable

nmap <C-e> :NERDTreeToggle<CR>
nmap <C-t> :tab new<CR>
map <C-s> :pyf /usr/share/clang/clang-format.py<cr>

"noremap <A-1> 1gt
"noremap <A-2> 2gt
"noremap <A-3> 3gt
"noremap <A-4> 4gt
"noremap <A-5> 5gt
"noremap <A-6> 6gt
"noremap <A-7> 7gt
"noremap <A-8> 8gt
"noremap <A-9> 9gt
"noremap <A-0> :tablast<cr>

noremap <C-x> :q<cr>

noremap <F1> :term
autocmd FileType cpp nmap <F5> :!./%:r<CR>
autocmd FileType cpp nmap <F8> :make %:r && ./%:r<CR>
autocmd Filetype cpp nmap <F9> :!g++ -std=c++17 -Wshadow -Wall -o %:r % -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG && ./%:r<CR>
