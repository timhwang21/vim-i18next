" autoload/i18next.vim
" Author: Tim Hwang <https://github.com/timhwang21>

if exists('g:autoloaded_i18next')
  finish
endif
let g:autoloaded_i18next = 1

if !exists('g:i18next_locale_path')
  echom "vim-i18next: Plugin will not work without g:i18next_locale_path set to a translation file."
  finish
endif

let s:plugin_dir=expand('<sfile>:p:h:h')

" Returns the line number for the given path.
" Note the nonstandard error code of -1; this is because 0 is misleading as it
" is a valid line number.
" Arguments: ([search_for])
function! i18next#get_line_nr(search_for) abort "{{{
  let line_nr = trim(system(s:plugin_dir. "/bin/find-line-number ". g:i18next_locale_path. " ". a:search_for))

  " We don't use str2nr() because the error response is 0, which is a valid
  " line number. Use regex instead.
  if (line_nr =~# '^\d\+$')
    return line_nr
  else
    return -1
  endif
endfunction "}}}

" Print translation for provided key to messages.
" Arguments: ([search_for])
function! i18next#echo(search_for) abort "{{{
  let line_nr = i18next#get_line_nr(a:search_for)

  if line_nr < 0
    echom "vim-i18next: Path was not found in file."
    return
  endif

  let line = readfile(g:i18next_locale_path, '', line_nr)[line_nr - 1]
  echom line
endfunction "}}}

" Jump to translation for provided key. Attempts to place the cursor on
" identifier for the given path.
" Arguments: ([search_for])
function! i18next#goto(search_for) abort "{{{
  let line_nr = i18next#get_line_nr(a:search_for)

  if line_nr < 0
    echom "vim-i18next: Path was not found in file."
    return
  endif

  execute "e" g:i18next_locale_path
  execute line_nr
endfunction "}}}

" Returns the first string between single/double quotes on the current line.
" TODO: How to find the result closest to the cursor column?
function! s:get_path_under_cursor() abort "{{{
  return trim(matchstr(getline('.'), '\v([''"])(.{-})\1'), "\"'")
endfunction "}}}

" Print translation for key in current line to messages.
function! i18next#echo_cursorline() abort "{{{
  call i18next#echo(s:get_path_under_cursor())
endfunction "}}}

" Jump to translation for key in current line. Attempts to place the cursor on
" identifier for the given path.
function! i18next#goto_cursorline() abort "{{{
  call i18next#goto(s:get_path_under_cursor())
endfunction "}}}
