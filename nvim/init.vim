" =============================================================================
" # PLUGINS
" =============================================================================
" Load vundle
call plug#begin()

set nocompatible
filetype off

" GUI enhancements
Plug 'itchyny/lightline.vim'
Plug 'w0rp/ale'
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'

Plug 'chriskempson/base16-vim'

if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
    noremap <C-q> :confirm qall<CR>
end

call plug#end()

" deal with colors
if !has('gui_running')
  set t_Co=256
endif

if (match($TERM, "-256color") != -1) && (match($TERM, "screen-256color") == -1)
  " screen does not (yet) support truecolor
  set termguicolors
endif

" Colors
set background=dark
colorscheme base16-gruvbox-dark-hard 
"hi Normal ctermbg=NONE

" Get syntax
syntax on

" Base16
let base16colorspace=256

" Lightline
let g:lightline = { 'colorscheme': 'wombat' }

function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" =============================================================================
" # GUI settings
" =============================================================================
set number 		" show current absolute line number
set relativenumber 	" show relative line numbers
set nofoldenable    	" disable folding
set ruler
set showcmd 		" Show (partial) command in status line.
set mouse=a 		" Enable mouse usage (all modes) in terminals
set laststatus=2


