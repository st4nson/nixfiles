#!/bin/sh

# AWS Token Expiry Monitor for Sketchybar
# Shows status of all AWS profiles as emojis: 🔒 (>30m), ⏳ (10-30m), 🔥 (<10m/expired)
# Order: nmk-test, nmk-prod, nmk-prod-cn, nmk-test-cn

# $NAME is set by sketchybar when invoking the script; fallback for manual testing
NAME="${NAME:-aws}"

CREDENTIALS_FILE="$HOME/.aws/credentials"

# Color thresholds (in seconds)
THRESHOLD_WARN=1800 # 30 minutes - switch to yellow
THRESHOLD_CRIT=600  # 10 minutes - switch to red

# Colors - Catppuccin Macchiato
GREEN=0xffa6da95   # Green
YELLOW=0xffeed49f  # Yellow
RED=0xffed8796     # Red
COMMENT=0xff6e738d # Overlay1 (muted)

# Handle mouse events for popup
case "$SENDER" in
mouse.entered)
	sketchybar --set "$NAME" popup.drawing=on
	exit 0
	;;
mouse.exited | mouse.exited.global)
	sketchybar --set "$NAME" popup.drawing=off
	exit 0
	;;
esac

# Check if credentials file exists
if [ ! -f "$CREDENTIALS_FILE" ]; then
	sketchybar --set "$NAME" label="N/A" icon.color="$COMMENT" label.color="$COMMENT"
	exit 0
fi

# Get current timestamp
NOW=$(date +%s)

# Initialize status for each profile (POSIX-compatible)
# Display order: nmk-test, nmk-prod, nmk-prod-cn, nmk-test-cn
STATUS_nmk_test="⚫"
STATUS_nmk_prod="⚫"
STATUS_nmk_prod_cn="⚫"
STATUS_nmk_test_cn="⚫"

# Verbose labels for popup
VERBOSE_nmk_test="not found"
VERBOSE_nmk_prod="not found"
VERBOSE_nmk_prod_cn="not found"
VERBOSE_nmk_test_cn="not found"

# Colors for each profile's popup item
COLOR_nmk_test="$COMMENT"
COLOR_nmk_prod="$COMMENT"
COLOR_nmk_prod_cn="$COMMENT"
COLOR_nmk_test_cn="$COMMENT"

# Track worst status for border color
WORST_DIFF=""

# Get status emoji based on time diff
get_emoji() {
	diff=$1
	if [ "$diff" -le 0 ]; then
		echo "🔥"
	elif [ "$diff" -lt "$THRESHOLD_CRIT" ]; then
		echo "🔥"
	elif [ "$diff" -lt "$THRESHOLD_WARN" ]; then
		echo "⏳"
	else
		echo "🔒"
	fi
}

# Get color based on time diff
get_color() {
	diff=$1
	if [ "$diff" -le 0 ]; then
		echo "$RED"
	elif [ "$diff" -lt "$THRESHOLD_CRIT" ]; then
		echo "$RED"
	elif [ "$diff" -lt "$THRESHOLD_WARN" ]; then
		echo "$YELLOW"
	else
		echo "$GREEN"
	fi
}

# Format time remaining as human-readable string
format_time() {
	diff=$1
	if [ "$diff" -le 0 ]; then
		abs_diff=$((-diff))
		if [ "$abs_diff" -lt 3600 ]; then
			mins=$((abs_diff / 60))
			echo "EXPIRED ${mins}m ago"
		elif [ "$abs_diff" -lt 86400 ]; then
			hours=$((abs_diff / 3600))
			echo "EXPIRED ${hours}h ago"
		else
			days=$((abs_diff / 86400))
			echo "EXPIRED ${days}d ago"
		fi
	elif [ "$diff" -lt 60 ]; then
		echo "<1m left"
	elif [ "$diff" -lt 3600 ]; then
		mins=$((diff / 60))
		echo "${mins}m left"
	elif [ "$diff" -lt 86400 ]; then
		hours=$((diff / 3600))
		mins=$(((diff % 3600) / 60))
		if [ "$mins" -gt 0 ]; then
			echo "${hours}h ${mins}m left"
		else
			echo "${hours}h left"
		fi
	else
		days=$((diff / 86400))
		hours=$(((diff % 86400) / 3600))
		echo "${days}d ${hours}h left"
	fi
}

CURRENT_PROFILE=""
while IFS= read -r line; do
	# Match profile header [profile-name]
	case "$line" in
	\[*\])
		CURRENT_PROFILE=$(echo "$line" | sed 's/\[\(.*\)\]/\1/')
		;;
	x_security_token_expires*)
		# Extract the timestamp value
		EXPIRY_STR=$(echo "$line" | sed 's/x_security_token_expires[[:space:]]*=[[:space:]]*//')

		# Remove colon from timezone (+01:00 -> +0100) for macOS date compatibility
		EXPIRY_STR=$(echo "$EXPIRY_STR" | sed 's/:\([0-9][0-9]\)$/\1/')

		# Parse ISO 8601 timestamp to epoch
		EXPIRY_EPOCH=$(date -j -f "%Y-%m-%dT%H:%M:%S%z" "$EXPIRY_STR" +%s 2>/dev/null)

		if [ -n "$EXPIRY_EPOCH" ]; then
			DIFF=$((EXPIRY_EPOCH - NOW))
			EMOJI=$(get_emoji "$DIFF")
			VERBOSE=$(format_time "$DIFF")
			PROFILE_COLOR=$(get_color "$DIFF")

			# Store status for each profile
			case "$CURRENT_PROFILE" in
			nmk-test)
				STATUS_nmk_test="$EMOJI"
				VERBOSE_nmk_test="$VERBOSE"
				COLOR_nmk_test="$PROFILE_COLOR"
				;;
			nmk-prod)
				STATUS_nmk_prod="$EMOJI"
				VERBOSE_nmk_prod="$VERBOSE"
				COLOR_nmk_prod="$PROFILE_COLOR"
				;;
			nmk-prod-cn)
				STATUS_nmk_prod_cn="$EMOJI"
				VERBOSE_nmk_prod_cn="$VERBOSE"
				COLOR_nmk_prod_cn="$PROFILE_COLOR"
				;;
			nmk-test-cn)
				STATUS_nmk_test_cn="$EMOJI"
				VERBOSE_nmk_test_cn="$VERBOSE"
				COLOR_nmk_test_cn="$PROFILE_COLOR"
				;;
			esac

			# Track worst status for border color
			if [ -z "$WORST_DIFF" ] || [ "$DIFF" -lt "$WORST_DIFF" ]; then
				WORST_DIFF="$DIFF"
			fi
		fi
		;;
	esac
done <"$CREDENTIALS_FILE"

# Build label in fixed order: (test, prod, prod-cn, test-cn)
LABEL="🌍:${STATUS_nmk_test}${STATUS_nmk_prod}|🇨🇳:${STATUS_nmk_prod_cn}${STATUS_nmk_test_cn}"

# Determine border color based on worst status
if [ -z "$WORST_DIFF" ]; then
	COLOR="$COMMENT"
elif [ "$WORST_DIFF" -le 0 ]; then
	COLOR="$RED"
elif [ "$WORST_DIFF" -lt "$THRESHOLD_CRIT" ]; then
	COLOR="$RED"
elif [ "$WORST_DIFF" -lt "$THRESHOLD_WARN" ]; then
	COLOR="$YELLOW"
else
	COLOR="$GREEN"
fi

# Update main item
sketchybar --set "$NAME" label="$LABEL" icon.color="$COLOR" label.color="$COLOR" background.border_color="$COLOR"

# Update popup items with verbose info and color (silently ignore if items don't exist yet)
sketchybar --set aws.nmk-test label="nmk-test: $VERBOSE_nmk_test" label.color="$COLOR_nmk_test" 2>/dev/null
sketchybar --set aws.nmk-prod label="nmk-prod: $VERBOSE_nmk_prod" label.color="$COLOR_nmk_prod" 2>/dev/null
sketchybar --set aws.nmk-prod-cn label="nmk-prod-cn: $VERBOSE_nmk_prod_cn" label.color="$COLOR_nmk_prod_cn" 2>/dev/null
sketchybar --set aws.nmk-test-cn label="nmk-test-cn: $VERBOSE_nmk_test_cn" label.color="$COLOR_nmk_test_cn" 2>/dev/null
