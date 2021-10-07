" =============================================================================
" PLUGINS
" =============================================================================
" Load vundle
call plug#begin()

set nocompatible
filetype off

" GUI enhancements
Plug 'tpope/vim-sensible'             " set of useful defaults

Plug 'itchyny/lightline.vim'          " status bar
Plug 'machakann/vim-highlightedyank'  " make yanked region highlighted
Plug 'andymass/vim-matchup'           " better support of matching for programming languages
Plug 'matze/vim-move'                 " easily move lines
Plug '/usr/local/opt/fzf'             " fuzzy search plugin
Plug 'junegunn/fzf.vim'               " fuzzy search integration for vim
Plug 'scrooloose/nerdtree'            " file explorer
Plug 'Xuyuanp/nerdtree-git-plugin'    " show git status flags in file expoler
Plug 'scrooloose/nerdcommenter'       " comment lines
Plug 'joshdick/onedark.vim'           " onedark color schema
Plug 'janko/vim-test'                 " test runner
Plug 'benmills/vimux'                 " runs commands from vim in tmux
Plug 'airblade/vim-gitgutter'         " show git changes in the file

" Programming language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neovim/nvim-lsp'
Plug 'cespare/vim-toml'

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
colorscheme onedark
"hi Normal ctermbg=NONE

" Get syntax
syntax on

" =============================================================================
" Lightline
" =============================================================================
let g:lightline = { 'colorscheme': 'onedark' }

function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" =============================================================================
" NERDTree
" =============================================================================

" open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" =============================================================================
" NERDCommenter
" =============================================================================

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" =============================================================================
" coc.vim
" =============================================================================

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  :call CocAction('format')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
" nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" =============================================================================
" GUI settings
" =============================================================================
set ttyfast                                         " more characters will be sent to the screen for redrawing
set backspace=indent,eol,start                      " make backspace behave properly in insert mode
set wildmenu                                        " better menu with completion in command mode
set wildmode=longest:full,full
set noswapfile                                      " disable swap files
set autoread                                        " automatically read changes in the file
set clipboard^=unnamed,unnamedplus                  " use system clipboard on all platforms
set nowrap                                          " disable soft wrap for lines
set scrolloff=2                                     " always show 2 lines above/below the cursor
set showcmd                                         " display incomplete commands
set laststatus=2 				                            " always display the status line
set number 					                                " show current absolute line number
" set relativenumber 				                          " show relative line numbers
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

" =============================================================================
" Keyboard shortcuts
" =============================================================================
" Space as a leader key
let mapleader="\<Space>"

" Esc button with shortcut
imap jj <ESC>

" Move by line
nnoremap j gj
nnoremap k gk

" No arrow keys - force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" ; as :
nnoremap ; :

" Jump to start and end of line using the home row keys
map H ^
map L $

" Quick-save
nmap <leader>w :w<CR>

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" Open hotkeys
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" NERDTree
map <leader>nt :NERDTreeToggle<CR>
map <leader>nr :NERDTree<CR>
map <leader>nf :NERDTreeFind<CR>

" =============================================================================
" Autocommands
" =============================================================================
" Jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
