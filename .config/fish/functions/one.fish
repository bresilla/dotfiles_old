# Defined in - @ line 1
function one --description 'alias one nix-shell --command zsh'
	nix-shell --command zsh $argv;
end
