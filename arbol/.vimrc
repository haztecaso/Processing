command! -nargs=1 StartAsync
         \ call jobstart(<f-args>, {
         \    'on_exit': { j,d,e ->
         \       execute('echom "command finished with exit status '.d.'"', '')
         \    }
         \ })

inoremap <F5> :StartAsync make<CR>
nnoremap <F5> :StartAsync make<CR>
