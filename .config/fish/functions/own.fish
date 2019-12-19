# Defined in - @ line 1
function own --description 'alias own sudo chown -R $USER'
	sudo chown -R $USER $argv;
end
