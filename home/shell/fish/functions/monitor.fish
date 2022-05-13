set monitors (xrandr | rg ' connected' | cut -d" " -f1)

set color_green "\033[0;32m"
set no_color "\033[0m"

echo "Currently connected to the following monitors:"
echo -ne $color_green
for m in $monitors
    echo $m
end
echo -ne $no_color

echo "Script in progress..."
