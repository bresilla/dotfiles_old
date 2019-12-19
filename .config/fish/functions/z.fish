# Defined in - @ line 1
function z --description 'alias z sudo ncdu --color=dark --exclude /home/bresilla/DATA'
	sudo ncdu --color=dark --exclude /home/bresilla/DATA $argv;
end
