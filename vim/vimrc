" ==============================================================================
" BASIC SETTINGS
" ==============================================================================
set nocompatible         " Disable old vi compatibility
set encoding=utf-8       " Standard encoding
set number               " Show line numbers
set relativenumber       " Relative line numbers for easier jumping
set hidden               " Allow switching buffers without saving
set updatetime=300       " Faster update time for LSP hover/diagnostics & GitGutter
set signcolumn=yes       " Always show gutter to prevent screen shifting
set completeopt=menuone,noinsert,noselect,preview " Better autocomplete menu
set timeoutlen=500       " Wait 500ms for mapping sequences (like <leader>ff)
set ttimeoutlen=10       " Wait only 10ms for key codes (fast escape)
set clipboard=unnamedplus " Link Vim's unnamed register to the system clipboard
set showtabline=2        " Vscode style file tabs at the top
let mapleader = " "      " Spacebar is the modern leader key

" --- Indentation ---
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smartindent      " Automatically inserts extra indents for new code blocks

" --- Visual Ruler ---
set colorcolumn=120  " Draw a vertical line at 120 characters

set ignorecase " Default to search case-insensitively
set smartcase  " Automatically switch to case-sensitive if you type a capital letter

" ==============================================================================
" PLUGIN INSTALLATION (Using vim-plug)
" ==============================================================================
call plug#begin('~/.vim/plugged')

    " 1. LSPs & Autocomplete
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'

    " 2. Leaping ('s')
    Plug 'justinmk/vim-sneak'

    " 3. Telescope Equivalent
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " 4. File Management
    Plug 'justinmk/vim-dirvish'
    Plug 'tpope/vim-eunuch'       

    " 5. Autopairs (Note: Can conflict with Ctrl-J)
    Plug 'jiangmiao/auto-pairs'

    " 6. Commenting Motions
    Plug 'tpope/vim-commentary'

    " 7. Viewing Registers
    Plug 'junegunn/vim-peekaboo'

    " 8. Theme (Swapped to Monokai)
    Plug 'crusoexia/vim-monokai'

    " 9. Start Screen
    Plug 'mhinz/vim-startify'

    " 10. Indent Lines
    Plug 'Yggdroot/indentLine'

    " 11. Status Line
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " 12. Git Integration (Gutter Signs)
    Plug 'airblade/vim-gitgutter'

    " 13. Smooth Scrolling
    Plug 'psliwka/vim-smoothie'

call plug#end()

" ==============================================================================
" AI INTEGRATION CONFIGURATION
" ==============================================================================

" Automatically update files modified outside of Vim (like by your AI CLI)
set autoread

" Trigger the autoread check whenever Vim regains focus or you switch buffers
augroup AITmuxSync
    autocmd!
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
augroup END

" ==============================================================================
" PLUGIN CONFIGURATION
" ==============================================================================
"
" --- 1. LSPs (Squiggles & Toggles) ---
let g:lsp_diagnostics_enabled = 1
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_virtual_text_enabled = 0

" --- 2. Sneak (Leap) ---
let g:sneak#label = 1 

" --- 3. FZF Configuration ---
let $FZF_DEFAULT_OPTS = '--bind ctrl-j:down,ctrl-k:up'

" --- 4. Autocomplete (Tab Completion) ---
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <C-j>   pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k>   pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" --- 5. Startify (Home Screen) ---
let g:startify_lists = [
      \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
      \ { 'type': 'files',     'header': ['   Recent Files'] },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks'] },
      \ ]
let g:startify_change_to_dir = 0

" --- 6. IndentLine ---
let g:indentLine_char = '│' 
let g:indentLine_first_char = '│'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_fileTypeExclude = ['json', 'markdown', 'startify']
let g:indentLine_setColors = 0

" --- 7. GitGutter (VS Code Style) ---
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed = '_'
let g:gitgutter_sign_removed_first_line = '‾'
let g:gitgutter_sign_modified_removed = '│'
let g:gitgutter_set_sign_backgrounds = 0

" --- 8. Vim-Airline Configuration ---
set noshowmode
let g:airline#extensions#tabline#enabled = 1

" Tell airline to assign numbers to the top tabs
let g:airline#extensions#tabline#buffer_idx_mode = 1

" Map <leader>1 through <leader>9 to jump to the respective tab
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" Show number next to the file tabs
let g:airline#extensions#tabline#buffer_idx_format = {
      \ '0': '0 ',
      \ '1': '1 ',
      \ '2': '2 ',
      \ '3': '3 ',
      \ '4': '4 ',
      \ '5': '5 ',
      \ '6': '6 ',
      \ '7': '7 ',
      \ '8': '8 ',
      \ '9': '9 '
      \}

" --- 9. Minimal Native File Tree (Netrw) ---
let g:netrw_banner = 0        
let g:netrw_liststyle = 3     
let g:netrw_winsize = 25      
let g:netrw_browse_split = 4  

" ==============================================================================
" KEYBINDS & CUSTOM BEHAVIOR
" ==============================================================================

nnoremap <leader>ld :LspDefinition<CR>
nnoremap <leader>lr :LspReferences<CR>
nnoremap <leader>lh :LspHover<CR>
nnoremap <leader>la :LspCodeAction<CR>
nnoremap <leader>rn :LspRename<CR>

" Jump to the next/previous error in the file
nnoremap ]g :LspNextDiagnostic<CR>
nnoremap [g :LspPreviousDiagnostic<CR>

" Open a list of all errors in the current file at the bottom of the screen
nnoremap <leader>le :LspDocumentDiagnostics<CR>

" File things
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fb :Buffers<CR>

nnoremap <leader>e :Lexplore<CR>

nnoremap <leader>d "_d
vnoremap <leader>d "_d

nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>

" Close the current tab (buffer) safely
nnoremap <leader>bd :bdelete<CR>

" --- Fast Project Searching (Ripgrep Integration) ---
if executable('rg')
    set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
    set grepformat=%f:%l:%c:%m
endif

" ==============================================================================
" UI POLISH (Cursor, Numbers, Theme & Highlights)
" ==============================================================================

if &term =~ '^xterm' || &term =~ '^screen' || &term =~ '^nvim' || exists('$TMUX')
    let &t_SI = "\<Esc>[6 q"  
    let &t_SR = "\<Esc>[4 q"  
    let &t_EI = "\<Esc>[2 q"  
endif

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set relativenumber | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set norelativenumber | endif
augroup END

" --- Apply Theme First ---
if (has("termguicolors"))
  set termguicolors
endif
colorscheme monokai

" --- Apply Custom Highlights AFTER Theme ---
highlight LspErrorHighlight gui=undercurl guisp=Red cterm=underline ctermfg=Red
highlight LspWarningHighlight gui=undercurl guisp=Yellow cterm=underline ctermfg=Yellow

" Monokai Popup Menu Colors
highlight Pmenu guibg=#3E3D32 guifg=#F8F8F2 ctermbg=237 ctermfg=253
highlight PmenuSel guibg=#49483E guifg=#F8F8F2 gui=bold ctermbg=239 ctermfg=253 cterm=bold
highlight PmenuSbar guibg=#272822 ctermbg=235
highlight PmenuThumb guibg=#75715E ctermbg=242

" Monokai Conceal (Indent lines etc)
highlight Conceal guifg=#75715E ctermfg=242 guibg=NONE ctermbg=NONE

" Monokai GitGutter Colors
highlight GitGutterAdd    guifg=#A6E22E ctermfg=Green
highlight GitGutterChange guifg=#66D9EF ctermfg=Blue
highlight GitGutterDelete guifg=#F92672 ctermfg=Red
highlight GitGutterChangeDelete guifg=#E6DB74 ctermfg=Yellow

" --- Make Gutter Background Match Main Background ---
highlight LineNr guibg=NONE ctermbg=NONE
highlight CursorLineNr guibg=NONE ctermbg=NONE
highlight SignColumn guibg=NONE ctermbg=NONE

" ==============================================================================
" AUTO COMMANDS
" ==============================================================================
autocmd FileType * setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
