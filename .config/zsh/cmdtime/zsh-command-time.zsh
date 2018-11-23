function preexec() {
  timer=${timer:-$SECONDS}
}

function precmd() {
  if [ $timer ]; then
    export timer_show=$(($SECONDS - $timer))
    unset timer
  fi
}
