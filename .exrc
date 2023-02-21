let g:conjure#filetype#fennel = "conjure.client.fennel.stdio"
let g:conjure#client#fennel#stdio#command = "fennel --add-fennel-path 'fnl/?.fnl' --add-macro-path 'fnl/?.fnl'"
lua vim.diagnostic.disable()
