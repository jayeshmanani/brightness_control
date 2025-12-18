#!/bin/sh

STATE_FILE="$HOME/.screen_brightness"

# Auto detect first connected display
DISPLAY_NAME=$(xrandr | grep " connected" | awk '{print $1}' | head -n 1)

if [ -z "$DISPLAY_NAME" ]; then
    echo "Error: No active display found."
    exit 1
fi

# Initialize state file
if [ ! -f "$STATE_FILE" ]; then
    echo 1.0 > "$STATE_FILE"
fi

CURRENT=$(cat "$STATE_FILE")
CURRENT_PERCENT=$(echo "$CURRENT * 100" | bc | awk '{printf "%d\n", $1}')

INPUT="$1"

# Input validation for "up" / "down"
if [ "$INPUT" = "u" ] || [ "$INPUT" = "up" ]; then
    NEW_PERCENT=$(( CURRENT_PERCENT + 10 ))

elif [ "$INPUT" = "d" ] || [ "$INPUT" = "down" ]; then
    NEW_PERCENT=$(( CURRENT_PERCENT - 10 ))

# Check if input is an integer (POSIX way)
elif echo "$INPUT" | grep -Eq '^[0-9]+$'; then
    if [ "$INPUT" -lt 10 ] || [ "$INPUT" -gt 100 ]; then
        echo "Error: brightness must be between 10 and 100."
        exit 1
    fi
    NEW_PERCENT="$INPUT"

else
    echo "Invalid input."
    echo "Use: up | down | integer (10–100)"
    exit 1
fi

# Clamp values
if [ "$NEW_PERCENT" -lt 10 ]; then NEW_PERCENT=10; fi
if [ "$NEW_PERCENT" -gt 100 ]; then NEW_PERCENT=100; fi

BRIGHTNESS=$(echo "scale=2; $NEW_PERCENT / 100" | bc)

xrandr --output "$DISPLAY_NAME" --brightness "$BRIGHTNESS"

echo "$BRIGHTNESS" > "$STATE_FILE"

echo "Brightness set to $NEW_PERCENT% ($BRIGHTNESS)"
