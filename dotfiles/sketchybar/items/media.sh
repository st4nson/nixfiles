#!/usr/bin/env bash

COLOR="$ORANGE"

sketchybar --add item media q \
	--set media \
	scroll_texts=on \
	icon=󰎆 \
	icon.color="$COLOR" \
	icon.padding_left=10 \
	background.color="$BAR_COLOR" \
	background.height=26 \
	background.corner_radius="$CORNER_RADIUS" \
	background.border_width="$BORDER_WIDTH" \
	background.border_color="$COLOR" \
	background.padding_right=-5 \
	background.drawing=on \
	label.padding_right=10 \
	label.max_chars=20 \
	associated_display=active \
	updates=on \
	script="$PLUGIN_DIR/media.sh" \
	--subscribe media media_change
