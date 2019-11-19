# Defined in - @ line 1
function s --description 'alias s=shko -c --short && cd (cat ~/.config/shko/settings/chdir)'
	shko -c --short && cd (cat ~/.config/shko/settings/chdir) $argv;
end
