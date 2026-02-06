{ config, pkgs, ... }:
let 
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    nvim = "nvim";
    rofi = "rofi";
    kitty = "kitty";      
    hypr = "hypr";
    zsh = "zsh";
    caelestia = "caelestia";
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

programs.zsh.initContent = ''
  source ~/.config/zsh/p10k.zsh
'';
home.file.".p10k.zsh".source = create_symlink "${dotfiles}/zsh/p10k.zsh";
  
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
    telegram-desktop
    qbittorrent
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



  programs.caelestia = {
  enable = true;
  systemd = {
    enable = false; # if you prefer starting from your compositor
    target = "graphical-session.target";
    environment = [];
  };
  cli = {
    enable = true; # Also add caelestia-cli to path
  };
};

  programs.zsh = {
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;

  shellAliases = {
    ll = "eza -l";
    update = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos";
  };
  history.size = 10000;
  oh-my-zsh = { # "ohMyZsh" without Home Manager
    enable = true;
    plugins = [ "git" ];
    custom = "$HOME/.oh-my-zsh/custom"; # Points to your manual installs
    theme = "powerlevel10k/powerlevel10k";
  };
  
};

}


