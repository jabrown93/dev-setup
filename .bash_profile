alias ls='ls -G'
alias ll='ls -lG'
alias git_prune='/usr/local/bin/git-prune'

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion || {
    # if not found in /usr/local/etc, try the brew --prefix location
    [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ] && \
        . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
}

ssh-add -K -q

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH=$PATH:~/bin
export PATH=$PATH:~/Library/Python/2.7/bin
#export JAVA_HOME=$(/usr/libexec/java_home)
export JAVA_HOME=~/.jenv/versions/1.8
export PATH=/usr/local/openssl/bin:$PATH
export MANPATH=/usr/local/openssl/ssl/man:$MANPATH
export GOPATH=~/Riot/go
export PATH=$PATH:$GOPATH/bin
export PATH="/usr/local/sbin:$PATH"
export AWS_DEFAULT_REGION=us-west-2
export AWS_PROFILE=default
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
export PATH=$PATH:/usr/local/opt/go/libexec/bin
