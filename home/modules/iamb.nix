{ config, pkgs, ... }:

{
  programs.iamb = {
    enable = true;
    # El paquete se añade automáticamente al habilitar el módulo
    settings = {
      default_profile = "main";

      profiles.main = {
        user_id = "@ponnshe:localhost";
        url = "http://localhost:6167";
      };

      settings = {
				notifications = {
          enabled = true;
        };
				image_preview = {
					protocol = {
            type = "sixel";
          };
        };
        # Opcional: añade un logger si planeas debugear el bridge de Slack
        logging = "info"; 
      };
    };
  };
}
