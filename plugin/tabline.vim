" File:                   tabline.vim
" Maintainer (original):  Matthew Kitt <http://mkitt.net/>
" Maintainer (forked):    Jakub Chlanda
" Description:            Configure tabs within Terminal Vim.
" Last Change:            2023-12-07
" License:
" This program is free software. It comes without any warranty, to the extent
" permitted by applicable law. You can redistribute it and/or modify it under
" the terms of the Do What The Fuck You Want To Public License, Version 2, as
" published by Sam Hocevar. See http://sam.zoy.org/wtfpl/COPYING for more
" details.
" Based On:               http://www.offensivethinking.org/data/dotfiles/vimrc
"                         https://github.com/mkitt/tabline.vim

" Bail quickly if the plugin was loaded, disabled or compatible is set
if (exists("g:loaded_tabline_vim") && g:loaded_tabline_vim) || &cp
  finish
endif
let g:loaded_tabline_vim = 1

function! Tabline()
  let s = ''
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let winnr = tabpagewinnr(tab)
    let buflist = tabpagebuflist(tab)
    let bufnr = buflist[winnr - 1]
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")

    let s .= '%' . tab . 'T'
    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . tab .':'
    if bufname != ''
      if exists("g:tablinemaxwidth")
        let extension = fnamemodify(bufname, ':e:e')
        let extension_len = len(extension)
        let base = fnamemodify(bufname, ':t:r')
        let base_len = len(base)
        let total_len = extension_len + base_len + 1 " for '.'
        if total_len > g:tablinemaxwidth
          if extension_len > 4
            let extension = extension[extension_len-3:extension_len-1]
            let extension_len = 3
          endif
          if extension_len + base_len + 1 > g:tablinemaxwidth
            let left_for_file_name = g:tablinemaxwidth - extension_len - 2 " for '#' and '.'
            let front_part = (left_for_file_name / 2) - 1
            let back_part = left_for_file_name - 1 - front_part - 1
            let base = base[0:front_part] . '#' . base[base_len-back_part-1:base_len-1]
          endif
        endif
        let bufname = '['. base . '.' . extension . '] '
      else
        let bufname = '['. fnamemodify(bufname, ':t') . '] '
      endif
    else
      let bufname = '[No Name] '
    endif
    let s .= bufname

    if bufmodified
      let s .= '[+] '
    endif
  endfor

  let s .= '%#TabLineFill#'
  return s
endfunction
set tabline=%!Tabline()

