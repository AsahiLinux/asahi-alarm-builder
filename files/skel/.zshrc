# few terminal keybinds
bindkey -e

typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if [[ -n ${terminfo[smkx]} ]] && [[ -n ${terminfo[rmkx]} ]]; then
    function zle-line-init () {
        echoti smkx
    }
    function zle-line-finish () {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish  
fi

zle -N fake-enter; bindkey "^X^H" fake-enter

# colors
autoload -U colors
colors

# aliases
alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias rm='rm'
alias mkdir='nocorrect mkdir'

alias ls="ls --color=auto"
alias ll="ls --color -l"
alias la="ls --color -la"
alias lt="ls --sort=time"
alias lat="ls --color -la --sort=time"

alias rh='fc -R'

autoload run-help

# zsh parameters
typeset -U path

#cdpath=(. ~)
DIRSTACKSIZE=60

# Autoload zsh functions.
fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)

fignore=(\~)

LISTMAX=0
LOGCHECK=60
HISTSIZE=20000
HISTFILE=~/.zsh_history
MAILCHECK=1
READNULLCMD=less
REPORTTIME=15
SAVEHIST=30000000
TIMEFMT='%J  %*U user %*S system %P cpu (%*E wasted time).'
watch=(all)
WATCHFMT='%n %a %l from %m at %t.'
WORDCHARS="${WORDCHARS:s#/#}"

# zsh options
setopt \
  auto_cd \
  auto_name_dirs \
  auto_pushd \
  auto_resume \
  no_beep \
  cdable_vars \
  csh_null_glob \
  correct \
  correct_all \
  extended_glob \
  extended_history \
  no_glob_dots \
  hist_allow_clobber \
  hist_find_no_dups \
  no_hist_ignore_all_dups \
  hist_ignore_dups \
  hist_reduce_blanks \
  no_hist_save_no_dups \
  inc_append_history \
  no_list_ambiguous \
  no_list_beep \
  long_list_jobs \
  magic_equal_subst \
  no_notify \
  prompt_subst \
  pushd_minus \
  pushd_silent \
  pushd_to_home \
  rc_quotes \
  no_share_history \
  shwordsplit \
  transient_rprompt \
  hist_ignore_space \
  no_equals \

# modules
autoload -U url-quote-magic bracketed-paste-magic
zle -N self-insert url-quote-magic
zle -N bracketed-paste bracketed-paste-magic

# Enable auto-execution of functions.
unset preexec_functions
unset precmd_functions
unset chpwd_functions
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# Terminal title
if [[ "$TERM" == xterm* ]] ; then
  preexec_functions+='preexec_term_title'
  precmd_functions+='precmd_term_title'
fi

# prompt
if [[ "$USER" == "root" ]] ; then
	PROMPT=$'%B%F{red}%n%b%F{default}@%B%F{cyan}%m%b%F{default}:%B%F{blue}%~%b%F{default}%F{default} %(?.-.%F{red}%?%F{default})%(!.%F{red}#%F{default}.%F{green}$%F{default}) '
else
	preexec_functions+='preexec_update_git_vars'
	precmd_functions+='precmd_update_git_vars'
	chpwd_functions+='chpwd_update_git_vars'
	PROMPT=$'%B%F{green}%n%b%F{default}@%B%F{cyan}%m%b%F{default}:%B%F{blue}%~%b%F{default}%F{yellow}$(prompt_git_info)%F{default} %(?.-.%F{red}%?%F{default})%(!.%F{red}#%F{default}.%F{green}$%F{default}) '
fi

# tab-completion
autoload -Uz compinit
[[ -d "${ZDOTDIR:-$HOME}/.zcompdumps" ]] || mkdir -m 0700 -p "${ZDOTDIR:-$HOME}/.zcompdumps"
compinit -i -d "${ZDOTDIR:-$HOME}/.zcompdumps/${HOST%%.*}-$ZSH_VERSION"

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select=1
zstyle ':completion::complete:cd::' tag-order '! users' -
zstyle ':completion::complete:-command-::' tag-order '! users' -

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
     /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':completion:*:descriptions' format "- %d -"
zstyle ':completion:*:corrections' format "- %d - (errors %e})"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
zstyle ':completion:*:kill:*:processes' command "ps x"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' special-dirs true

# misc functions
stfu() {
  "$@" &>/dev/null </dev/null
}

_comp_options=("${(@)_comp_options:#NO_ignoreclosebraces}")

[[ -e ~/.shfuncs ]] && source ~/.shfuncs

setopt notify

