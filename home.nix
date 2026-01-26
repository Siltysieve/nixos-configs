{ config, pkgs, ... }:
let 
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    qtile = "qtile";
    nvim = "nvim";
    rofi = "rofi";
    alacritty = "alacritty";
  };
in
{
	home.username = "blue";
	home.homeDirectory = "/home/blue";
	home.stateVersion = "25.11";
	programs.bash = {
		enable = true;
		shellAliases = {
		   bluesilt = "echo that's me!";
		};
  

	};
  xdg.configFile = builtins.mapAttrs 
  (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) 
  configs;
	#xdg.configFile."qtile" = {
  #  source = create_symlink "${dotfiles}/qtile/";
  #  recursive = true;
  #};

	#xdg.configFile."nvim" = {
  #  source = create_symlink "${dotfiles}/nvim/";
  #};

	#xdg.configFile."alacritty" = {
  #  source = create_symlink "${dotfiles}/alacritty/";
	#};
  
  home.packages = with pkgs; [
	  neovim
	  ripgrep
	  nil
	  nixpkgs-fmt
	  nodejs
	  gcc
    rofi
    bat
    anki
	];

programs.git = {
    enable = true;
    settings = {
      user = {
        name  = "blue";
        email = "dheerajsinha042@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };


}
