function fish_mode_prompt; end
function fish_greeting; end

function fish_prompt
    env FISH_VERSION=$FISH_VERSION PROMPTLINE_LAST_EXIT_CODE=$status bash ~/.config/promptline left $fish_bind_modea (__fish_git_prompt)
end
function fish_right_prompt
    env FISH_VERSION=$FISH_VERSION PROMPTLINE_LAST_EXIT_CODE=$status bash ~/.config/promptline right $fish_bind_mode (__fish_git_prompt)
end

set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_hide_untrackedfiles 1
set -g __fish_git_prompt_color_branch magenta
set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix ""
set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_dirtystate "✚"
set -g __fish_git_prompt_char_untrackedfiles "-"
set -g __fish_git_prompt_char_conflictedstate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"
set -g __fish_git_prompt_color_dirtystate blue
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
set -g __fish_git_prompt_color_cleanstate green
set -g __fish_prompt_normal (set_color normal)

function sh_aliases \
    --description 'import bash aliases to .fish function files.'
    for file in ~/.func/*
        for a in (cat $file  | grep "^alias")
            set aname (echo $a | sed 's/alias \(.*\)=\(\'\|\"\).*/\1/')
            set command (echo $a | sed 's/alias \(.*\)=\(\'\|\"\)\(.*\)\2/\3/')
            if test -f ~/.config/fish/functions2/$aname.fish
                echo "Overwriting alias $aname as $command"
            else
                echo "Creating alias $aname as $command"
            end
            alias $aname $command
            funcsave $aname
        end
    end
end

###DIRENV
# direnv hook fish | source
