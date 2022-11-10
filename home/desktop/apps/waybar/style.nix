{ colors }:

''
label {
    all: unset;
}

button {
    all: unset;
}

window#waybar {
    background: transparent;
}

#window, #taskbar {
    border-top-right-radius: 20px;
    border-bottom-right-radius: 20px;
    padding-right: 12px;
    transition: none;
    color: ${colors.foreground};
    background-color: ${colors.background-dark};
    margin-bottom: 8px;
    font-family: Ubuntu;
    font-size: 13px;
}

#workspaces {
    background-color: ${colors.background-dark};
    border-radius: 20px;
    font-family: Ubuntu Nerd Font;
    font-size: 17px;
    margin-bottom: 8px;
}

#workspaces button {
    color: ${colors.foreground};
    border: none;
    transition: none;
    border-radius: 20px;
    padding-left: 10px;
    padding-right: 10px;
}

#taskbar button {
    transition: none;
    border-radius: 0px;
}

#workspaces button:hover {
    color: ${colors.background-dark};
    background-color: ${colors.comment};
}

#workspace button.visible {
    color: ${colors.comment};
}

#workspaces button.current_output.focused,
#workspaces button.active {
    color: ${colors.purple};
}

#workspaces button.focused:hover,
#workspaces button.active:hover {
    color: ${colors.background-dark};
    background-color: ${colors.purple};
}

#mode:not(empty) {
    font-family: Ubuntu;
    font-size: 13px;
    color: ${colors.background-dark};
    background-color: ${colors.cyan};
    margin-bottom: 8px;
    padding-left: 12px;
    padding-right: 12px;
    border-radius: 20px;
    margin-left: 10px;
}

#workspaces button.urgent {
    color: ${colors.orange};
}

#workspaces button.urgent:hover {
    color: ${colors.background-dark};
    background-color: ${colors.orange};
}

#pulseaudio,
#backlight,
#cpu,
#clock,
#memory,
#tray,
#disk,
#temperature,
#battery {
    color: ${colors.foreground};
    background-color: ${colors.background-dark};
    margin-bottom: 8px;
    font-family: Ubuntu Nerd Font;
    font-size: 13px;
    padding-right: 10px;
    border-radius: 0px;
}

#temperature.critical {
    color: ${colors.red};
}

#custom-spotify {
    border-top-right-radius: 20px;
    border-bottom-right-radius: 20px;
    padding-left: 12px;
}

#custom-spotify {
    background-color: ${colors.background-dark};
    margin-bottom: 8px;
    font-family: Ubuntu Nerd Font;
    font-size: 13px;
    padding-right: 12px;
}

#custom-spotify.Playing {
    color: ${colors.foreground};
}

#custom-spotify.Paused {
    color: ${colors.comment};
}

#custom-spotify-next,
#custom-spotify-prev {
    font-family: Ubuntu Nerd Font;
    font-size: 17px;
    margin-bottom: 7px;
}

#custom-spotify-prev {
    margin-left: 10px;
    border-top-left-radius: 20px;
    border-bottom-left-radius: 20px;
    border-top-right-radius: 0px;
    border-bottom-right-radius: 0px;
    padding: 4px;
    color: ${colors.foreground};
    background-color: ${colors.background-dark};
}

#custom-spotify-next {
    padding: 4px;
    background-color: #1DB954;
    color: ${colors.background-dark};
    border-radius: 0px;
}

#battery,
#clock,
#disk,
#pulseaudio {
    border-top-right-radius: 20px;
    border-bottom-right-radius: 20px;
}

#backlight {
    border-top-left-radius: 20px;
    border-bottom-left-radius: 20px;
    padding-left: 12px;
}

#battery,
#window,
#pulseaudio {
    padding-left: 12px;
}

#battery.warning {
    color: ${colors.orange};
}

#battery.critical {
    /* TODO blink animation */
    color: ${colors.red};
}

#keyboard-state label.locked {
    font-family: Ubuntu Nerd Font;
    font-size: 17px;
    color: ${colors.background-dark};
    background-color: ${colors.pink};
    margin-bottom: 8px;
    padding-left: 12px;
    padding-right: 12px;
    margin-left: 10px;
    border-radius: 20px;
}

#clock,
#cpu,
#temperature {
    border-top-left-radius: 20px;
    border-bottom-left-radius: 20px;
    padding-left: 12px;
    margin-left: 10px;
}

#custom-temperature-icon {
    color: ${colors.red};
}

#memory,
#disk {
    padding-left: 10px;
}

#custom-scratchpads {
    font-family: Ubuntu Nerd Font;
    font-size: 17px;
    color: ${colors.background-dark};
    margin-bottom: 8px;
    padding-left: 12px;
    padding-right: 12px;
    margin-left: 10px;
    border-radius: 20px;
}

#custom-scratchpads.none {
    background-color: ${colors.comment};
    color: ${colors.background-dark};
}

#custom-scratchpads.one, #custom-scratchpads.many {
    background-color: ${colors.purple};
    color: ${colors.background-dark};
}

#custom-scratchpads.unknown {
    background-color: ${colors.orange};
    color: ${colors.background-dark};
}

#tray {
    border-top-left-radius: 20px;
    border-bottom-left-radius: 20px;
    margin-left: 10px;
    padding-left: 12px;
}
''
