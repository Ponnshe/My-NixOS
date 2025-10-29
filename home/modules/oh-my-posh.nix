{ config, pkgs, MODULES_PATH, CONFILES_PATH, ... }:

{
  programs.oh-my-posh = {
    enable = true;
    settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile "${CONFILES_PATH}/ohmyposh/zen.json"));
  };
}
