{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
    ./disko-configuration.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 16;
        editor = false;
      };
    };
    tmp.cleanOnBoot = true;
  };

  hardware.enableRedistributableFirmware = true;

  networking = {
    firewall.enable = true;
    hostName = "sirius";
    networkmanager.enable = true;
  };

  nix = {
    nixPath = [ "nixpkgs=${pkgs.path}" ];
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "flakes" "nix-command" ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  services = {
    fail2ban.enable = true;
    openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        KbdInteractiveAuthentication = false;
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };

  system.stateVersion = "22.11";

  time.timeZone = "Europe/Helsinki";

  users = {
    mutableUsers = false;
    users = {
      raroh73 = {
        extraGroups = [ "networkmanager" "wheel" ];
        hashedPassword = "$y$j9T$G0rX4W6eqrwz2gNOSuM9/1$M1SiWyYp.Xq4u0GPAJxZYeW0CJ6q3BzIJ2ubkgi6DP3";
        isNormalUser = true;
        openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO+aFhxW7Q8vLMPCS8jPFtqUUePL6Ks9213gsEOJbIOz raroh73@mars" ];
        packages = with pkgs; [ git ];
      };
      root.hashedPassword = "!";
    };
  };
}
