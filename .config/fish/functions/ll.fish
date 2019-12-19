# Defined in - @ line 1
function ll --description 'alias ll exa -liSHF --header --git --group-directories-first --tree -L1'
	exa -liSHF --header --git --group-directories-first --tree -L1 $argv;
end
