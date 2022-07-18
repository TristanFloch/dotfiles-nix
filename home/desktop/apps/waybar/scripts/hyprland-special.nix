{ config, lib, pkgs, ... }:

pkgs.writeShellScriptBin "hyprland-special.sh" ''
  count=$(${pkgs.hyprland}/bin/hyprctl clients |
          ${pkgs.ripgrep}/bin/rg 'workspace' |
          ${pkgs.ripgrep}/bin/rg 'special' |
          ${pkgs.coreutils}/bin/wc -l)

  if [ "$count" -eq 0 ]; then
    class="none"
  elif [ "$count" -eq 1 ]; then
    class="one"
  elif [ "$count" -gt 1 ]; then
    class="many"
  else
    class="unknown"
  fi

  printf '{"text":"%s", "class":"%s", "alt":"%s", "tooltip":"%s"}\n' "$count" "$class" "$class" "$count"
''
