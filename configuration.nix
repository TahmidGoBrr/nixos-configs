{ config, lib, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  boot = {
	loader = {
  		efi = {
			canTouchEfiVariables = true;
			efiSysMountPoint = "/boot/efi";
  		};
     		grub = {
         		enable = true;
         		device = "nodev";
         		efiSupport = true;
         		useOSProber = true;
		};
	};
  };
  services = {
	libinput = {
		enable = true;
	};
	pipewire = {
		enable = true;
			pulse.enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			wireplumber.enable = true;
	};
	displayManager = {
		sddm = {
				enable = true;
				extraPackages = [ pkgs.adwaita-icon-theme ];
				wayland = {
					enable = false;
			};
		};
	};
	xserver = {
		enable = true;
		xkb = {
			layout = "us";
			variant = "";
		};
	};
  };
  virtualisation = {
  	libvirtd = {
		enable = true;
		qemu = {
			package = pkgs.qemu_kvm;
			runAsRoot = true;
		};
	};
	waydroid = {
		enable = true;
		package = pkgs.waydroid-nftables;
	};
  };
  programs = {
	hyprland = {
		enable = true;
		withUWSM = false;
		xwayland = {
			enable = true;
		};
	};
	zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestions = {
			enable = true;
		};
		syntaxHighlighting = {
			enable = true;
		};
	};
	virt-manager = {
		enable = true;
	};
  };
  xdg = {
		portal = {
			enable = true;
			extraPortals = with pkgs; [
				xdg-desktop-portal-gtk
			];
			config = {
				common.default = "*";
			};
		};
  };
  networking = {
	 hostName = "taichi";
	 networkmanager = {
	 	enable = true;
  	};
	nftables = {
		enable = false;
	};
  };
  time = {
  	timeZone = "Asia/Dhaka";
  };
  i18n = {
  	defaultLocale = "en_US.UTF-8";
  };
  console = {
	font = "ter-v20b";
	keyMap = "us";
	packages = [ pkgs.terminus_font ];
  };
  zramSwap = {
  	enable = true;
	algorithm = "zstd";
	priority = 100;
	memoryPercent = 50;
  };
  fonts = {
	packages = with pkgs; [
		nerd-fonts.iosevka
		noto-fonts
		noto-fonts-cjk-sans
		noto-fonts-cjk-serif
		noto-fonts-lgc-plus
		noto-fonts-color-emoji
		liberation_ttf
		freefont_ttf
	];
	fontconfig = {
		defaultFonts = {
			serif = [ "Noto Serif" "Noto Serif CJK SC" ];
			sansSerif = [ "Noto Sans" "Noto Sans CJK SC" ];
			monospace = [ "Iosevka Nerd Font" "Noto Sans Mono CJK SC" ];
			emoji = [ "Noto Color Emoji" ];
		};
	};
  };
  users.users = {
	tahmid = {
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" "libvirtd" "waydroid" ];
		shell = pkgs.zsh;
	};
  };
  environment = {
	systemPackages = with pkgs; [
    		neovim 
    		wget
    		git
    		xfsprogs
    		btrfs-progs
		fastfetch
	];
	sessionVariables = {
		NIXOS_OZONE_WL = "1";
		WLR_NO_HARDWARE_CURSORS = "1";
		QT_QPA_PLATFORM = "wayland;xcb";
		QT_AUTO_SCREEN_SCALE_FACTOR = "1";
		QT_QPA_PLATFORMTHEME = "qt5ct";
		SDL_VIDEODRIVER = "wayland";
		CLUTTER_BACKEND = "wayland";
		GDK_BACKEND = "wayland,x11";
		XCURSOR_SIZE = "24";
		HYPRCURSOR_SIZE = "24";
	};
  };
  nix = {
  	settings = {
		experimental-features = [ "nix-command" "flakes" ];
	};
  };
  nixpkgs = {
  	config = {
		allowUnfree = true;
	};
  };
  system = {
  	stateVersion = "24.11";
  };
}
