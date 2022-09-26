{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Tristan FLOCH";
    userEmail = "tristan.floch@epita.fr";
    signing = {
      key = "204D153E08EE4DD9764D813CF762D9933B1FAAF5";
      signByDefault = true;
    };
  };
}
