" autoload/i18next.vim
" Author: Tim Hwang <https://github.com/timhwang21>

if exists('g:autoloaded_i18next')
  finish
endif
let g:autoloaded_i18next = 1

if !exists('g:i18next_locale_path')
  echo "vim-i18next: Plugin will not work without g:i18next_locale_path set to a translation file."
  finish
endif

let s:plugin_dir=expand('<sfile>:p:h:h')

" Returns the line number for the given path.
" Note the nonstandard error code of -1; this is because the standard response
" of 0 is misleading as it is a valid line number.
" Arguments: ([search_for])
function! i18next#get_position(search_for) abort "{{{
  execute "e" g:i18next_locale_path
  let pos = jsonpath#scan_buffer(a:search_for)
  execute "e #"

  if empty(pos)
    echo "Path not found: " . search_for
    return []
  else
    let file_row = pos[1]
    let file_col = pos[2]
    return [file_row, file_col]
  endif
endfunction "}}}

" Print translation for provided key to messages.
" Arguments: ([search_for])
function! i18next#echo(search_for) abort "{{{
  let pos = i18next#get_position(a:search_for)

  if empty(pos)
    echo "Path not found: " . search_for
    return
  endif

  let file_row = pos[0]
  let line = readfile(g:i18next_locale_path, '', file_row)[file_row - 1]
  echom trim(line)
endfunction "}}}

" Jump to translation for provided key. Attempts to place the cursor on
" identifier for the given path.
" Arguments: ([search_for])
function! i18next#goto(search_for) abort "{{{
  let pos = i18next#get_position(a:search_for)

  if empty(pos)
    echo "Path not found: " . search_for
    return
  endif

  let file_row = pos[0]
  let file_col = pos[1]

  execute "e" g:i18next_locale_path
  call cursor(file_row, file_col)
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
