colors: fonts:
{
  "global/wm" = {
    margin-top = 0;
    margin-bottom = 0;
  };

  "bar/main" = {
    enable-ipc = true;
    monitor = "\${env:MONITOR}";
    witdh = "100%";
    height = 36;
    radius = 0;
    fixed-center = true;
    bottom = true;
    background = colors.transparent;
    foreground = colors.foreground;
    border-top-size = 0;
    border-bottom-size = 6;
    border-bottom-color = colors.transparent;
    border-left-size = 0;
    border-left-color = colors.transparent;
    border-right-size = 0;
    border-right-color = colors.transparent;
    padding-left = 0;
    padding-right = 0;
    module-margin-left = 0;
    module-margin-right = 0;
    modules-left = "xwindow right left date right left my-xkeyboard right left-spotify spotify right-spotify";
    modules-center = "left i3 right";
    modules-right = "left backlight space pulseaudio right left memory space cpu space filesystem right left temperature space battery right left";
    font = fonts.list;
    cursor-click = "pointer";
    cursor-scroll = "ns-resize";
    tray-detached = false;
    tray-position = "right";
    tray-scale = 1;
    tray-background = colors.background;
  };

  "settings" = {
    compositing-background = "source";
    compositing-foreground = "over";
    compositing-overline = "over";
    compositing-underline = "over";
    compositing-border = "over";
    format-foreground = colors.foreground;
    format-background = colors.background;
    pseudo-transparency = false;
  };
}
