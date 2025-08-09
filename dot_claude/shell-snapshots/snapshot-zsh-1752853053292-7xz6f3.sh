# Snapshot file
# Unset all aliases to avoid conflicts with functions
unalias -a 2>/dev/null || true
# Functions
add-zsh-hook () {
	emulate -L zsh
	local -a hooktypes
	hooktypes=(chpwd precmd preexec periodic zshaddhistory zshexit zsh_directory_name) 
	local usage="Usage: add-zsh-hook hook function\nValid hooks are:\n  $hooktypes" 
	local opt
	local -a autoopts
	integer del list help
	while getopts "dDhLUzk" opt
	do
		case $opt in
			(d) del=1  ;;
			(D) del=2  ;;
			(h) help=1  ;;
			(L) list=1  ;;
			([Uzk]) autoopts+=(-$opt)  ;;
			(*) return 1 ;;
		esac
	done
	shift $(( OPTIND - 1 ))
	if (( list ))
	then
		typeset -mp "(${1:-${(@j:|:)hooktypes}})_functions"
		return $?
	elif (( help || $# != 2 || ${hooktypes[(I)$1]} == 0 ))
	then
		print -u$(( 2 - help )) $usage
		return $(( 1 - help ))
	fi
	local hook="${1}_functions" 
	local fn="$2" 
	if (( del ))
	then
		if (( ${(P)+hook} ))
		then
			if (( del == 2 ))
			then
				set -A $hook ${(P)hook:#${~fn}}
			else
				set -A $hook ${(P)hook:#$fn}
			fi
			if (( ! ${(P)#hook} ))
			then
				unset $hook
			fi
		fi
	else
		if (( ${(P)+hook} ))
		then
			if (( ${${(P)hook}[(I)$fn]} == 0 ))
			then
				typeset -ga $hook
				set -A $hook ${(P)hook} $fn
			fi
		else
			typeset -ga $hook
			set -A $hook $fn
		fi
		autoload $autoopts -- $fn
	fi
}
is-at-least () {
	emulate -L zsh
	local IFS=".-" min_cnt=0 ver_cnt=0 part min_ver version order 
	min_ver=(${=1}) 
	version=(${=2:-$ZSH_VERSION} 0) 
	while (( $min_cnt <= ${#min_ver} ))
	do
		while [[ "$part" != <-> ]]
		do
			(( ++ver_cnt > ${#version} )) && return 0
			if [[ ${version[ver_cnt]} = *[0-9][^0-9]* ]]
			then
				order=(${version[ver_cnt]} ${min_ver[ver_cnt]}) 
				if [[ ${version[ver_cnt]} = <->* ]]
				then
					[[ $order != ${${(On)order}} ]] && return 1
				else
					[[ $order != ${${(O)order}} ]] && return 1
				fi
				[[ $order[1] != $order[2] ]] && return 0
			fi
			part=${version[ver_cnt]##*[^0-9]} 
		done
		while true
		do
			(( ++min_cnt > ${#min_ver} )) && return 0
			[[ ${min_ver[min_cnt]} = <-> ]] && break
		done
		(( part > min_ver[min_cnt] )) && return 0
		(( part < min_ver[min_cnt] )) && return 1
		part='' 
	done
}
# Shell Options
setopt extendedhistory
setopt nohashdirs
setopt histignorealldups
setopt histignoredups
setopt histignorespace
setopt histnostore
setopt histreduceblanks
setopt histsavenodups
setopt histverify
setopt incappendhistory
setopt login
setopt sharehistory
# Aliases
alias -- gia='git add --all'
alias -- gic='git commit -m "rev"'
alias -- gipl='git pull origin main'
alias -- gips='git push origin main'
alias -- gogo='cd ~/dev/intro_to_go'
alias -- obs='cd ~/Documents/obsidian/'
alias -- run-help=man
alias -- tasks='cd ~/dev/tasks'
alias -- which-command=whence
alias -- yt-flac='yt-dlp -x --audio-format flac -o "%(title)s.f%(format_id)s.%(ext)s"'
alias -- yt-mp3='yt-dlp -f "bestaudio[ext=m4a]/best[ext=mp4]/best" -x --audio-format mp3 -o "%(title)s.f%(format_id)s.%(ext)s"'
alias -- yt-mp4='yt-dlp -f "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]"  -o "%(title)s.f%(format_id)s.%(ext)s"'
alias -- yt-webm=' yt-dlp -f "bv+ba/b"'
# Check for rg availability
if ! command -v rg >/dev/null 2>&1; then
  alias rg='/opt/homebrew/lib/node_modules/@anthropic-ai/claude-code/vendor/ripgrep/arm64-darwin/rg'
fi
export PATH=/Users/argon/.cargo/bin\:/opt/homebrew/opt/curl/bin\:/opt/homebrew/bin\:/opt/homebrew/sbin\:/usr/local/bin\:/System/Cryptexes/App/usr/bin\:/usr/bin\:/bin\:/usr/sbin\:/sbin\:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin\:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin\:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin\:/Library/Apple/usr/bin\:/usr/local/go/bin\:/Applications/Ghostty.app/Contents/MacOS
