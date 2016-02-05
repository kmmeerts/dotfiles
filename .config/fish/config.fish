# Why are GNU programs so damn loud?
alias octave="octave -q"
alias gdb="gdb -q"
alias bc="bc -lq"
alias gcc="gcc -Wall -Wextra"
alias hd="hexdump -C"

set -e fish_greeting
function fish_greeting -d "Greet the user"
	test -z (git --git-dir=$HOME/.git --work-tree=$HOME status --porcelain)
	or echo "dotfiles git repository needs updating"
end

function fish_prompt -d "Write out the prompt"
	and printf '%s%s%s> ' (set_color green) (prompt_pwd) (set_color normal)
	or  printf '%s%s%s> ' (set_color red) (prompt_pwd) (set_color normal)
end
