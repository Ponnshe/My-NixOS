{ config, pkgs, ... }:
{
  programs.anki= {
    enable = true;
		theme = "dark";
		minimalistMode = true;
  };
}
