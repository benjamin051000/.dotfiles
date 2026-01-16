#!/usr/bin/env fish

# audio sink names from `pactl list short sinks`
set HEADSET_SINK "alsa_output.usb-SteelSeries_SteelSeries_Arctis_7-00.stereo-game"
set SPEAKER_SINK "alsa_output.pci-0000_00_1f.3.analog-stereo"

set CURRENT_STATE "unknown"

while true
    if test (headsetcontrol -b | awk '/Level/ {print $2;}') = '0%'
        set NEW_STATE "disconnected"
    else
        set NEW_STATE "connected"
    end
    
    # Only switch if state changed
    if test "$NEW_STATE" != "$CURRENT_STATE"
        if test "$NEW_STATE" = "connected"
            echo "Headset connected, switching audio..."
            pactl set-default-sink "$HEADSET_SINK"
        else
            echo "Headset disconnected, switching to speakers..."
            pactl set-default-sink "$SPEAKER_SINK"
        end
        set CURRENT_STATE "$NEW_STATE"
    end
    
    sleep 3
end
