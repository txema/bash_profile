
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


# MacPorts Installer addition on 2013-07-18_at_12:38:19: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:~/txema/android-sdks:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

# Git branch in prompt.

#!/bin/bash
export PIP_RESPECT_VIRTUALENV=true
export WORKON_HOME=$HOME/.venv
export EDITOR='subl -w'
 
#source /usr/local/bin/virtualenvwrapper.sh
#source ~/.resty/resty
#source ~/.git-completion.bash
# Node.js needed vars
JOBS=2
 
##### CMD Aliases #####
alias ls="ls -G"
 
[[ -s "/Users/txema/.rvm/scripts/rvm" ]] && source "/Users/txema/.rvm/scripts/rvm"  # This loads RVM into a shell session.
 
        RED="\[\033[0;31m\]"
     YELLOW="\[\033[1;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[1;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
       CYAN="\[\033[0;36m\]"
     PURPLE="\[\033[0;35m\]"
 COLOR_NONE="\[\e[0m\]"
 NO_COLOUR="\[\033[0m\]"
 

# Return the prompt symbol to use, colorized based on the return value of the
# previous command.
function set_prompt_symbol () {
  if test $1 -eq 0 ; then
      PROMPT_SYMBOL="\$"
  else
      PROMPT_SYMBOL="${LIGHT_RED}\$${COLOR_NONE}"
  fi
}



# Determine active Python virtualenv details.
function set_virtualenv () {
  if test -z "$VIRTUAL_ENV" ; then
      PYTHON_VIRTUALENV=""
  else
      PYTHON_VIRTUALENV="${BLUE}[`basename \"$VIRTUAL_ENV\"`]${COLOR_NONE} "
  fi
}

 
function set_rvm_prompt {
  local gemset=$(echo $GEM_HOME | awk -F'@' '{print $2}')
  [ "$gemset" != "" ] && echo "(@$gemset) "
}
 
function parse_git_branch () {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/' 
}
 
# Detect whether the current directory is a git repository.
function is_git_repository {
  git branch > /dev/null 2>&1
}

# Determine the branch/state information for this git repository.
function set_git_branch {
  # Capture the output of the "git status" command.
  git_status="$(git status 2> /dev/null)"
 
  # Set color based on clean/staged/dirty.
  if [[ ${git_status} =~ "working directory clean" ]]; then
    state="${GREEN}"
  elif [[ ${git_status} =~ "Changes to be committed" ]]; then
    state="${YELLOW}"
  else
    state="${LIGHT_RED}"
  fi
 
  # Set arrow icon based on status against remote.
  remote_pattern="# Your branch is (.*) of"
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="↑"
    else
      remote="↓"
    fi
  else
    remote=""
  fi
  diverge_pattern="# Your branch and (.*) have diverged"
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="↕"
  fi
 
  # Get the name of the branch.
  branch_pattern="^# On branch ([^${IFS}]*)"
  #if [[ ${git_status} =~ ${branch_pattern} ]]; then
  #  branch=${BASH_REMATCH[1]}
  #fi
 	branch=git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/' 


  # Set the final branch string.
  BRANCH="${state}(${branch})${remote}${COLOR_NONE} "
}
 


# Set the full bash prompt.
function set_bash_prompt () {
  # Set the PROMPT_SYMBOL variable. We do this first so we don't lose the
  # return value of the last command.
  set_prompt_symbol $?
 
  # Set the PYTHON_VIRTUALENV variable.
  set_virtualenv
 
  # Set the BRANCH variable.
  if is_git_repository ; then
    set_git_branch
  else
    BRANCH=''
  fi
 
  # Set the bash prompt variable.

  PS1="
$CYAN\${PYTHON_VIRTUALENV}$PURPLE\$(set_rvm_prompt)$CYAN\u@\h ${LIGHT_GREEN}\w${PURPLE}\$(parse_git_branch)$NO_COLOUR\$
${PROMPT_SYMBOL} "
}
PROMPT_COMMAND=set_bash_prompt


#---------------------------- PATH --------------------------------------
export PATH=$PATH:/Users/txema/android-sdks/platform-tools
export PATH=$PATH:/Users/txema/android-sdks/tools
export PATH=$PATH:/Applications/Xcode.app/Contents/Developer/usr/bin
export PATH=$PATH:/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin   

# MacPorts Installer addition on 2014-07-01_at_09:36:32: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

