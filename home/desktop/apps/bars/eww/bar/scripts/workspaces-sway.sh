#!/bin/sh

COLOR_FOCUSED="#bd93f9"
COLOR_URGENT="#6272a4"
COLOR_VISIBLE="#ffb86c"
COLOR_ACTIVE="#f8f8f2"

ws_output() {
    printf '{ "id": "%s", "color": "%s" }' "$ID" "$COLOR"
}

while true; do
    swaymsg -t subscribe '[ "workspace" ]' | while read; do
        JSON=$(swaymsg -t get_workspaces -r | jq '[ sort_by(.num) | .[] ]')
        LEN=$(echo "$JSON" | jq '. | length')
        printf '['
        for i in $(seq 1 "$LEN"); do
            echo -n $([ "$i" -eq "1" ] || echo ",")' '
            idx=$((i - 1))
            ID=$(echo "$JSON" | jq ".[$idx].num")
            URGENT=$(echo "$JSON" | jq ".[$idx].urgent")
            FOCUSED=$(echo "$JSON" | jq ".[$idx].focused")
            VISIBLE=$(echo "$JSON" | jq ".[$idx].visible")
            if eval "$URGENT"; then
                COLOR="$COLOR_URGENT"
            elif eval "$FOCUSED"; then
                COLOR="$COLOR_FOCUSED"
            elif eval "$VISIBLE"; then
                COLOR="$COLOR_VISIBLE"
            else
                COLOR="$COLOR_ACTIVE"
            fi
            ws_output
        done
        echo ' ]'
    done
done

