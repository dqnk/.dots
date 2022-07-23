autocmd BufNewFile *.cpp 0r ~/.SpaceVim.d/skeletons/cp.cpp
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
let g:neoformat_enabled_c = ['clangformat']
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_cuda = ['clangformat']
let g:neoformat_cpp_clangformat = {
      \ 'exe': 'clang-format',
      \ 'args': ['-style=Google', '-assume-filename=' . expand('%:t')],
      \ 'stdin': 1,
      \ }
let g:neoformat_c_clangformat = {
      \ 'exe': 'clang-format',
      \ 'args': ['-style=Google', '-assume-filename=' . expand('%:t')],
      \ 'stdin': 1,
      \ }
let g:neoformat_cuda_clangformat = {
      \ 'exe': 'clang-format',
      \ 'args': ['-style=Google', '-assume-filename=' . expand('%:t')],
      \ 'stdin': 1,
      \ }




let g:neomake_c_enabled_makers = ['clang']
let g:neomake_c_clang_maker = {
      \ 'args': ['-Wall', '-Wextra', '-Weverything'],
      \ }
let g:neomake_cpp_enabled_makers = ['clang']
let g:neomake_cpp_clang_maker = {
      \ 'exe': 'clang++',
      \ 'args': ['-Wall', '-Wextra', -'O2', '-Wno-sign-conversion'],
      \ }
let g:spacevim_autocomplete_method = 'deoplete'
let g:spacevim_custom_plugins = [
      \ ['tbodt/deoplete-tabnine', {'build': './install.sh'}],
\ ]

call SpaceVim#layers#load('lang#c')
call SpaceVim#layers#load('lang#python')
call SpaceVim#layers#load('lang#java')
call SpaceVim#layers#load('lang#jsonet')
call SpaceVim#layers#load('lang#rust')
call SpaceVim#layers#load('autocomplete')
call SpaceVim#layers#load('colorscheme')
call SpaceVim#layers#load('shell')

let g:spacevim_colorscheme='molokai'
