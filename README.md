# dotfiles

Files for configuring a terminal environment and other various system settings. Largely centered around macOS, as well as other Unix-like systems. See [Github does dotfiles](https://dotfiles.github.io) for more info

## Work laptop (Kandji-managed Mac) quick path

Do **not** run `make` on a managed machine: it runs `brew bundle` on the upstream Brewfile, changes the login shell with `sudo`, installs yabai/skhd, and ends in `softwareupdate -aiR`. Apply only the shell and vim pieces:

```bash
gh repo clone bomatson/dotfiles ~/dotfiles        # scripts hardcode $HOME/dotfiles
brew install stow fzf fd fastfetch bash vim       # neofetch is archived in Homebrew; .bash_profile uses fastfetch
cd ~/dotfiles && stow bash vim
vim +PlugInstall +qall
# optional: make Homebrew bash the login shell
echo /opt/homebrew/bin/bash | sudo tee -a /etc/shells && chsh -s /opt/homebrew/bin/bash
```

macOS defaults and iTerm colors, without the `sudo` lines (and without `LSQuarantine`, which turns off the downloaded-app warning on a managed machine):

```bash
grep -vE '^\s*sudo |LSQuarantine' macos/defaults.sh | bash        # Safari lines fail unless the terminal has Full Disk Access; ignore
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'   # dark mode, live (defaults write alone needs a logout)
open macos/iterm/glacier-black-soft.itermcolors                 # imports the preset; pick it under iTerm > Settings > Profiles > Colors > Color Presets
# glacier-black-soft = upstream Glacier Black with off-white text and a lighter blue (ANSI 4/12) so paths and `ls` dirs read on black
# Quit iTerm before importing colors any other way; it rewrites its prefs on exit. With "separate light/dark colors" on, the preset lands in the Dark set only.
```

Skip `stow git`: `git/.gitconfig` still carries a placeholder email and would replace `~/.gitconfig` (work/personal `includeIf` setup lives there). Copy the aliases in by hand with `git config --global alias.<name> ...` instead.

`bash/dots/local` holds machine hooks (`~/.secrets.env`, asdf shims, gcloud, fzf keybindings) that pair with [bomatson/claude-config](https://github.com/bomatson/claude-config) `install.sh`.

## Installation

### `curl` method (easiest)

```bash
curl get.darryl.cx | sh && make -C dotfiles
```

Source code for the script is [here](https://github.com/darrylabbate/get-dotfiles/blob/master/src/dotfiles.sh). Checksums can be found in the [tag notes](https://github.com/darrylabbate/get-dotfiles/tags).

The `curl` method will install everything automatically. This is really useful for quickly setting up a new machine. 

### Manual method

You can also manually clone the repository and invoke the `Makefile`

```bash
git clone https://github.com/darrylabbate/dotfiles && make -C dotfiles
```

## Makefile

### `make`

* Installs [Homebrew](https://brew.sh) on macOS and installs all packages defined in the [Brewfile](macos/.Brewfile).
* Sets Homebrew-installed Bash (4.4+) as the default shell
* Updates macOS and configures preferred system defaults defined in [`/macos/defaults.sh`](macos/defaults.sh)
* Configures [yabai](https://github.com/koekeishiya/yabai) and [skhd](https://github.com/koekeishiya/skhd) to run at system startup
* Creates necessary symlinks via [GNU Stow](https://www.gnu.org/software/stow/)
* Runs [`/macos/duti/set.sh`](macos/duti/set.sh), which sets defaults handlers/programs for file extensions via [duti](http://duti.org).

### `make link`

* Symlinks only Bash and Vim configuration files to the home directory using `ln` commands. Useful for temporarily configuring a shared computer. Nothing new is installed to the machine, but files *may* be overwritten since the Makefile recipe passes the `-f` flag for every `ln` command.
* Run `make unlink` to remove these symlinks.

## How it Works

### Symlinks

All necessary symlinks ( [`.bash_profile`](bash/.bash_profile), [`.vimrc`](vim/.vimrc), among others) are managed with GNU Stow (installed with Homebrew). Files you wish to be symlinked to the home directory need to be placed in a folder within `~/dotfiles`. Using the `stow` command from the `~/dotfiles` directory will symlink the contents of the folder you choose (`/bash`, `/vim`, etc) to the grandparent directory, which is wherever the `/dotfiles` folder is contained.

Assuming you clone the dotfiles repository in your home directory, executing the commands:

```bash
$ cd dotfiles
$ stow bash
```
will symlink the contents of [`/bash`](bash) to the home directory.

You can use the `stow` command anytime you add a new file to a folder you wish to symlink directly to the home directory. This can all be done without Stow using the `ln -s` command, but I find GNU Stow with folder management to be cleaner and easier to maintain.

### Bash

`.bash_profile` automatically sources configurations defined in the files contained in the [`/bash/dots`](bash/dots) folder. Any changes to any existing file, as well as any new files in `/bash/dots/` will be loaded into the shell upon opening a new Terminal window or [reloading](https://github.com/darrylabbate/dotfiles/blob/db902b9ac0c466d09672f58549bff4107ba53861/dots/aliases#L4) the `.bash_profile`.

### Vim

- [Plug](https://github.com/junegunn/vim-plug)

### Window Management

- [yabai](https://github.com/koekeishiya/yabai)
- [skhd](https://github.com/koekeishiya/skhd)
