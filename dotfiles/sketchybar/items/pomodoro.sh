#!/usr/bin/env bash

sketchybar --add item timer right \
    --set timer \
        label="No Timer" \
        icon=🍅 \
        icon.color=0xFFF9E2AF \
        icon.padding_right=10 \
	    icon.padding_left=10 \
	    label.padding_right=10 \
	    background.height=26 \
	    background.corner_radius="$CORNER_RADIUS" \
	    background.padding_right=5 \
	    background.border_width="$BORDER_WIDTH" \
	    background.border_color="$RED" \
	    background.color="$BAR_COLOR" \
	    background.drawing=on \
		y_offset=0 \
        script="$PLUGIN_DIR/pomodoro.sh" \
        popup.background.corner_radius=10 \
        popup.background.color=0xFF1E1E2E \
        popup.background.border_width=1 \
        popup.background.border_color=0xFF45475A \
    --subscribe timer \
        mouse.clicked \
        mouse.entered \
        mouse.exited \
        mouse.exited.global

for timer in "5" "10" "25"; do
    sketchybar --add item "timer.${timer}" popup.timer \
        --set "timer.${timer}" \
            label="${timer} Minutes" \
            padding_left=16 \
            padding_right=16 \
            click_script="$PLUGIN_DIR/pomodoro.sh $((timer * 60)); sketchybar -m --set timer popup.drawing=off"
done

