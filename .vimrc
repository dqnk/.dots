syntax enable
set guifont=Monospace\ 12
set signcolumn=yes
colorscheme monokai

set showcmd
set smartindent
set relativenumber
set nu rnu
set foldmethod=indent

let g:python_highlight_all = 1
set wmh=0

let g:netrw_keepdir=0
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | set relativenumber | set nu rnu | if argc() > 0 || exists("s:std_in") | wincmd p | endif

autocmd FileType arduino nmap <F8> :!arduino-cli compile --fqbn arduino:avr:uno
autocmd FileType arduino nmap <F9> :!arduino-cli upload -p /dev/ttyUSB0 --fqbn arduino:avr:uno

autocmd FileType * nmap <C-e> :NERDTreeToggle<CR>

autocmd FileType cpp nmap <F5> :!./%:r<CR>
autocmd FileType cpp nmap <F8> :make %:r && ./%:r<CR>
autocmd Filetype cpp nmap <F9> :!g++ -std=c++17 -Wshadow -Wall -o %:r % -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG && ./%:r<CR>
