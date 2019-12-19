# Defined in - @ line 1
function mirror --description 'alias mirror sudo pacman-mirrors --fasttrack 5 && sudo pacman -Syyu'
	sudo pacman-mirrors --fasttrack 5 && sudo pacman -Syyu $argv;
end
