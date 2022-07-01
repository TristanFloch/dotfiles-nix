{ config, lib, pkgs, ... }:

pkgs.writeShellScriptBin "sway-scratch.sh" ''
  count=$(${pkgs.sway}/bin/swaymsg -r -t get_tree |
          ${pkgs.jq}/bin/jq -r 'recurse(.nodes[]) |
          first(select(.name=="__i3_scratch")) |
          .floating_nodes | length')

  if [[ "$count" -eq 0 ]]; then
    class="none"
  elif [[ "$count" -eq 1 ]]; then
    class="one"
  elif [[ "$count" -gt 1 ]]; then
    class="many"
  else
    class="unknown"
  fi

  printf '{"text":"%s", "class":"%s", "alt":"%s", "tooltip":"%s"}\n' "$count" "$class" "$class" "$count"
''
