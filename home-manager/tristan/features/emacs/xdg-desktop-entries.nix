{
  config,
  doomEmacsDir,
}: let
  commonOptions = {
    genericName = "Text Editor";
    comment = "Edit text";
    mimeType = [
      "text/english"
      "text/plain"
      "text/x-makefile"
      "text/x-c++hdr"
      "text/x-c++src"
      "text/x-chdr"
      "text/x-csrc"
      "text/x-java"
      "text/x-moc"
      "text/x-pascal"
      "text/x-tcl"
      "text/x-tex"
      "application/x-shellscript"
      "text/x-c"
      "text/x-c++"
    ];
    categories = [
      "Development"
      "TextEditor"
    ];
    terminal = false;
  };
  emacs = "${config.programs.emacs.package}/bin/emacs";
in {
  doom-emacs =
    {
      name = "Doom Emacs";
      exec = "${emacs} --init-directory ${doomEmacsDir}";
      icon = ./doom.png;
    }
    // commonOptions;

  # nano-emacs = {
  #   name = "NANO Emacs";
  #   exec = "${emacs} --init-directory ${homeDir}/.emacs.d.nano";
  #   icon = "emacs"; # TODO
  # } // commonOptions;

  # gnu-emacs = {
  #   name = "GNU Emacs";
  #   exec = "${emacs} --init-directory ${homeDir}/.emacs.d.gnu";
  #   icon = "emacs";
  # } // commonOptions;

  emacs-minimal =
    {
      name = "Emacs (Minimal)";
      exec = "${emacs} --init-directory ${config.xdg.configHome}/emacs-minimal";
      icon = "emacs";
    }
    // commonOptions;
}
