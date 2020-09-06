" plugin/i18next.vim
" Author: Tim Hwang <https://github.com/timhwang21>

if exists("g:loaded_i18next") || &cp
  finish
endif
let g:loaded_i18next = 1

try
  call toop#mapFunction('i18next#goto', '<leader>gT')
catch
  echo "vim-i18next failed to register shortcut"
  finish
endtry
