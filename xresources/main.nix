{ config, lib, pkgs, ... }:

{
  xresources.properties = {
    ".Xresources" = "Xft.dpi: 96";
  };
}
