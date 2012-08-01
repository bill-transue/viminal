call pathogen#infect()
call pathogen#helptags()

if has("mouse")
  set mouse=a
endif

syntax enable
set background=dark
colorscheme solarized
filetype plugin indent on
set sw=2 ts=2 sts=2
set expandtab

set grepprg=grep\ -nH\ $*

let g:tex_flavor='latex'

cabbr hardtabs call Hardtabs()
fun Hardtabs()
  set tabstop=8
  set shiftwidth=8
  set softtabstop=0
  set noexpandtab
endfu

cabbr wp call Wp()
fun! Wp()
  set lbr
  source $HOME/.vim/not-bundle/vim-autocorrect/autocorrect.vim
  set guifont=Consolas:h14
  nnoremap j gj
  nnoremap k gk
  nnoremap 0 g0
  nnoremap $ g$
  set nonumber
  set spell spelllang=en_us
endfu

cabbr spell call Spell()
function Spell()
  setlocal spell spellang=en_us
endfu

function MoveToPrevTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    sp
  else
    close!
    exe "0tabnew"
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

function MoveToNextTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    sp
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

"Powerline shit
set nocompatible
set laststatus=2
set encoding=utf-8
set t_Co=256
let g:Powerline_symbols = 'fancy'

nnoremap <C-W>. :call MoveToNextTab()<CR>
nnoremap <C-W>, :call MoveToPrevTab()<CR>
nnoremap <C-u> :GundoToggle<CR>
nnoremap <C-s> :call Spell()<CR>
