" autoload/i18next.vim
" Author: Tim Hwang <https://github.com/timhwang21>

if exists('g:autoloaded_i18next')
  finish
endif
let g:autoloaded_i18next = 1

if !exists('g:i18next_locale_path')
  echo "vim-i18next will not work without g:i18next_locale_path set to a translation file."
  finish
endif

let s:plugin_dir=expand('<sfile>:p:h:h')

" Jump to translation using Toop
" Attempts to place the cursor on identifier for the given path
" Arguments: ([search_for])
function! i18next#goto(search_for) abort "{{{
  let line_nr = system(s:plugin_dir. "/bin/find-line-number ". g:i18next_locale_path. " ". a:search_for)

  if (trim(line_nr) =~# '^\d\+$')
    execute "e" g:i18next_locale_path
    execute line_nr
  else
    echo "Path was not found in file."
  endif
endfunction "}}}

