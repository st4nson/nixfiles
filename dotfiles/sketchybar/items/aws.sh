#!/usr/bin/env bash

# Catppuccin Macchiato - Sapphire
SAPPHIRE=0xff7dc4e4

sketchybar --add item aws right \
	--set aws \
	update_freq=60 \
	icon="󰸏" \
	icon.color="$SAPPHIRE" \
	icon.padding_left=10 \
	icon.y_offset=1 \
	label="AWS" \
	label.padding_right=10 \
	label.color="$SAPPHIRE" \
	label.y_offset=1 \
	background.height=26 \
	background.corner_radius="$CORNER_RADIUS" \
	background.padding_right=5 \
	background.border_width="$BORDER_WIDTH" \
	background.border_color="$SAPPHIRE" \
	background.color="$BAR_COLOR" \
	background.drawing=on \
	popup.background.corner_radius=10 \
	popup.background.color="$BAR_COLOR" \
	popup.background.border_width=1 \
	popup.background.border_color="$SAPPHIRE" \
	script="$PLUGIN_DIR/aws.sh" \
	--subscribe aws mouse.entered mouse.exited mouse.exited.global

# Add popup items for each profile
for profile in "nmk-test" "nmk-prod" "nmk-prod-cn" "nmk-test-cn"; do
	sketchybar --add item "aws.${profile}" popup.aws \
		--set "aws.${profile}" \
		icon.drawing=off \
		label="${profile}: --" \
		label.padding_left=10 \
		label.padding_right=10
done
