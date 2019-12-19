# Defined in /home/bresilla/.config/fish/functions/s.fish @ line 2
function s --description 'alias s=shko -c --short && cd (cat ~/.config/shko/settings/chdir)'
	shko -c --short && cd (cat ~/.config/shko/settings/chdir) $argv;
end
