function fish_prompt
  env FISH_VERSION=$FISH_VERSION PROMPTLINE_LAST_EXIT_CODE=$status bash ~/.config/promptline left $fish_bind_mode
end

function fish_right_prompt
  env FISH_VERSION=$FISH_VERSION PROMPTLINE_LAST_EXIT_CODE=$status bash ~/.config/promptline right $fish_bind_mode
end

fish_vi_key_bindings
