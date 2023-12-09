# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  hardware.bluetooth.enable = true;
  boot.supportedFilesystems = ["ntfs"];
  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "nixos"; # Define your hostname.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  virtualisation.docker.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Manila";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LANGUAGE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    LC_IDENTIFICATION = "fil_PH";
    LC_MONETARY = "fil_PH";
    LC_PAPER = "fil_PH";
    LC_TELEPHONE = "fil_PH";
  };

  # Configure keymap in X11
  xdg.portal.enable = true;
  services.flatpak.enable = true;
  services.blueman.enable = true;

  programs.hyprland.enable = true;

  services.xserver = {
    enable = true;
    xkbOptions = "caps:escape,shift:lock";
    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        middleEmulation = true;
      };
      mouse = {
        middleEmulation = false;
        accelProfile = "flat";
        accelSpeed = "-0.5";
      };
    };
    displayManager = {
      defaultSession = "none+xmonad";
      sddm = {
        enable = false;
      };
    };
    windowManager = {
      xmonad = {
        enable = true;
      };
    };
    desktopManager.plasma5 = {
      enable = true;
    };
    layout = "us";
    xkbVariant = "";
  };

  services.upower.enable = true;
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
  '';

  services.gnome = {
    gnome-keyring.enable = true;
    at-spi2-core.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.truff = {
    isNormalUser = true;
    description = "Home";
    extraGroups = ["networkmanager" "video" "docker" "wheel" "libvirtd"];
    shell = pkgs.zsh;
    packages = [];
  };

  services.locate = {
    enable = true;
  };

  systemd.services.brightness = {
    enable = true;
    description = "Set brightness writable to everybody";
    unitConfig = {
      Type = "oneshot";
      Before = "nodered.service";
      After = "sys-devices-pci0000:00-0000:00:02.0-drm-card0-card0\\x2deDP\\x2d1-intel_backlight.device";
    };
    serviceConfig = {
      User = "root";
      ExecStart = ''
        /bin/sh -c "chgrp -R -H video /sys/class/backlight/intel_backlight && chmod g+w /sys/class/backlight/intel_backlight/brightness"
      '';
    };
    wantedBy = ["multi-user.target"];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  virtualisation.waydroid.enable = true;
  virtualisation.libvirtd.enable = true;
  environment.systemPackages = with pkgs; [
    vim
    home-manager
    kitty
  ];

  environment.shells = with pkgs; [bashInteractive zsh];

  nix = {
    settings = {
      trusted-users = ["root" "truff"];
      allow-import-from-derivation = "true";
      experimental-features = ["nix-command" "flakes"];
      trusted-public-keys = ["hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="];
      substituters = ["https://cache.iog.io"];
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.zsh.enable = true;
  programs.dconf.enable = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  hardware.opentabletdriver.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  sound.enable = true;
  sound.mediaKeys.enable = true;

  hardware.pulseaudio.enable = false;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
      rocm-opencl-icd
      rocm-opencl-runtime
    ];
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Open ports in the firewall.

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [3000 80 17500 8080];
      allowedUDPPorts = [17500 8080]; # 175000 for Dropbox
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ]; # KDE Connect
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ]; # KDE Connect
    };
  };

  services.printing = {
    enable = true;
    drivers = [pkgs.cnijfilter2 pkgs.gutenprint];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
