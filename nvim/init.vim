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
  set t_Co=256 " enable 256 colors
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
set ttyfast                                         " more characters will be sent to the screen for redrawing
set backspace=indent,eol,start                      " make backspace behave properly in insert mode
set wildmenu                                        " better menu with completion in command mode
set wildmode=longest:full,full
set noswapfile                                      " disable swap files
set autoread                                        " automatically read changes in the file
set clipboard^=unnamed,unnamedplus                  " use system clipboard on all platforms
set completeopt=longest,menuone,preview             " better insert mode completions
set nowrap                                          " disable soft wrap for lines
set scrolloff=2                                     " always show 2 lines above/below the cursor
set showcmd                                         " display incomplete commands
set laststatus=2 				                            " always display the status line
set number 					                                " show current absolute line number
set relativenumber 				                          " show relative line numbers
set cursorline                                      " highlight current line
set colorcolumn=110                                 " display text width column
set splitbelow                                      " vertical splits will be at the bottom
set splitright                                      " horizontal splits will be to the right
set autoindent                                      " always set autoindenting on
set formatoptions-=cro                              " disable auto comments on new lines
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab  " use two spaces for indentation
set incsearch                                       " incremental search highlight
set ignorecase                                      " searches are case insensitive...
set smartcase                                       " ..unless they contain at least one capital letter
set hlsearch                                        " highlight search patterns
set nofoldenable    				                        " disable folding
set ruler                                           " dispaly cursor position in the editor
set mouse=a 		                                    " Enable mouse usage (all modes) in terminals


