{ lib, pkgs, ... }:

{
  # https://nixos.org/manual/nixos/stable/options#opt-console.enable
  console.enable = lib.mkDefault false;

  environment.gnome.excludePackages = with pkgs; [
    orca
    # evince
    # file-roller
    # geary
    # gnome-disk-utility
    # seahorse
    # sushi
    # sysprof
    # gnome-shell-extensions
    # adwaita-icon-theme
    # nixos-background-info
    # gnome-backgrounds
    # gnome-bluetooth
    # gnome-color-manager
    # gnome-control-center
    # gnome-shell-extensions
    gnome-tour # GNOME Shell detects the .desktop file on first log-in.
    # gnome-user-docs
    # glib # for gsettings program
    # gnome-menus
    # gtk3.out # for gtk-launch program
    # xdg-user-dirs # Update user dirs as described in https://freedesktop.org/wiki/Software/xdg-user-dirs/
    # xdg-user-dirs-gtk # Used to create the default bookmarks
    # baobab
    epiphany
    # gnome-text-editor
    # gnome-calculator
    # gnome-calendar
    # gnome-characters
    # gnome-clocks
    gnome-console
    # gnome-contacts
    # gnome-font-viewer
    gnome-logs
    # gnome-maps
    gnome-music
    # gnome-system-monitor
    # gnome-weather
    # loupe
    # nautilus
    gnome-connections
    simple-scan
    snapshot
    totem
    yelp
    # gnome-software
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    adw-gtk3 # https://github.com/lassekongo83/adw-gtk3
    adwaita-icon-theme
    adwaita-qt
    bibata-cursors
    dconf
    gnome-obfuscate
    gnome-terminal
    gnome-tweaks
    gnomeExtensions.advanced-alttab-window-switcher
    gnomeExtensions.expandable-notifications
    gnomeExtensions.media-controls
    gnomeExtensions.nextcloud-folder
    gnomeExtensions.pano
    gnomeExtensions.space-bar
    gnomeExtensions.tailscale-qs
    gnomeExtensions.vitals
    gnomeExtensions.vscode-search-provider
    gnomeExtensions.weather-oclock
    gnomeExtensions.wifi-qrcode
    gnomeExtensions.wiggle
  ];

  imports = [ ./default.nix ./almino/gnome.nix ];

  services.udev.packages = [ pkgs.gnome-settings-daemon ];

  # Enable the GNOME Desktop Environment.
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm = {
    enable = true;
    settings.greeter = {
      Exclude = builtins.concatStringsSep "," [
        "almino"
        "dti"
      ];
      IncludeAll = lib.mkDefault false;
    };
  };

  xdg.portal.enable = true; #flatpak
}
