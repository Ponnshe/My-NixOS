{ config, pkgs, MODULES_PATH, CONFILES_PATH, ... }:
{
	programs.yazi = {
		enable = true;

		settings = {
			mgr = {
				show_hidden = true;
				sort_by = "natural";
				sort_dir_first = true;
			};

			preview = {
				wrap = "no";
				tab_size = 2;
			};
			# 1. Definir la regla de apertura
			open = {
				rules = [
					{ mime = "image/*"; use = [ "view" ]; }
				];
			};

			opener = {
				view = [
					{
						run = ''imv "$@"'';
						detach = true; # Esto es clave para que Yazi no se quede bloqueado esperando
						desc = "Open with imv";
					}
				];
				edit = [
					{
						run = "$EDITOR \"$@\"";
						block = true;
						for = "unix";
						desc = "Open with Editor";
					}
					{
						run = "sudo -E $EDITOR \"$@\"";
						block = true;
						for = "unix";
						desc = "Open with sudo Editor";
					}
				];
			};

		};

		keymap = {
			mgr = {
				prepend_keymap = [
					{
						on = "<C-Enter>";
						run = "shell sudo -E $EDITOR \"$@\"";
						for = "Unix";
						desc = "Abrir archivo con sudo";
					}
				];
			};
		};

		plugins = {
			"fullBorder" = pkgs.yaziPlugins.full-border;
			"yatline" = pkgs.yaziPlugins.yatline;
			"yatline-dracula" = pkgs.runCommand "yatline-dracula" {} ''
				mkdir -p $out
				cp -r ${pkgs.fetchFromGitHub {
					owner = "wakaka6";
					repo = "yatline-dracula.yazi";
					rev = "82dde5ae1f944e7bb3d3b8261a9624bd88497c23";
					sha256 = "sha256-aJoe4DLcz72aL8XShehmD8HDchu+6mGfMYZND6UzU48=";
				}}/* $out/
				ln -s $out/init.lua $out/main.lua
			'';
			"yatline-githead" = pkgs.yaziPlugins.yatline-githead;
		};

		initLua = ''
			require("fullBorder"):setup()
			local dracula_theme = require("yatline-dracula"):setup()

			require("yatline"):setup({
				show_background = false,

				header_line = {
					left = {
						section_a = {
										{type = "line", custom = false, name = "tabs", params = {"left"}},
						},
						section_b = {
						},
						section_c = {
						}
					},
					right = {
						section_a = {
										{type = "string", custom = false, name = "date", params = {"%A, %d %B %Y"}},
						},
						section_b = {
										{type = "string", custom = false, name = "date", params = {"%X"}},
						},
						section_c = {
						}
					}
				},

				status_line = {
					left = {
						section_a = {
										{type = "string", custom = false, name = "tab_mode"},
						},
						section_b = {
										{type = "string", custom = false, name = "hovered_size"},
						},
						section_c = {
										{type = "string", custom = false, name = "hovered_path"},
										{type = "coloreds", custom = false, name = "count"},
						}
					},
					right = {
						section_a = {
										{type = "string", custom = false, name = "cursor_position"},
						},
						section_b = {
										{type = "string", custom = false, name = "cursor_percentage"},
						},
						section_c = {
										{type = "string", custom = false, name = "hovered_file_extension", params = {true}},
										{type = "coloreds", custom = false, name = "permissions"},
						}
					}
				},

				theme = dracula_theme,
	})
			require("yatline-githead"):setup()
		'';

		theme = {
			flavor = {
				use = "dracula";
			};
		};
	};
}
