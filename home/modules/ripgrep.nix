# ripgrep is a line-oriented search tool that recursively searches the current directory for a regex pattern. By default, ripgrep will respect gitignore rules and automatically skip hidden files/directories and binary files. (To disable all automatic filtering by default, use rg -uuu.) ripgrep has first class support on Windows, macOS and Linux, with binary downloads available for every release. ripgrep is similar to other popular search tools like The Silver Searcher, ack and grep.

#https://github.com/BurntSushi/ripgrep
{ config, pkgs, MODULES_PATH, CONFILES_PATH, ... }:
{
	programs.ripgrep = {
		enable = true;
	};
}
