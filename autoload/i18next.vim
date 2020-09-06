" autoload/i18next.vim
" Author: Tim Hwang <https://github.com/timhwang21>
" Requires the the following extensions:
"   mogelbrod/vim-jsonpath

if exists('g:autoloaded_i18next')
  finish
endif
let g:autoloaded_i18next = 1

if !has_key(plugs, 'vim-jsonpath')
  echo "vim-i18next will not work without vim-jsonpath"
  finish
endif

if !exists('g:i18next_locale_path')
  echo "vim-i18next will not work without g:i18next_locale_path set to a translation file"
  finish
endif

" Jump to translation using Toop
" Attempts to place the cursor on identifier for the given path
" Arguments: ([search_for])
function! i18next#goto(search_for) abort "{{{
  execute "e " g:i18next_locale_path
  call jsonpath#goto(a:search_for)
endfunction "}}}

