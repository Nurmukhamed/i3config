#!/bin/bash

i3-msg 'workspace 1; exec firefox; exec firefox' && sleep 5
i3-msg 'workspace 2; exec thunderbird' && sleep 5
i3-msg 'workspace 3; exec keepassx' && sleep 5
i3-msg 'workspace 4; exec /snap/bin/alacritty -e "$HOME/bin/zellij.sh";' && sleep 5
i3-msg 'workspace 5; exec code' && sleep 5
i3-msg 'workspace 6; exec kleopatra' && sleep 5
i3-msg 'workspace 1'
