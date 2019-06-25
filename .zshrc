### Added by Zplugin's installer
source '/Users/rnamba/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

###################
# FZF #
###################
# based one Gotham color
# fg      : ファイル名など、一番多く出る部分
# hl      : 謎
# fg+     : 現在カーソルがあたっていて、queryにhitしていない部分
# hl+     : 現在カーソルがあたっていて、queryにhitしている部分
# info    : {現在ヒットしている数}/{全体の数} を表示する部分
# prompt  : 舌でqueryを受け付ける矢印部分
# spinner : ファイルが多い時に回ってくれる線
# pointer : 選択中のカーソルにあたる矢印部分
# marker  : 複数選択したときのやつ
#export FZF_DEFAULT_OPTS='
#--color fg:7,hl:9,fg+:14,hl+:3
#--color info:2,prompt:11,spinner:2,pointer:9,marker:3
#'
#

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
# export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_TMUX=0

# for go
export GOPATH="${HOME}/go"
export PATH="$PATH:${HOME}/go/bin"

# mysql
PATH=/usr/local/mysql/bin:$PATH


# alias
alias lst='ls -lt -G'
alias l='ls -t -G'
alias la='ls -a -G'
alias ll='ls -l -G'

# key bind
bindkey -v
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

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

# go plugin pmy
source "${GOPATH:-${HOME}/go}/src/github.com/relastle/pmy/shell/pmy.zsh"

fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

fbrm() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}
