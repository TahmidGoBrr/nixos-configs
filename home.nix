{ inputs, config, pkgs, ... }:
{
  home = {
	username = "tahmid";
	homeDirectory = "/home/tahmid";
	stateVersion = "26.05";
	packages = with pkgs; [
		# packages I need
		firefox
		kdePackages.dolphin
		mission-center
		openjdk25
		zed-editor
		qemu
		virt-manager
		# wm related
		waybar
		hyprpaper
		mako
		wl-clipboard
		wofi
		hyprshot
		# supporting packages
		libsForQt5.qt5ct
		kdePackages.qt6ct
		kdePackages.polkit-kde-agent-1
		pavucontrol
		networkmanager_dmenu
		kdePackages.kio-admin
		vlc

	];
	pointerCursor = {
		package = pkgs.bibata-cursors;
		name = "Bibata-Modern-Ice";
		size = 18;
		gtk = {
			enable = true;
		};
		x11 = {
			enable = true;
		};
	};
  };
  programs = {
	zsh = {
		oh-my-zsh = {
			enable = true;
			plugins = [ "git" ];
			theme = "bira";
		};
	};
	kitty = {
		enable = true;
		themeFile = "Catppuccin-Frappe";
		settings = {
			confirm_os_window_close = 0;
		};
	};
	nixcord = {
		enable = true;
		discord = {
			enable = true;
			vencord = {
				enable = true;
			};
		};
		config = {
			themes = {
				"catppuccin-frappe" = ''
        				@import url("github.io");
      				'';
			};
			plugins = {
				betterFolders.enable = true;
				fakeNitro.enable = true;
				messageLogger.enable = true;
			};
		};
	};
  };
  gtk = {
	enable = true;
	theme = {
		name = "Adwaita-dark";
		package = pkgs.gnome-themes-extra;
	};
	gtk4 = {
		extraConfig = {
			gtk-application-prefer-dark-theme = 1;
		};
	};
  };

  dconf = {
  	settings = {
		"org/gnome/desktop/interface" = {
			color-scheme = "prefer-dark";
		};
	};
  };

}
