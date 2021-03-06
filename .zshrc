# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/miniconda3/bin:/usr/local/bin:$PATH


# Path to your oh-my-zsh installation.
export ZSH=/Users/victor/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="amuse"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colored-man colorize github pip python)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='subl'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"


#
# Prompt
#
export cur_dir='${PWD/#$HOME/~}'
VENV_PROMPT=""

if [[ "$TERM" == "screen" ]]; then
        TERM_PROMPT="(screen) "
elif [[ "$TERM" == "screen.xterm-256color" ]]; then
        TERM_PROMPT="(screen) "
else
        TERM_PROMPT=""
fi

#Git
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%} on%{$reset_color%} git:%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

export PROMPT="%{$fg[blue]%}${TERM_PROMPT}%{$reset_color%}\
%{$fg[cyan]%}%n \
%{$fg[white]%}at \
%{$fg[green]%}%m \
%{$fg[white]%}in \
%{$fg[yellow]%}${cur_dir}%{$reset_color%}\
${git_info} \
%{$fg[white]%}[%*]:"


# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="subl ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

autoload zmv
alias zmv='noglob zmv -W'


#Fixes permisions
function fixdirperms(){
	OLDIFS=$IFS
	IFS=$'\n'

	# read all file name into an array
	fileArray=($(find "."))

	# restore IFS
	IFS=$OLDIFS

	# get length of an array
	tLen=${#fileArray[@]}

	for (( i =0; i<${tLen}; i++ )); do
		if [[ -d ${fileArray[$i]} ]]; then
			echo "${fileArray[$i]} is directory"
			chmod 755 ${fileArray[$i]}
		elif [[ -f ${fileArray[$i]} ]]; then
			echo "${fileArray[$i]} is file"
			chmod u=rwx,g=rx,o=rx ${fileArray[$i]}
		fi
	done
}
