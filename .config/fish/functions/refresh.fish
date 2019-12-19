# Defined in - @ line 1
function refresh --description 'alias refresh pkill -USR1 -x sxhkd && bash ~/.startup -r'
	pkill -USR1 -x sxhkd && bash ~/.startup -r $argv;
end
