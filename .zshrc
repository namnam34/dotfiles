### Added by Zplugin's installer
source '/Users/rnamba/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

# alias
alias lst='ls -lt -G'
alias l='ls -t -G'
alias la='ls -a -G'
alias ll='ls -l -G'

# key bind
bindkey -v

### plugin
# completion
zplugin ice wait"0" blockf
zplugin light zsh-users/zsh-completions

# Gitの補完と大量のエイリアスを定義するプラグイン
zplugin snippet 'OMZ::plugins/git/git.plugin.zsh'

# GitHub のレポジトリを管理するためのコマンドを定義するプラグイン
zplugin snippet 'OMZ::plugins/github/github.plugin.zsh'

# zshテーマ
zplugin ice pick"async.zsh" src"pure.zsh"; zplugin light sindresorhus/pure

autoload -Uz compinit
compinit
zplugin cdreplay -q

# zplugin: Plugins loaded after compinit
# コマンドをハイライトするプラグインを遅延ロードします。
zplugin ice wait'0' atload'_zsh_highlight'
zplugin light 'zdharma/fast-syntax-highlighting'
# コマンドをサジェストするプラグインを遅延ロードします。
zplugin ice wait'0' atload'_zsh_autosuggest_start'
zplugin light 'zsh-users/zsh-autosuggestions'
# Directory listings for zsh with git features
zplugin ice wait'0'
zplugin light 'supercrabtree/k'
