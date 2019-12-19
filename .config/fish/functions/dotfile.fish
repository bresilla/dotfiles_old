# Defined in - @ line 1
function dotfile --description 'alias dotfile /usr/bin/git --git-dir=$HOME/Dots --work-tree=$HOME'
	/usr/bin/git --git-dir=$HOME/Dots --work-tree=$HOME $argv;
end
