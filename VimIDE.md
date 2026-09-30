## IDE-like Vim

### Vim New Linux Machine Setup

```bash
sudo apt update

# - vim-gtk3: Gives the version of Vim compiled with '+clipboard'
# - fzf: The fuzzy finder binary
# - ripgrep: The backend for project-wide text searching (:Rg)
# - xclip: Tells Linux how to talk to the system clipboard
# - curl, git, unzip: Required for downloading plugins and LSPs
sudo apt install -y vim-gtk3 fzf ripgrep xclip curl git unzip

# Vim plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    [https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim](https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim)

# Grab the vimrc file and make the symlink
git clone [https://github.com/Sahil-Karanth/dotfiles.git](https://github.com/Sahil-Karanth/dotfiles.git) ~/dotfiles
ln -s ~/dotfiles/vimrc ~/.vimrc

# Opens Vim in the background, installs all your plugins, and closes it.
# Alternatively, just run `:PluginInstall` on first vim startup
vim -es -u ~/.vimrc -i NONE -c "PlugInstall" -c "qa"
```

### Keybindings
**Leader Key:** `<Space>`

#### LSP (Language Server Protocol)
*   `<Space> ld` : Go to **D**efinition
*   `<Space> lr` : Find **R**eferences (populates location list at bottom)
*   `<Space> lh` : **H**over (Show documentation/types)
*   `<Space> la` : Code **A**ction (Quick fixes, auto-imports)
*   `<Space> rn` : **R**e**n**ame symbol project-wide
*   `]g`         : Jump to the next error/warning in the file
*   `[g`         : Jump to the previous error/warning in the file
*   `<Space> le` : List all **e**rrors in the current document (opens bottom window)
*   *Note:* To read an error, just leave your cursor on the squiggly line for 0.3 seconds. The message will print at the bottom of the screen.

#### Navigation & FZF
*   `<Space> e`  : Toggle File Explorer (Netrw tree)
*   `<Space> ff` : Find **F**iles (FZF)
*   `<Space> fg` : Find via **G**rep / Ripgrep (Interactive project-wide search)
*   `<Space> fb` : Find **B**uffers (Search currently open files)
*   `s`          : Sneak (Leap to any 2 characters on screen)
*   `Ctrl-j`     : Move down inside FZF search results
*   `Ctrl-k`     : Move up inside FZF search results

#### Netrw (File Explorer) Navigation
*   `<CR>` (Enter): Expand or collapse a folder inline
*   `-` (Minus)   : Go up to the parent directory (makes parent the new root)
*   `gn`          : Zoom into a folder (makes the folder under your cursor the new root)
*   `u`           : Go back in directory history (undo your last `-` or `gn` jump)

#### Autocomplete (Insert Mode)
*   `<Tab>` or `<Ctrl-j>`   : Next autocomplete suggestion
*   `<Shift-Tab>` or `<Ctrl-k>`: Previous autocomplete suggestion
*   `<Enter>`               : Close autocomplete popup

#### Commenting & Registers (via Plugins)
*   `gcc`        : Toggle comment on current line (`vim-commentary`)
*   `gc`         : Toggle comment on visual selection or motion (`vim-commentary`)
*   `"` or `@`   : Open floating window showing all copied text/registers (`vim-peekaboo`)

#### Tab & Buffer Management
*   `<Space> 1-9`: Jump directly to tab number 1 through 9
*   `<Space> bd` : **B**uffer **d**elete (Safely close the current tab without closing your split/window)

#### Utilities
*   `<Space> d`  : Delete text to the "black hole" register (Normal & Visual mode - doesn't overwrite your clipboard)
*   `<Space> o`  : Insert blank line below without entering insert mode
*   `<Space> O`  : Insert blank line above without entering insert mode

### Find and Replace Workflows

#### Current File
*   **Find:** `/search_term` (forward) or `?search_term` (backward). Press `n` for next, `N` for previous.
    *   *Case Insensitive:* Add `\c` anywhere (e.g., `/search_term\c`).
*   **Find & Replace:** `:%s/old_text/new_text/gc`
    *   `%`: Entire file
    *   `g`: Global (all occurrences on a line)
    *   `c`: Confirm each change (y/n)
    *   *Case Insensitive Replace:* Add `i` at the end (e.g., `:%s/old/new/gic`).

#### Project-Wide
*   **Interactive Search:** Press `<Space> fg` to search the project dynamically using Ripgrep. (Types in lowercase are case-insensitive; adding a capital letter makes it case-sensitive).
*   **Project-Wide Find & Replace:** 
    1. Search the project using grep (powered by ripgrep via vimrc):
       `:grep "old_text"` (Use `:grep -i "old_text"` for case-insensitive).
    2. Open the results to verify (optional): 
       `:copen`
    3. Run the replace on all found files and save them:
       `:cfdo %s/old_text/new_text/gc | update`

### Vim Housekeeping Commands

```bash
:LspStatus                       # Check if LSP is running for current file
:LspInstallServer                # Auto-download LSP for current filetype
:LspUninstallServer server-name  # Remove a specific LSP
:PlugUpdate                      # Update all Vim plugins
:PlugClean                       # Remove unlisted plugins
```
