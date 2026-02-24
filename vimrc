" ==============================================================================
" BASIC SETTINGS
" ==============================================================================
set nocompatible         " Disable old vi compatibility
set encoding=utf-8       " Standard encoding
set number               " Show line numbers
set relativenumber       " Relative line numbers for easier jumping
set hidden               " Allow switching buffers without saving
set updatetime=300       " Faster update time for LSP hover/diagnostics
set signcolumn=yes       " Always show gutter to prevent screen shifting
set completeopt=menuone,noinsert,noselect,preview " Better autocomplete menu behavior
set timeoutlen=500   " Wait 500ms for mapping sequences (like <leader>ff)
set ttimeoutlen=10   " Wait only 10ms for key codes (for fast escape back to normal mode)
set clipboard=unnamedplus   " Link Vim's unnamed register to the system clipboard
let mapleader = " "      " Spacebar is the modern leader key

" ==============================================================================
" PLUGIN INSTALLATION (Using vim-plug)
" ==============================================================================
call plug#begin('~/.vim/plugged')

    " 1. LSPs & Autocomplete
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
    Plug 'prabirshrestha/asyncomplete.vim'     " The autocomplete engine
    Plug 'prabirshrestha/asyncomplete-lsp.vim' " Bridges LSP to the engine

    " 2. Leaping ('s')
    Plug 'justinmk/vim-sneak'

    " 3. Telescope Equivalent
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " 4. Oil.nvim Equivalent
    Plug 'justinmk/vim-dirvish'
    Plug 'tpope/vim-eunuch'       

    " 5. Autopairs
    Plug 'jiangmiao/auto-pairs'

    " 6. Commenting Motions
    Plug 'tpope/vim-commentary'

    " 7. Viewing Registers
    Plug 'junegunn/vim-peekaboo'

    " 9. Theme
    Plug 'catppuccin/vim', { 'as': 'catppuccin' }

    " 10. Better syntax highlighting
    Plug 'sheerun/vim-polyglot'
    
    call plug#end()

" ==============================================================================
" PLUGIN CONFIGURATION
" ==============================================================================

" --- 1. LSPs (Squiggles) ---
let g:lsp_diagnostics_enabled = 1
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
" Style the squiggles
highlight LspErrorHighlight gui=undercurl guisp=Red cterm=underline ctermfg=Red
highlight LspWarningHighlight gui=undercurl guisp=Yellow cterm=underline ctermfg=Yellow

" --- 2. Sneak (Leap) ---
let g:sneak#label = 1 
let g:sneak#s_next = 1 

" --- 3. Autocomplete (Tab Completion) ---
" This makes the popup menu work like an IDE.
" Tab to select next, Shift-Tab to select previous, Enter to confirm.
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" ==============================================================================
" KEYBINDS & CUSTOM BEHAVIOR
" ==============================================================================

" --- LSP Keybinds ---
nnoremap <leader>ld :LspDefinition<CR>
nnoremap <leader>lr :LspReferences<CR>
nnoremap <leader>lh :LspHover<CR>
nnoremap <leader>la :LspCodeAction<CR>
nnoremap <leader>rn :LspRename<CR>

" --- File Finding (Telescope-ish) ---
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fb :Buffers<CR>

" --- Black Hole Deletion ---
" <leader>d followed by any motion deletes to the black hole register ("_).
" Example: <leader>dd deletes line without overtaking clipboard.
" Example: <leader>dw deletes word without overtaking clipboard.
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" --- Smart New Lines ---
" Open new line below/above but stay in Normal mode
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>

" ==============================================================================
" UI POLISH (Cursor & Numbers)
" ==============================================================================

" --- Cursor Shape Changing ---
" Block in Normal mode, Thin Bar in Insert mode
if &term =~ '^xterm' || &term =~ '^screen' || &term =~ '^nvim' || exists('$TMUX')
    let &t_SI = "\<Esc>[6 q"  " Insert mode (beam)
    let &t_SR = "\<Esc>[4 q"  " Replace mode (underline)
    let &t_EI = "\<Esc>[2 q"  " Normal mode (block)
endif

" --- Contextual Line Numbering ---
" Relative numbers in Normal mode, Absolute numbers in Insert mode
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set relativenumber | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set norelativenumber | endif
augroup END

" ==============================================================================
" THEME & CUSTOM HIGHLIGHTS (Catppuccin)
" ==============================================================================

" Enable true color support (Crucial for modern themes to look right)
if (has("termguicolors"))
  set termguicolors
endif

" Apply the Catppuccin Mocha theme
colorscheme catppuccin_mocha

" --- Perfecting the Autocomplete Menu Colors ---
" This overrides any ugly defaults to perfectly match Catppuccin Mocha's palette

" Pmenu: Normal item background (Catppuccin 'Mantle' & 'Text')
highlight Pmenu guibg=#181825 guifg=#cdd6f4 ctermbg=235 ctermfg=253

" PmenuSel: Selected item background (Catppuccin 'Surface0' & bold text)
highlight PmenuSel guibg=#313244 guifg=#cdd6f4 gui=bold ctermbg=237 ctermfg=253 cterm=bold

" PmenuSbar: Scrollbar track (Catppuccin 'Base')
highlight PmenuSbar guibg=#1e1e2e ctermbg=234

" PmenuThumb: Scrollbar handle (Catppuccin 'Surface2')
highlight PmenuThumb guibg=#585b70 ctermbg=240
