# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.gitsave/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set up the environment
XDG_CONFIG_HOME=$HOME/.gitsave/.config
ZSH_COMPDUMP=$ZDOTDIR/.zcompdump-$HOST
HISTFILE=$ZDOTDIR/.zsh_history

# Source local bins
[[ -d "$HOME/bin" ]] && path+=(~'/bin')
[[ -d "$HOME/.local/bin" ]] && path+=(~'/.local/bin')

# Clone dotfiles if necessary.
[[ -d $HOME/.gitsave ]] || git clone https://github.com/richukuttan/dotfiles ~/.gitsave

# Zsh options
setopt EXTENDED_GLOB             # Adds features like ^ for inverting a search pattern. Treat the '#', '~' and '^' characters as part of patterns for filename generation, etc. (An initial unquoted '~' always produces named directory expansion.)
# setopt GLOB_DOTS                 # The '.' at the start of a filename becomes a search pattern. So ls .config also lists 

# History settings
HISTSIZE=100000
SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
# setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_REDUCE_BLANKS        # 
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_VERIFY               # Verify before running historical command

# Autoload functions you might want to use with antidote
ZFUNCDIR=${ZFUNCDIR:-$ZDOTDIR/functions}
if [ -d ZFUNCDIR ]; then
    fpath=($ZFUNCDIR $fpath)
    autoload -Uz $fpath[1]/*(.:t)
fi

# Source zstyles you might use with antidote.
[[ -e ${ZDOTDIR:-~}/.zstyles ]] && source ${ZDOTDIR:-~}/.zstyles

source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load

zstyle ':completion:*' menu select

# To customize prompt, run `p10k configure` or edit ~/.gitsave/zsh/.p10k.zsh.
[[ ! -f ~/.gitsave/zsh/.p10k.zsh ]] || source ~/.gitsave/zsh/.p10k.zsh

# Set up the prompt
# autoload -Uz promptinit
# promptinit
# prompt adam1

# setopt histignorealldups sharehistory

# # Use emacs keybindings even if our EDITOR is set to vi
# bindkey -e

# # Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
# HISTSIZE=1000
# SAVEHIST=1000
# HISTFILE=~/.zsh_history

# # Use modern completion system
# autoload -Uz compinit
# compinit

# zstyle ':completion:*' auto-description 'specify: %d'
# zstyle ':completion:*' completer _expand _complete _correct _approximate
# zstyle ':completion:*' format 'Completing %d'
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*' menu select=2
# eval "$(dircolors -b)"
# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
# zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
# zstyle ':completion:*' menu select=long
# zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# zstyle ':completion:*' use-compctl false
# zstyle ':completion:*' verbose true

# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
# zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
