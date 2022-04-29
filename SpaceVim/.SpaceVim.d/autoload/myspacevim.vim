function! myspacevim#before() abort
let g:neoformat_c_clangformat = {
            \ 'exe': 'clang-format',
            \ 'args': ['--style=google'],
            \ }
endfunction

function! myspacevim#after() abort
let g:neoformat_c_clangformat = {
            \ 'exe': 'clang-format',
            \ 'args': ['--style=google'],
            \ }

endfunction
