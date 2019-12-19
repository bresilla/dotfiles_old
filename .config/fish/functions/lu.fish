# Defined in - @ line 1
function lu --description 'alias lu dutree -d1 --usage -x .git -x .direnv'
	dutree -d1 --usage -x .git -x .direnv $argv;
end
