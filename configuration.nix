# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  options,
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
  networking.timeServers = ["ntp.ubuntu.com"] ++ options.networking.timeServers.default;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  powerManagement.enable = true;
  services.power-profiles-daemon.enable = false;
  # services.auto-cpufreq.enable = true;
  # services.auto-cpufreq.settings = {
  #   battery = {
  #     governor = "powersave";
  #     turbo = "never";
  #   };
  #   charger = {
  #     governor = "performance";
  #     turbo = "auto";
  #   };
  # };

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 80;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 100;

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
    };
  };

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

  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk 
      pkgs.xdg-desktop-portal
    ];
  };
  services.flatpak.enable = true;
  services.blueman.enable = true;

  programs.nm-applet = {
    enable = true;
    indicator = true;
  };
  programs.hyprland.enable = true;

  programs.waybar = {
    enable = true;
  };

  services.libinput = {
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

  services.displayManager = {
    defaultSession = "hyprland";
  };

  services.desktopManager.plasma6 = {
    enable = true;
  };

  services.xserver = {
    enable = true;
    xkb = {
      options = "caps:escape_shifted_capslock";
      layout = "us";
    };
  };

  services.upower.enable = true;
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
  '';
  services.logind.lidSwitch = "suspend-then-hibernate";

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

  users.users.tester = {
    isNormalUser = true;
    description = "Home";
    extraGroups = ["networkmanager" "video" "docker" "wheel" "libvirtd"];
    shell = pkgs.zsh;
    packages = [];
  };

  services.locate = {
    enable = true;
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

  hardware.opentabletdriver = {
    enable = true;
  };

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
    wireplumber = {
      enable = true;
    };
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Open ports in the firewall.

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [3000 80 17500 8080 9100 50001];
      # 50001: codeium
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

  services.resolved = {
    enable = true;
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
