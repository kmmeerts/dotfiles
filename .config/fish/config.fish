# Why are GNU programs so damn loud?
alias octave="octave -q"
alias gdb="gdb -q"
alias bc="bc -lq"
alias gcc="gcc -Wall -Wextra"
alias hd="hexdump -C"
alias yolo="yaourt -Syua"
alias temp="cat /sys/class/thermal/thermal_zone*/temp"

set -e fish_greeting
function fish_greeting -d "Greet the user"
	git --git-dir=$HOME/.git --work-tree=$HOME diff-index --quiet HEAD --
	or echo "dotfiles git repository needs updating"
end

# TODO __fish_git_prompt
function fish_prompt -d "Write out the prompt"
	and set -l pwd_color green
	or  set -l pwd_color red
	printf '%s%s%s> ' (set_color $pwd_color) (prompt_pwd) (set_color normal)
end
