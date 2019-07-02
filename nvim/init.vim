" =============================================================================
" # PLUGINS
" =============================================================================
" Load vundle
call plug#begin()

set nocompatible
filetype off

" GUI enhancements
Plug 'tpope/vim-sensible'             " set of useful defaults

Plug 'itchyny/lightline.vim'          " status bar
Plug 'w0rp/ale'                       " async linting
Plug 'machakann/vim-highlightedyank'  " make yanked region highlighted
Plug 'andymass/vim-matchup'           " better support of matching for programming languages
Plug 'matze/vim-move'                 " easily move lines
Plug 'junegunn/fzf'

Plug 'chriskempson/base16-vim'        " base16 color schemas

" Semantic language support
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

" Completion plugins
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-vim'
" Plug 'ncm2/ncm2-racer'

" Syntactic language support
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'cespare/vim-toml'
Plug 'Shougo/neco-vim', { 'for': 'vim' }

" LSP
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

call plug#end()

if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
    noremap <C-q> :confirm qall<CR>
end


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

" LSP
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls']
    \}

" Rust
let g:rustfmt_autosave = 1

" Linter
" only lint on save
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_save = 0
let g:ale_lint_on_enter = 0
let g:ale_virtualtext_cursor = 1
let g:ale_rust_rls_config = {
	\ 'rust': {
		\ 'all_targets': 1,
		\ 'build_on_save': 1,
		\ 'clippy_preference': 'on'
	\ }
	\ }
let g:ale_rust_rls_toolchain = ''
let g:ale_linters = {'rust': ['rls']}
highlight link ALEWarningSign Todo
highlight link ALEErrorSign WarningMsg
highlight link ALEVirtualTextWarning Todo
highlight link ALEVirtualTextInfo Todo
highlight link ALEVirtualTextError WarningMsg
highlight ALEError guibg=None
highlight ALEWarning guibg=None
" let g:ale_sign_error = "✖"
" let g:ale_sign_warning = "⚠"
" let g:ale_sign_info = "i"
" let g:ale_sign_hint = "➤"

nnoremap <silent> K :ALEHover<CR>
nnoremap <silent> gd :ALEGoToDefinition<CR>

" enable ncm2 for all buffers
" augroup NCM
"     autocmd!
      autocmd BufEnter * call ncm2#enable_for_buffer()
" augroup END

" IMPORTANT: :help Ncm2PopupOpen for more information
 set completeopt=noinsert,menuone,noselect
 
" tab to select
inoremap <expr><Tab> (pumvisible()?(empty(v:completed_item)?"\<C-n>":"\<C-y>"):"\<Tab>")
" and don't hijack my enter key
inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")

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


