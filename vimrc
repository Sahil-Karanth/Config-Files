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
set showtabline=0        " Never show the top tab/buffer line
let mapleader = " "      " Spacebar is the modern leader key

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

    " 8. Theme
    Plug 'catppuccin/vim', { 'as': 'catppuccin' }

    " 9. Start Screen
    Plug 'mhinz/vim-startify'

    " 10. Indent Lines
    Plug 'Yggdroot/indentLine'

    " 11. Status Line
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " 12. Git Integration (Gutter Signs)
    Plug 'airblade/vim-gitgutter'

call plug#end()

" ==============================================================================
" PLUGIN CONFIGURATION
" ==============================================================================

" --- 1. LSPs (Squiggles & Toggles) ---
let g:lsp_diagnostics_enabled = 1
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

let g:warnings_active = 1
function! ToggleWarnings()
    if g:warnings_active == 1
        let g:warnings_active = 0
        highlight clear LspWarningHighlight
        highlight link LspWarningText Ignore
        echo "LSP Warnings: SILENCED"
    else
        let g:warnings_active = 1
        highlight LspWarningHighlight gui=undercurl guisp=Yellow cterm=underline ctermfg=Yellow
        highlight LspWarningText guifg=Yellow ctermfg=Yellow
        echo "LSP Warnings: ACTIVE"
    endif
endfunction
nnoremap <leader>td :call ToggleWarnings()<CR>

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
let g:airline#extensions#tabline#enabled = 0

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

nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fb :Buffers<CR>

nnoremap <leader>e :Lexplore<CR>

nnoremap <leader>d "_d
vnoremap <leader>d "_d

nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>

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
colorscheme catppuccin_mocha

" --- Apply Custom Highlights AFTER Theme ---
highlight LspErrorHighlight gui=undercurl guisp=Red cterm=underline ctermfg=Red
highlight LspWarningHighlight gui=undercurl guisp=Yellow cterm=underline ctermfg=Yellow

highlight Pmenu guibg=#181825 guifg=#cdd6f4 ctermbg=235 ctermfg=253
highlight PmenuSel guibg=#313244 guifg=#cdd6f4 gui=bold ctermbg=237 ctermfg=253 cterm=bold
highlight PmenuSbar guibg=#1e1e2e ctermbg=234
highlight PmenuThumb guibg=#585b70 ctermbg=240

highlight Conceal guifg=#45475a ctermfg=238 guibg=NONE ctermbg=NONE

highlight GitGutterAdd    guifg=#a6e3a1 ctermfg=Green
highlight GitGutterChange guifg=#89b4fa ctermfg=Blue
highlight GitGutterDelete guifg=#f38ba8 ctermfg=Red
highlight GitGutterChangeDelete guifg=#f9e2af ctermfg=Yellow
