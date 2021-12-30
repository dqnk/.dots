"plugins - vim-plug
call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'vim-scripts/LargeFile'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'
Plug 'gko/vim-coloresque'
Plug 'lervag/vimtex'
Plug 'yegappan/mru'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'chrisbra/csv.vim'
Plug 'mhinz/vim-startify'
Plug 'junegunn/goyo.vim'
Plug 'vimwiki/vimwiki'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'liuchengxu/vista.vim'

"deoplete - autocompletion
if has('nvim')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
	Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
endif

let g:deoplete#enable_at_startup = 1



"deoplete tabnine"
if has('win32') || has('win64')
	Plug 'tbodt/deoplete-tabnine', { 'do': 'powershell.exe .\install.ps1' }
else
	Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
endif



call plug#end()

lua << EOF
require'lspconfig'.pyright.setup{}
require'lspconfig'.clangd.setup{}
EOF

set encoding=UTF-8
set updatetime=100
set synmaxcol=1024
set textwidth=80
set nocompatible
filetype plugin on
syntax enable
set tabstop=8
set signcolumn=yes
colorscheme vim-monokai-tasty
highlight Normal ctermbg=none
highlight NonText ctermbg=none
set showcmd
set smartindent
set cursorline
set relativenumber
set nu rnu
set foldmethod=indent
set clipboard+=unnamedplus
set wmh=0
"has to have space at the end
set list lcs=tab:\|\ 

let g:deoplete#enable_at_startup = 1

let g:python_highlight_all = 1
let g:ale_enabled=0

let g:airline_theme='wombat'
let g:airline_powerline_fonts = 1

let g:ycm_filetype_blacklist = {}
let g:goyo_width = 86

let g:netrw_keepdir=0
let &colorcolumn = join(range(81,999), ',')

autocmd StdinReadPre * let s:std_in=1

"autocmd VimEnter * NERDTree | set relativenumber | set nu rnu | if argc() > 0 || exists("s:std_in") | wincmd p | endif

"deoplete with tab
function! s:check_back_space() abort "{{{
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ deoplete#manual_complete()


autocmd VimEnter *
			\   if !argc() 
			\ |   Startify
			\ |   NERDTree
			\ |   set relativenumber
			\ |   set nu rnu
			\ |   wincmd w
			\ | endif

"numbers for goyo mode
function! s:goyo_enter()
	set nu rnu
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd FileType arduino nmap <F8> :!arduino-cli compile --fqbn arduino:avr:uno
autocmd FileType arduino nmap <F9> :!arduino-cli upload -p /dev/ttyUSB0 --fqbn arduino:avr:uno

tnoremap <Esc> <C-\><C-n>
map <Space> <Leader>
map <F3> :NERDTreeFind<CR>
map <C-e> :NERDTreeToggle<CR>
map <C-s> :w<CR>
map <C-h> :Goyo<CR>
map <C-p> :pyf /usr/share/clang/clang-format.py <CR>
map <C-j> :Vista<CR>
map <F1> :q<CR>
map <F2> :lua vim.lsp.buf.code_action() <CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


autocmd FileType cpp nmap <F5> :!./%:r<CR>
autocmd FileType cpp nmap <F8> :make %:r && ./%:r<CR>
autocmd FileType tex nmap <F8> :Latexmk <CR> 
autocmd Filetype cpp nmap <F9> :!g++ -std=c++17 -Wshadow -Wall -o %:r % -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG && ./%:r<CR>

autocmd BufNewFile  *.cpp 0r ~/.config/nvim/template/template.cpp
