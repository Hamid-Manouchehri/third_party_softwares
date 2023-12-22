#!/bin/bash

# Set the threshold_up for battery percentage
threshold_up=80
threshold_down=27

echo "battery-monitor script is running ..."

while true; do
    # Get battery information using upower
    battery_info=$(upower -i $(upower -e | grep BAT))

    # Extract battery percentage using grep and awk
    battery_percentage=$(echo "$battery_info" | grep -E "percentage" | awk '{print $2}' | tr -d '%')

    # Print the battery percentage
    #echo "Battery Percentage: $battery_percentage%"

    # Check if battery percentage is below the threshold_down
    if [ "$battery_percentage" -lt "$threshold_down" ]; then
        # Send a notification
        notify-send "Low Battery Warning" "Battery is at $battery_percentage%. Please connect to a power source."
    fi


    # Check if battery percentage is more than threshold_up
    if [ "$battery_percentage" -gt "$threshold_up" ]; then
        # Send a notification
        notify-send "Battery Charged" "Battery is at $battery_percentage%. Please unplug the battery."
    fi

    # Sleep for 5 minutes before checking again (adjust as needed)
    sleep 300
done

