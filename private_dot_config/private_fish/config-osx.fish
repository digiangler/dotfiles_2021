#=============================================================================
# Title       : fish Shell
# Description : My Custom fish Shell Settings
# Author      : H.Y.
# LastUpdate  : 2021/05/16
# Since       : 2021/04/24
# Copyright   : © 2021 Digi-Angler
# License     : MIT License
# Version     : 1.0
#=============================================================================

#=============================================================================
# Personal Settings
#=============================================================================

if type -q exa

  set -Ux EXA_STANDARD_OPTIONS --long --all

  alias la "exa -l -a -G --icons"
  alias ll "exa -l -G --icons"
  alias lt "exa -l -T --icons"
  alias lla "exa -ll -a -G --icons"
  alias lll "exa -ll -G --icons"
  alias llt "exa -ll -T --icons"
  alias lx "exa -x --across --icons"
  alias exaf "exa --long --all --group-directories-first --bytes --header --group --git"
  alias exat "exa --long --all --group-directories-first --bytes --header --group --git --tree --ignore-glob .git"

end
