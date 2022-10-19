# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new
fi

alias vim="nvim"
alias vi="nvim"
alias nv="nvim"
alias v="nvim"
alias tn="tmux neww"
alias goo="google"
alias status="git status"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#nohup sudo -b dockerd < /dev/null > ~/.docker/logs/startup.log 2>&1
LS_COLORS+=':ow=01;33'



################################
############################
## Gitbash aliases
#############################
################################

# Name of your git folder, relative to your home (~) directory - update to your own
gitDirName="git"

alias psh='powershell -File'

#############################
#############################
## SSH stuff (replace IPs as you see)
#############################
#############################
odi() {
	ssh -i ~/.ssh/Main.pem ubuntu@10.3.38.59
}

tend() {
	ssh -i ~/.ssh/Main.pem ubuntu@10.3.6.213
}

tsilo() {
	ssh -i ~/.ssh/Main.pem ubuntu@10.3.1.222
}

udemy() {
	ssh -i ~/.ssh/udemy.pem ec2-user@3.249.244.80
}

#fzf
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden'
fi

# Running Services Locally

#replace with whatever script you prefer to run or I can add these to repos

alias down='pwsh scripts/teardown.ps1'
alias up='pwsh scripts/setup-local.ps1'
alias db='dotnet build'
alias dt='dotnet test'
alias reup='down && db && up'

#line endings windows/unix fix thing
fixlines(){
	_sedclean $1
}

###################################
#  Git Methods
###################################

git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

#export PS1="${debian_chroot}\[\033[01;35m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[\033[00;36m\]\$(git_branch) \[\033[00m\]> "

# run from your branch, checks out latest master, then goes back to your branch and rebases on master
gitff(){
	branch_name=$(git symbolic-ref -q HEAD)
	branch_name=${branch_name##refs/heads/}
	branch_name=${branch_name:-HEAD}
	git checkout master &&
		git pull --rebase &&
		git checkout $branch_name &&
		git rebase master
	}

# Stash changes, checkout master and get latest, checkout branch number given, pops your changes
stashcheck(){
	if [ "$#" -eq 0 ]; then
		echo 'need a branch number'
	else
		git stash && git checkout master && git pull --rebase && git checkout POK-$1 && git stash pop
	fi
}

# Stash changes, checkout master and get latest, checkout branch number given, pops your changes
checkout(){
	if [ "$#" -eq 0 ]; then
		echo 'need a branch number'
	else
		git checkout master && git fetch && git checkout POK-$1
	fi
}

###################################
#  DK AWS Tools
###################################

a(){
	aws $@ --profile draftkingsdev
}

#needed for using git bash, as it's a non windows terminal (or something like that)
alias aws-cia='winpty aws-cia'

cia-update(){
dotnet tool update -g DraftKings.CIA --no-cache
}

cia-uninstall(){
dotnet tool uninstall -g DraftKings.CIA
}

cia-install(){
dotnet tool install -g DraftKings.CIA --no-cache
}

##################
# Git - Lots of handy stuff here if you want to dig in
##################

alias add='git add'
alias addall='git add -A'
alias amend='git commit --amend'
alias amendq='git commit --amend --no-edit'
alias branches='git branch -a'
alias c='clear;'
alias checkoutall='checkout .'
alias diff='git diff --word-diff'
alias log='git log'
alias save='git stash save'
alias uncommit='git reset --soft HEAD^'
alias gpush='git push origin HEAD:refs/for/master'
alias gdraft='git push origin HEAD:refs/drafts/master'

# To be run when the Release branch has moved ahead of HEAD/master, causing fast-forward errors in release/acceptance jobs on Jenkins
fastforward(){
	rebase &&
		git checkout Release &&
		git pull &&
		git checkout master &&
		git merge Release
	}

# Delete untracked (new) files and directories from git repo
clean(){
	git clean -fd
}

# Pull latest code from remote branch
rebase(){
	git pull --rebase
}

# Reset local repo to remote branch
reset(){
	git reset --hard origin/master
}

# Resets local repo to remote branch, then pull latest code
rrebase(){
	reset
	rebase
}

# Same as rrebase, I just keep typing this by accident
rreset(){
	rrebase
}

# Pushes code as a "draft". The review will not be visible to anyone watching the repo, and can only be seen by those added as reviewers.
draft(){
	git push
}

# Shows the files changed in the last commit
lastcommit(){
	git show --name-only HEAD
}

# Resets a file back to master when conflicts occur
unconflict(){
	git reset HEAD "$@"
	git checkout -- "$@"
}

# Prints out the authors of all commits within a repo
author(){
	if [ "$#" -eq 0 ]; then
		_author
	else
		_authorGrep | grep "$1"
	fi
}

# Prints a ranked list of the number of commiters per author
commiters(){
	_commiters | egrep -i "$1"
}

##################
# Docker
##################

export COMPOSE_HTTP_TIMEOUT=600
export dockerDiskSize=51200
export dockerMemory=8192

#alias dp='docker ps'
#alias drmc='docker rm $(docker ps -aq)'

#alias di='docker images'

#alias dc='docker-compose'

alias dm='docker-machine'
alias dmstart='dm start'
alias dmstop='dm stop'

dp(){
	docker ps --format "table {{.ID}} \t {{.Names}} \t {{.Status}} \t {{.RunningFor}}" -a "$@"
}

drmc(){
	docker rm $(docker ps -aq)
}

di(){
	docker images
}

dcu(){
	docker-compose -f docker-compose.yml up
}

dcd(){
	docker-compose -f docker-compose.yml down -v
}

drmi(){
	if [ "$#" -eq 0 ]; then
		docker rmi $(docker images -aq)
	else
		for var in "$@"
		do
			docker rmi $(docker images | grep $var | tr -s ' ' | cut -d ' ' -f1,2 --output-delimiter=':' | xargs)
		done
	fi
}

dh(){
	if [ "$#" -eq 0 ]; then
		echo "Usage: dh <containerId>"
	else
		docker inspect --format "{{json .State.Health }}" $1 | python -mjson.tool
	fi
}

dx(){
	if [ "$#" -eq 0 ]; then
		echo "Usage: dx <containerId> <command> (optional, defaults to bash)"
	else
		if [ "$#" -eq 2 ]; then
			winpty docker exec -ti $1 $2
		else
			winpty docker exec -ti $1 bash
		fi
	fi
}

# Stops and removes one or many running containers
dockerkill(){
	if [ "$#" -eq 0 ]; then
		numberOfContainers=$(docker ps -a -q | wc -l)

		if [ "$numberOfContainers" -eq 0 ]; then
			_print "No containers to kill"
		else
			_print "Killing $numberOfContainers containers"
			dockerkill $(docker ps -a -q)
		fi
	else
		docker stop "$@" &&
			docker rm "$@"
	fi
}

# May not be needed as we already wrap most of our docker stuff in scripts
# Runs docker-compose up, with the --build param to rebuild images on each execution
# Also fixes the line endings for the pre-start.sh script for the postgres images
dockerup(){
	dockerfix &&
		docker-compose up --build
	}

# Runs docker-compose down, and then runs a container prune command to clean up container data
dockerdown(){
	docker-compose down -v --remove-orphans &&
		dockerprune
	}

	dockerchange(){
		dockerdown &&
			cd "$1"/testsuite/integration/jee &&
			dockerup
		}

		dockerprune(){
			yes | docker container prune
		}

# Cleans all images using 'docker rmi' for images that have been untagged (are now tagged as '<none>')
dockercleannone(){
	noneImages=$(docker images -a | grep "<none>" | tr -s ' ' | cut -d ' ' -f 3)
	numberOfNoneImages=$(echo -n "${noneImages//[[:spaces]]/}" | wc -w)

	if [ "$numberOfNoneImages" -eq 0 ]; then
		_print "No '<none>' images to clean"
		kill -SIGINT $$
	fi

	docker rmi $noneImages
}


##################
# K8S
##################

#depending on how many k8s envs we use, it's nice to easily jump between them
alias kg='export KUBECONFIG=~/.kube/config'

k8ssec(){
	kubectl get secret --namespace $1 $2 -o jsonpath="{.data.password}" | base64 --decode
}

wink(){
	winpty kubectl "$@"
}

k(){
	kubectl "$@"
}

kc(){
	k --kubeconfig ~/.kube/$1 "${@:2}"
}

#mistyping kubectl all the time
kuebctl(){
	kubectl "$@"
}

kns(){
	kubectl get ns
}


kd(){
	if [ $# -eq 0 ] ; then
		echo "Usage: kd <namespace> <k8s_object> <object_name> "
	else
		kubectl describe -n "$@"
	fi
}

klogs(){
	if [ $# -lt 2 ];
	then echo "Usage: klogs <ns> <pod> (optional)-c <container>(optional)"
	fi
	kubectl logs -f -n "$@"
}

kx(){
	if [ $# -lt 2 ] ; then
		echo "Usage: kx <ns> <pod> <command:optional>"
	elif [ $# -eq 2 ]; then
		winpty kubectl exec -ti -n $1 $2 bash
	else
		winpty kubectl exec -ti -n "$@"
	fi
}

kpods(){
	if [ $# -eq 0 ] ; then
		echo "Usage: kpods <ns> <optional>"
	elif [ $# -eq 1 ] ; then
		kubectl get pods -n "$@"
	fi
}

##################
# Private methods (not to be used directly)
##################

# Function to handle execution errors, and prints input success/failure messages
_catcherror(){
	if [ $? -eq 0 ]; then
		_print "$1"
	else
		_print ">>> $2 <<<"
		kill -SIGINT $$
	fi
}

# Function to handle execution cancellation (CTRL+C) - prints static failure message
_catchcancel(){
	if [ ! $? -eq 0 ]; then
		_print ">>> Execution cancelled by user <<<"
		kill -SIGINT $$
	fi
}

# Removes Unix line endings from the file that's passed in, assuming the file exists
_sedclean(){
	if [ -f "$1" ]; then
		sed -i 's/\r$//' "$1"
	fi
}

# Prints the input string with a blank line above and below
_print(){
	printf "\n$@\n"
}

# Prints a ranked list of the number of commiters per author. Filters out CI/Jenkins users
_commiters(){
	git shortlog -s -n | egrep -v ENM_CI_Admin\|"CI Admin"\|Jenkins\|unknown\|AP_Parent\|self-service
}

# Greps the result of the _author call using egrep for case insensitivity
_authorGrep(){
	_author | egrep -i "$1" | xargs
}

# Horrendous one-liner from a past life which prints all authors in the repo, and number of files changed
_authorold(){
	git log --shortstat --pretty="%cE" | sed 's/\(.*\)@.*/\1/' | grep -v "^$" | awk 'BEGIN { line=""; } !/^ / { if (line=="" || !match(line, $0)) {line = $0 "," line }} /^ / { print line " # " $0; line=""}' | sort | sed -E 's/# //;s/ files? changed,//;s/([0-9]+) ([0-9]+ deletion)/\1 0 insertions\(+\), \2/;s/\(\+\)$/\(\+\), 0 deletions\(-\)/;s/insertions?\(\+\), //;s/ deletions?\(-\)//' | awk 'BEGIN {name=""; files=0; insertions=0; deletions=0;} {if ($1 != name && name != "") { print name ": " files " files changed, " insertions " insertions(+), " deletions " deletions(-), " insertions-deletions " net"; files=0; insertions=0; deletions=0; name=$1; } name=$1; files+=$2; insertions+=$3; deletions+=$4} END {print name " \t " files " files changed, " insertions " insertions(+), " deletions " deletions(-), " insertions-deletions " net";}'
}

_author(){
	git log --shortstat --pretty="%cE" | sed 's/\(.*\)@.*/\1/' | grep -v "^$" | awk 'BEGIN { line=""; } !/^ / { if (line=="" || !match(line, $0)) {line = $0 "," line }} /^ / { print line " # " $0; line=""}' | sort | sed -E 's/# //;s/ files? changed,//;s/([0-9]+) ([0-9]+ deletion)/\1 0 insertions\(+\), \2/;s/\(\+\)$/\(\+\), 0 deletions\(-\)/;s/insertions?\(\+\), //;s/ deletions?\(-\)//' | awk 'BEGIN {name=""; files=0; insertions=0; deletions=0;} {if ($1 != name && name != "") { print name "\t" files " files changed \t" insertions " insertions(+) \t" deletions " deletions(-) \t" insertions-deletions " net"; files=0; insertions=0; deletions=0; name=$1; } name=$1; files+=$2; insertions+=$3; deletions+=$4} END {print "\n" }'
}
alias nv='nvim'
alias n='nvim'

