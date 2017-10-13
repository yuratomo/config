export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:~/.local/bin:~/Library/Python/2.7/bin
function _update_ps1() {
    PS1="$(powerline-shell $?)"
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
