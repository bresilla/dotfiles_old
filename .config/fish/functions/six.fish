# Defined in - @ line 1
function six --description 'alias six nix-shell --command zsh support/shell.nix'
	nix-shell --command zsh support/shell.nix $argv;
end
