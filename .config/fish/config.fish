bind \e\[1\~ beginning-of-line
bind \e\[4\~ end-of-line

alias octave="octave -q"
alias gdb="gdb -q"
alias bc="bc -lq"
alias gcc="gcc -Wall -Wextra"
alias grep="grep --color"
alias egrep="egrep --color"
alias hd="hexdump -C"

set BROWSER google-chrome
set -e fish_greeting

function fish_prompt -d "Write out the prompt"
	and printf '%s%s%s> ' (set_color green) (prompt_pwd) (set_color normal)
	or  printf '%s%s%s> ' (set_color red) (prompt_pwd) (set_color normal)
end

function prefix
	set -xg WINEPREFIX "$HOME/.local/share/wineprefixes/$argv[1]"
end

function goc
	cd $WINEPREFIX/drive_c
end

function lsp
	ls $HOME/.local/share/wineprefixes
end
