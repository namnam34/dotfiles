# dotfiles
bash -c "$(curl -L raw.githubusercontent.com/r-namnam/dotfiles/master/etc/install)"

## zplugin install
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"

## zsh autosuggestion color setting
vim ~/.zplugin/plugins/zsh-users---zsh-autosuggestions/zsh-autosuggestions.zsh

set SH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=248'

## fzf
git clone https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

## shell theme
https://github.com/tomislav/osx-terminal.app-colors-solarized
