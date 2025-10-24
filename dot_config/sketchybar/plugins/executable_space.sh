#!/bin/bash
# aspace_item.sh — highlight + app badges

SPACE_ID="${NAME#aspace.}"

# 1) Focused workspace (from AeroSpace event; fallback to query)
FOCUSED="${AEROSPACE_FOCUSED_WORKSPACE}"
if [ -z "$FOCUSED" ]; then
  FOCUSED="$(aerospace list-workspaces --focused 2>/dev/null)"
fi

# 2) Collect unique bundle IDs in this workspace
apps="$(aerospace list-windows --workspace "$SPACE_ID" --format "%{app-bundle-id}" 2>/dev/null | sort -u)"

# 3) Map bundle IDs -> Nerd Font glyphs (add more as you like)
icons=""
for app in $apps; do
  case "$app" in
    "com.google.Chrome")        icons+=" " ;;
    "org.mozilla.firefox")      icons+=" " ;;
    "com.apple.Safari")         icons+=" " ;;
    "com.apple.Terminal")       icons+=" " ;;
    "com.microsoft.VSCode"|"com.microsoft.VSCodeInsiders") icons+="󰨞 " ;;
    "com.apple.finder")         icons+="󰀶 " ;;
    "com.spotify.client")       icons+=" " ;;
    "app.zen-browser.zen")       icons+="󰇧 " ;;
    "net.imput.helium")       icons+="󰇧 " ;;
    "com.mitchellh.ghostty")       icons+=" " ;;
    "com.tinyspeck.slackmacgap")       icons+="󰒱 " ;;
    *)                          icons+=" " ;;  # fallback
  esac
done

# limit to 5 glyphs to avoid overflow; show +N if more
count=$(echo "$icons" | wc -w | tr -d ' ')
if [ "$count" -gt 5 ]; then
  icons="$(echo "$icons" | awk '{for(i=1;i<=5;i++) printf $i" "; print ""}') +$((count-5))"
fi

# no apps? keep label empty (so the cell is compact)
[ -z "$icons" ] && icons=""

# 4) Update the item:
#    - icon stays the workspace number (your highlight logic relies on this)
#    - label carries the variable-width app glyphs
#    - make sure label is drawn (so width expands)
if [ "$SPACE_ID" = "$FOCUSED" ]; then
  sketchybar --animate sin 0.55 0.0 1.0 \
    --set "$NAME" \
    icon="$SPACE_ID" \
    icon.color=0xff000000 \
    background.color=0xffffffff \
    label="$icons" \
    label.drawing=on \
    label.color=0xff000000 \
    background.border_color=0xff101010 \
    #icon.padding_left=24
    # label.padding_left=6 \
else
  sketchybar  --animate sin 0.55 0.0 1.0 \
    --set "$NAME" \
    icon="$SPACE_ID" \
    icon.color=0xffffffff \
    background.color=0xff000000  \
    background.border_color=0xff303030 \
    label="$icons" \
    label.drawing=on \
    label.color=0xffffffff \
    #icon.padding_let=24
    # label.padding_left=6 \
fi
