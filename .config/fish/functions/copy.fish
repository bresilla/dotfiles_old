# Defined in - @ line 1
function copy --description 'alias copy xclip -sel clip'
	xclip -sel clip $argv;
end
