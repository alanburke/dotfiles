 [[ $- == *i* ]]   &&   . ~/.git-conf
 [[ $- == *i* ]]   &&   . ~/.git-completion.bash
#use ctl keys to move forward and back in words
bind '"\eOC":forward-word'
bind '"\eOD":backward-word'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
