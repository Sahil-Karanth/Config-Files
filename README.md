# Sahil's Dotfiles
Contains my dotfiles. Currently only my vimrc

## Vim New Linux Machine Setup

```bash
sudo apt update

# - vim-gtk3: Gives you the version of Vim compiled with '+clipboard'
# - fzf: The lightning-fast fuzzy finder binary
# - ripgrep: The backend for your project-wide text searching (:Rg)
# - xclip: Tells Linux how to talk to your system clipboard
# - curl, git, unzip: Required for downloading plugins and LSPs
sudo apt install -y vim-gtk3 fzf ripgrep xclip curl git unzip

# Vim plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Grab the vimrc file and make the symlink
git clone https://github.com/Sahil-Karanth/dotfiles.git ~/dotfiles
ln -s ~/dotfiles/vimrc ~/.vimrc

# Opens Vim in the background, installs all your plugins, and closes it.
# Alternatively, just run `:PluginInstall` on frist vim startup
vim -es -u ~/.vimrc -i NONE -c "PlugInstall" -c "qa"
```
## Vim Housekeeping Comamnds

```bash
:LspStatus
:LspInstallServer
:LspUninstallServer server-name
```
