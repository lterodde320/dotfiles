#!/bin/bash

SPACE_ID=$(echo "$NAME" | cut -d'.' -f2)

# Get bundle IDs of apps in this workspace
apps=$(aerospace list-windows --workspace "$SPACE_ID" --format "%{app-bundle-id}" | sort -u)

icons=""

for app in $apps; do
  case "$app" in
    "com.apple.Safari") icons+=" " ;;
    "com.google.Chrome") icons+=" " ;;
    "org.mozilla.firefox") icons+=" " ;;
    "com.apple.Terminal") icons+=" " ;;
    "com.microsoft.VSCode") icons+=" " ;;
    *) icons+=" " ;;
  esac
done

if [ -z "$icons" ]; then
  # No apps in this workspace → fall back to number
  icons="$SPACE_ID"
fi

sketchybar --set "$NAME" icon="$icons"

