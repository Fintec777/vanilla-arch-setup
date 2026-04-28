# ~/.zshrc

[[ $- != *i* ]] && return

export PATH="$HOME/.local/bin:$PATH"

# Better tools
command -v eza     &>/dev/null && alias ls='eza --icons --group-directories-first'
command -v eza     &>/dev/null && alias ll='eza -la --icons --group-directories-first --git'
command -v eza     &>/dev/null && alias tree='eza --tree --icons'
command -v bat     &>/dev/null && alias cat='bat --style=plain --paging=never'
command -v bat     &>/dev/null && alias less='bat --paging=always'
command -v lazygit &>/dev/null && alias lg='lazygit'

# fzf
[ -f /usr/share/fzf/key-bindings.zsh ]  && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ]    && source /usr/share/fzf/completion.zsh
export FZF_DEFAULT_OPTS="--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# zoxide
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"

# Starship prompt
command -v starship &>/dev/null && eval "$(starship init zsh)"
