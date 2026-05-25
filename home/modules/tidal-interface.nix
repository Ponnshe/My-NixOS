{ pkgs, ... }:

{
  systemd.user.services.mopidy.Install.wantedBy = pkgs.lib.mkForce [ ];

  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [
      mopidy-mpd
      mopidy-tidal
    ];
    settings = {
      core = {
        restore_state = true;
      };
      mpd = {
        hostname = "127.0.0.1";
        port = 6600;
      };
      tidal = {
        enabled = true;
        quality = "LOSSLESS"; # Opciones: HI_RES, LOSSLESS, HIGH, LOW
      };
			audio = {
        # Pipeline GStreamer: Bifurca (tee) -> Salida de audio normal AND Salida FIFO resampleada
				output = "tee name=t ! queue ! autoaudiosink t. ! queue leaky=2 max-size-buffers=10 max-size-time=0 max-size-bytes=0 ! audioconvert ! audioresample ! audio/x-raw,rate=44100,channels=2,format=S16LE ! filesink location=/tmp/mpd.fifo";
      };
    };
  };

  programs.ncmpcpp = {
    enable = true;
    package = pkgs.ncmpcpp.override { visualizerSupport = true; };
    settings = {
      mpd_host = "127.0.0.1";
      mpd_port = "6600";
			mpd_connection_timeout = "60"; # Aumentar el umbral a 60 segundos

			# UI Colors (Dracula Theme Approximation)
      colors_enabled = "yes";
      empty_tag_color = "141";             # Purple
      header_window_color = "212";         # Pink
      volume_color = "120";                # Green
      state_line_color = "117";            # Cyan
      state_flags_color = "212";           # Pink
      main_window_color = "253";           # Foreground
      color1 = "253";                      # Base text
      color2 = "120";                      # Active/Selected item (Green)
      progressbar_color = "60";            # Background bar (Comment/Gray)
      progressbar_elapsed_color = "212";   # Filled bar (Pink)
      statusbar_color = "141";             # Purple
      statusbar_time_color = "117";        # Cyan
      player_state_color = "215";          # Orange
      alternative_ui_separator_color = "60";
      window_border_color = "60";
      active_window_border = "212";

			visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "my_fifo";
      visualizer_in_stereo = "yes";
      visualizer_type = "wave_filled"; # Opciones: spectrum, wave, wave_filled, ellipse
			#visualizer_look = "●┃";
			visualizer_look = "◆■";
      visualizer_fps = "60";        # Sincronización de refresco
			visualizer_color = "117,141"; # Cyan fading to Purple
    };
  };
}
