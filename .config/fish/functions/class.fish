# Defined in - @ line 1
function class --description alias\ class\ xprop\ \|awk\ \'/WM_CLASS/\{print\ \$4\}\'
	xprop |awk '/WM_CLASS/{print $4}' $argv;
end
