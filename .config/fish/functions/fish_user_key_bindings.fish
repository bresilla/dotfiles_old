function fish_user_key_bindings
    fzf_key_bindings
    ### fzy ###
    bind \cr 'fzy_select_history (commandline -b)'
    bind \cf 'fzy_select_directory'
    ### fzy ###
end
