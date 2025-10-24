. ~/.config/fish/aliases.fish

if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_tmux_autostart true
    set -g fish_tmux_autostart_once false
    set -g fish_tmux_autoconnect false
    set -g fish_tmux_autoquit false
    set -g fish_tmux_autoname_session true
    set -g fish_tmux_fixterm true
    fastfetch	
end

# pnpm
set -gx PNPM_HOME "/Users/leandro/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
