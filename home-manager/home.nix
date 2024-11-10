{config, pkgs, ... }:
let
	unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
	home.username = "aamosp";
	home.homeDirectory = "/home/aamosp";
	home.stateVersion = "24.05";
	nixpkgs.config = {
		allowUnfree = true;
		allowUnfreePredicat = (_: true);
		packageOverrides = pkgs: rec {
			chromium = pkgs.chromium.override { enableWideVine = true; };
		};
	};
	home.packages = [
		pkgs.htop
		pkgs.chromium
		unstable.clang_19
		unstable.llvmPackages_19.clang-tools
		pkgs.glfw3
	];
	programs.fastfetch.enable = true;
	programs.direnv = {
		enable = true;
		enableZshIntegration = true;
		nix-direnv.enable = true;
	};
	programs.dircolors = {
		enable = true;
		enableZshIntegration = true;
	};
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;
		oh-my-zsh = {
			enable = true;
			plugins = [ "git" ];
			theme = "robbyrussell";
		};
	};
	programs.kitty = {
		enable = true;
		shellIntegration.enableZshIntegration = true;
		font = {
			package = pkgs.nerdfonts;
			name = "DejaVuSansMono";
			size = 20.0;
		};
	};
	programs.tmux = {
		enable = true;
		extraConfig = "/home/aamosp/.tmux.conf";
	};
	programs.neovim = {
		package = unstable.neovim-unwrapped;
		enable = true;
		vimAlias = true;
		plugins = [
			pkgs.vimPlugins.nvim-treesitter
		];
	};
	programs.home-manager.enable = true;
}
