# vim-i18next

[![asciinema](https://asciinema.org/a/pQjrOxnFgzk5X0GOCIkyVyucQ.svg)](https://asciinema.org/a/pQjrOxnFgzk5X0GOCIkyVyucQ)

This plugin allows for navigating to the internationalized value of a translation key.

While this was written when [i18next](https://www.i18next.com/) in mind, it will allow you to jump to arbitrary dot-delimited paths in a specified JSON file.

## Requirements

* [`mogelbrod/vim-jsonpath`](https://github.com/mogelbrod/vim-jsonpath)
* GNU `sed` installed as `gsed` (the default when running `brew install gsed`)

## Quick Start

```sh
# Install GNU sed
brew install gsed
```

```vim
" Install plugin and dependencies (in this example using vim-plug)
Plug 'timhwang21/vim-i18next'
Plug 'mogelbrod/vim-jsonpath'

" Set path to locale file
let g:i18next_locale_path = '/path/to/file.json'
" If you have different locale files for different areas of the codebase, you
" can use autocmd to set the path based on the current file
autocmd BufRead,BufNewFile /path/to/project/client/*.tsx
/ let g:i18next_local_path = '/app/assets/locales/translation.en-US.json'
autocmd BufRead,BufNewFile /path/to/project/server/*.rb
/ let g:i18next_local_path = '/config/locales/en-US.json'

" Usage
" Print translation value
call i18next#echo('your.search.path')
" Go to translation value
call i18next#goto('your.search.path')
" Print translation value for key on current line
call i18next#echo_cursorline()
" Go to translation value for key on current line
call i18next#goto_cursorline()

" Example mappings
nmap gt :call i18next#goto_cursorline()<CR>
nmap <leader>t :call i18next#echo_cursorline()<CR>
" Example mappings using vim-toop
" This allows operating on text objects for flexibility
" gti' will run the function on the string within single quotes
call toop#mapFunction('i18next#goto', gt)
call toop#mapFunction('i18next#echo', <leader>t)
```

See `:help i18next` for more information.
