# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/james/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="custom"
#ZSH_THEME="robbyrussell"

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
#COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

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

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias php="/usr/local/Cellar/php@7.1/7.1.29/bin/php"
alias sshshadowsocks="ssh root@144.202.35.37"
alias dld="aria2c -c -x 16 -s 16 -d ~/Downloads"
alias torrent="aria2c -d ~/Downloads/torrents --bt-metadata-only=true --bt-save-metadata=true --listen-port=6881"
alias findd="sudo find / -type d | grep -i"
alias search="grep -rn . -e "
alias emacs="emacs-26.1"
alias e="emacsclient -nw -s /tmp/emacs501/server"
alias ed="emacs --daemon"
alias mancpp="open ~/Downloads/reference/en/index.html"
alias movies="open ~/Movies/"
alias c="clear"
alias reload="source ~/.zshrc"
alias trash="open ~/.Trash"
alias catc="pygmentize -g"
alias pip3="python -m pip3"
alias python="/usr/local/Cellar/python@2/2.7.16/bin/python"
alias o="open"
alias java11="export JAVA_HOME=`/usr/libexec/java_home -v 11`; java -version"
alias java8="export JAVA_HOME=`/usr/libexec/java_home -v 1.8`; java -version"

function send2blog() {
    scp "$1" root@144.202.35.37:/var/www/html
}
function getfromsc() {
    scp -P 20022 jiacai17@bidaf.hh.se:$1 .
}

function rm() {
    mv $@ ~/.Trash/
}

function m() {
    music_by_keyword $1 &
}

BYel='\e[0;33m';
function music_by_keyword() {
    p=/Users/james/Music/cloud_music_link/
    keyword="." # default: play all the songs
    if [ -n "$1" ]; then # play songs by keyword
        keyword="$1"
    fi

    song_num="$(find $p -type f | grep mp3 | grep -i -e $keyword | wc -l)"
    while [ 1 ]
    do
        dummy1=$((RANDOM))
        timestamp=$(date +%s)
        dummy=$(($dummy1*$timestamp))
        song_index=$(($dummy%$song_num+1))

        song="$(find $p -type f | grep mp3 | grep -i -e $keyword | sed -n "$song_index"p)"
	name="`basename $song`"
        echo -e "${BYel}$name"
        afplay "$song"
        wait
    done
}

function n() { # next song
    pid="$(ps -ef | grep afplay | grep -v grep | head -1 | awk '{print $2}')"
    kill -INT $pid
}

function mm() { # terminate
    pid="$(ps -ef | grep afplay | grep -v grep | head -1 | awk '{print $2}')"
    ppid="$(ps -ef | grep afplay | grep -v grep | head -1 | awk '{print $3}')"
    kill -INT $ppid && kill -INT $pid
}

function ms() { # pause
    ppid="$(ps -ef | grep afplay | grep -v grep | head -1 | awk '{print $3}')"
    pid="$(ps -ef | grep afplay | grep -v grep | head -1 | awk '{print $2}')"
    kill -TSTP $pid && kill -TSTP $ppid
}

function mc() { # continue
    ppid="$(ps -ef | grep afplay | grep -v grep | head -1 | awk '{print $3}')"
    pid="$(ps -ef | grep afplay | grep -v grep | head -1 | awk '{print $2}')"
    kill -CONT $pid && kill -CONT $ppid
}

function md2html() {
    pandoc "$1" -f markdown -t html --standalone --mathjax -o "$1".html  && open "$1".html
}

function md2article() {
    pandoc template.yaml "$1" -f markdown --css ../style.css -t html --standalone --mathjax -o "$1".html  && open "$1".html
}

function md2pdf() {
    mdfile=`basename $1 .md`
    pandoc "$1" --listings -H ~/listings_setup.tex --pdf-engine=xelatex -o $mdfile.pdf && open $mdfile.pdf
}

function dot2png() {
    dotfile=`basename $1 .dot`
    dot "$1" -Tpng -Gdpi=200 -o $dotfile.png && open $dotfile.png
}


function latex2pdf() {
    pdf=$(echo "$1" |tr  '.' ' '|awk '{print $1}')
    pdfpostfix=".pdf"
    pdflatex "$1" && open "$pdf$pdfpostfix" || echo "$pdf$pdfpostfix"
}

function send2sc() {
    scp -r -P 20022 "$1" jiacai17@bidaf.hh.se:"$1"
}

function timer() {
    sleep `echo "$1" | bc` && say "$2"
}


export MUJOCO_PY_MJPRO_PATH=~/.mujoco/mjpro131;
export RACKET_PATH=/Applications/Racket\ v6.11/bin;
export PYTHONPATH="/usr/local/Cellar/python@2/2.7.15_1/bin/"
export PATH="/usr/local/Cellar/maven/3.6.2/bin/:$PATH"
export PIN_ROOT="/Users/james/fall-2018/pin-3.7-97619-g0d0c92f4f-clang-mac"
export PATH="/usr/local/Cellar/ruby/2.6.2/bin:$PATH"
export PATH="/usr/bin:$PATH:/usr/local/Cellar/gcc-arm-none-eabi-49/20150925/bin/:$RACKET_PATH:$PIN_ROOT:$PYTHONPATH"
# export PYTHONPATH="$PATH:/Users/james/Desktop/mlsh/gym:/Users/james/Desktop/mlsh/rl-algs:/Users/james/Research/Oger/"
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export PATH="/Users/james/PHP_malware/SAT/aspis:$PATH"
export PATH="/usr/local/Cellar/python/3.6.5_1/Frameworks/Python.framework/Versions/3.6/bin:$PATH"
export PATH="/Users/james/Library/Python/3.6/bin:$PATH"
export PATH="/Users/james/Library/Android/sdk/platform-tools:$PATH"
# eval $(/path/to/code-insight.phar _completion --generate-hook -p code-insight.phar)

export HOMEBREW_NO_AUTO_UPDATE=1
