" plugin/i18next.vim
" Author: Tim Hwang <https://github.com/timhwang21>

if exists("g:loaded_i18next") || &cp
  finish
endif
let g:loaded_i18next = 1

if !exists("g:i18next_shortcut")
  let g:i18next_shortcut = 'gT'
endif

try
  call toop#mapFunction('i18next#goto', g:i18next_shortcut)
catch
  echo "vim-i18next failed to register shortcut"
  finish
endtry
