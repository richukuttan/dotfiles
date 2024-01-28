# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.gitsave/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set up the environment
#XDG_CONFIG_HOME=$HOME/.gitsave/.config
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

# Restic
if (( $+commands[restic] ))
then
    if { [[ ! -f ~/.gitsave/zsh/.zsh-restic-autocomplete ]] || ((($(date +%s) - $(date -r ~/.gitsave/zsh/.zsh-restic-autocomplete +%s))/86400 > 50)) }
    then
        restic generate --zsh-completion ~/.gitsave/zsh/.zsh-restic-autocomplete --quiet
    fi
fi
source ~/.gitsave/zsh/.zsh-restic-autocomplete

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE='/home/hrishikesh/.local/bin/micromamba';
export MAMBA_ROOT_PREFIX='/home/hrishikesh/.config/micromamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<
