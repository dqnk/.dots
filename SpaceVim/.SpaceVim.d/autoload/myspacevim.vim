function! myspacevim#before() abort
    let g:mapleader = '-'
endfunction

function! myspacevim#after() abort
    autocmd BufNewFile *.cpp 0r ~/.SpaceVim.d/skeletons/cp.cpp
    autocmd BufNewFile *.tex 0r ~/.SpaceVim.d/skeletons/template.tex
    autocmd BufEnter * set wrap

    let g:rainbow_active = 1
    let g:vimtex_view_general_viewer = 'zathura'
    let g:neoformat_enabled_c = ['clangformat']
    let g:neoformat_enabled_cpp = ['clangformat']
    let g:neoformat_enabled_cuda = ['clangformat']
    let g:neoformat_enabled_python = ['black']
    let g:neoformat_enabled_java = ['astyle']
    let g:neoformat_enabled_rust = ['rustfmt']
    let g:neoformat_enabled_typescript=['prettier']
    let g:neoformat_enabled_javascript=['prettier']
    let g:neoformat_cpp_clangformat = {
                \ 'exe': 'clang-format',
                \ 'args': ['-style=file', '-fallback-style=Google'],
                \ 'stdin': 1,
                \ }
    let g:neoformat_c_clangformat = {
                \ 'exe': 'clang-format',
                \ 'args': ['-style=file', '-fallback-style=Google'],
                \ 'stdin': 1,
                \ }
    let g:neoformat_cuda_clangformat = {
                \ 'exe': 'clang-format',
                \ 'args': ['-style=file', '-fallback-style=Google'],
                \ }
    let g:neomake_c_enabled_makers = ['clang']
    let g:neomake_c_clang_maker = {
                \ 'args': ['-Wall', '-Wextra', '-O2', '-Weverything'],
                \ }
    let g:neomake_cpp_enabled_makers = ['clang']
    let g:neomake_cpp_clang_maker = {
                \ 'exe': 'clang++',
                \ 'args': ['-Wall', '-Wextra', '-O2', 'Weverything'],
                \ }
    let g:spacevim_autocomplete_method = 'deoplete'
    let g:spacevim_custom_plugins = [
                \ ['tbodt/deoplete-tabnine', {'build': './install.sh'}],
                \ ]

endfunction
