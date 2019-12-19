# Defined in - @ line 1
function suspend --description 'alias suspend systemctl suspend'
	systemctl suspend $argv;
end
