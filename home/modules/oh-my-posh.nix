{ config, pkgs, confilePath, ... }:

{
  programs.oh-my-posh = {
    enable = true;
    settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile "${confilePath}/ohmyposh/zen.json"));
  };
}
