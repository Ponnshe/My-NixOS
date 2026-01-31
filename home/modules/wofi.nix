{ config, pkgs, ... }: {
  programs.wofi = {
    enable = true;
    settings = {
      allow_images = true;
      width = "30%";
      location = "center";
    };
    style = ''
      window {
        background-color: rgba(26, 26, 31, 0.85);
        border: 2px solid #5b4ba0;
        border-radius: 12px;
        font-family: "Hack Nerd Font";
				padding: 5px;
				margin: 10px;
      }
      #input {
        margin: 10px;
        background-color: rgba(75, 59, 101, 0.85);
        color: #b7b0d1;
        border-radius: 5px;
      }
      #entry:selected {
        background-color: #4b3b65;
      }
      #text {
        color: #7887a1;
      }
    '';
  };
}
