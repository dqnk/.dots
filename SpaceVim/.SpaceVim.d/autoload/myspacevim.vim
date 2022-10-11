function! myspacevim#after() abort

    autocmd BufNewFile *.cpp 0r ~/.SpaceVim.d/skeletons/cp.cpp
    autocmd BufNewFile *.tex 0r ~/.SpaceVim.d/skeletons/template.tex
    let g:vimtex_view_general_viewer = 'zathura'
    let g:neoformat_enabled_c = ['clangformat']
    let g:neoformat_enabled_cpp = ['clangformat']
    let g:neoformat_enabled_cuda = ['clangformat']
    let g:neoformat_enabled_python = ['black']
    let g:neoformat_enabled_typescript = ['clangformat']
    let g:neoformat_enabled_javascript = ['clangformat']
    let g:neoformat_enabled_java = ['clangformat']
    let g:neoformat_java_clangformat = {
                \ 'exe': 'clang-format',
                \ 'args': ["-style='{BreakAfterJavaFieldAnnotations: false, IndentWidth: 4}'", '-assume-filename=' . expand('%:t')],
                \ 'stdin': 1,
                \ }

    let g:neoformat_typescript_clangformat = {
                \ 'exe': 'clang-format',
                \ 'args': ['-style={IndentWidth: 4}', '-assume-filename=' . expand('%:t')],
                \ 'stdin': 1,
                \ }
    let g:neoformat_javascript_clangformat = {
                \ 'exe': 'clang-format',
                \ 'args': ['-style={IndentWidth: 4}', '-assume-filename=' . expand('%:t')],
                \ 'stdin': 1,
                \ }
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
                \ ['jasonccox/vim-wayland-clipboard'],
                \ ]
endfunction
