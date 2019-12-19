# Defined in - @ line 1
function up --description 'alias up sudo -S systemctl'
	sudo -S systemctl $argv;
end
