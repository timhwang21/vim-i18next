# vim-i18next

[![asciinema](https://asciinema.org/a/J0Tp1pY3QjffC3X87DnqAAnBw.svg)](https://asciinema.org/a/J0Tp1pY3QjffC3X87DnqAAnBw)

This plugin allows for navigating to the internationalized value of a translation key.

vim-i18next optionally depends on [`vim-toop`](jeanCarloMachado/vim-toop) to allow operating on text objects. With `vim-toop` installed, pressing `gTi'` when the cursor is over `t('path.to.translation')` will open the specified locale file and jump to the definition.

While this was written when [i18next](https://www.i18next.com/) in mind, it will allow you to jump to arbitrary dot-delimited paths in a specified JSON file.

## Quick Start

```vim
" Install plugin (in this example using vim-plug)
Plug 'timhwang21/vim-i18next'

" Install optional dependencies
Plug 'jeanCarloMachado/vim-toop'

" Set path to 'main' locale file
let g:i18next_locale_path = '/path/to/file.json'

" Alternatively, use autocmd for project-specific locale files
autocmd BufRead,BufNewFile /path/to/project/client/*.tsx
/ let g:i18next_local_path = '/app/assets/locales/translation.en-US.json'
autocmd BufRead,BufNewFile /path/to/project/server/*.rb
/ let g:i18next_local_path = '/config/locales/en-US.json'

" Optionally rebind shortcut (defaults to gT)
let g:i18next_shortcut = 'gt'
```

See `:help i18next` for more information.
