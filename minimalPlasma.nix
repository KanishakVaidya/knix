{config, lib, pkgs, ... }:
let
  inherit (pkgs) kdePackages;
  activationScript = ''
    # will be rebuilt automatically
    rm -fv "$HOME/.cache/ksycoca"*
  '';
in
{
  users.users."shamli" = {
    isNormalUser = true;
    description = "Shamli";
    extraGroups = [ "video" "networkmanager" "wheel" ];
    packages = (with pkgs; [
      firefox neovim mpv smplayer onlyoffice-bin
      ]) ++ (with kdePackages; [
      qtwayland qtsvg
      # Core Plasma parts
      kscreen libkscreen kscreenlocker kactivitymanagerd kde-cli-tools
      kglobalacceld # keyboard shortcut daemon
      kwrited # wall message proxy, not to be confused with kwrite
      baloo # system indexer
      milou # search engine atop baloo
      kdegraphics-thumbnailers # pdf etc thumbnailer
      polkit-kde-agent-1 # polkit auth ui
      drkonqi # crash handler
      kde-inotify-survey # warns the user on low inotifywatch limits

      # Application integration
      libplasma # provides Kirigami platform theme
      plasma-integration # provides Qt platform theme
      kde-gtk-config # syncs KDE settings to GTK

      # misc Plasma extras
      kdeplasma-addons pkgs.xdg-user-dirs # recommended upstream

      # Plasma utilities
      kmenuedit kinfocenter plasma-systemmonitor ksystemstats libksysguard systemsettings kcmutils

      konsole (lib.getBin qttools) # Expose qdbus in PATH
      ark elisa gwenview okular kate khelpcenter dolphin
      baloo-widgets # baloo information in Dolphin
      dolphin-plugins spectacle ffmpegthumbs krdp
      xwaylandvideobridge # exposes Wayland windows to X11 screen capture

      breeze.qt5 plasma-integration.qt5 pkgs.plasma5Packages.kwayland-integration

      bluedevil bluez-qt pkgs.openobex pkgs.obexftp

      plasma-nm plasma-pa powerdevil colord-kde plasma-thunderbolt
    ]);
  };

  environment.systemPackages = with kdePackages; [
    kwin plasma-desktop plasma-workspace

    # Artwork + themes
    breeze breeze-icons breeze-gtk ocean-sound-theme plasma-workspace-wallpapers
    pkgs.hicolor-icon-theme # fallback icons
    qqc2-breeze-style qqc2-desktop-style
  ];

  qt.enable = true;
  programs.xwayland.enable = true;

  environment.pathsToLink = [
    "/share"
    "/libexec" # for drkonqi
  ];

  # Add ~/.config/kdedefaults to XDG_CONFIG_DIRS for shells, since Plasma sets that.
  environment.sessionVariables.XDG_CONFIG_DIRS = [ "$HOME/.config/kdedefaults" ];

  # Needed for things that depend on other store.kde.org packages to install correctly,
  # notably Plasma look-and-feel packages (a.k.a. Global Themes)
  #
  environment.sessionVariables.KPACKAGE_DEP_RESOLVERS_PATH = "${kdePackages.frameworkintegration.out}/libexec/kf6/kpackagehandlers";

  services.udisks2.enable = true;
  services.upower.enable = true;
  services.libinput.enable = true;
  xdg.icons.enable = true;
  xdg.icons.fallbackCursorThemes = [ "breeze_cursors" ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    kdePackages.kwallet
    kdePackages.xdg-desktop-portal-kde
    pkgs.xdg-desktop-portal-gtk
  ];
  xdg.portal.configPackages = [ kdePackages.plasma-workspace ];
  services.pipewire.enable = true;

  services.displayManager = {
    sessionPackages = [ kdePackages.plasma-workspace ];
    defaultSession =  "plasma";
  };

  services.displayManager.sddm = {
    enable = true;
    package = kdePackages.sddm;
    theme = "breeze";
    wayland = {
      enable = true;
      compositor = "kwin";
    };
    extraPackages = with kdePackages; [
      breeze-icons kirigami libplasma plasma5support qtsvg qtvirtualkeyboard
    ];
  };

  programs.dconf.enable = true;

  # Enable GTK applications to load SVG icons
  programs.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];

  fonts.packages = [
    pkgs.noto-fonts
    pkgs.hack-font
  ];
  fonts.fontconfig.defaultFonts = {
    monospace = [
      "Hack"
      "Noto Sans Mono"
    ];
    sansSerif = [ "Noto Sans" ];
    serif = [ "Noto Serif" ];
  };

  # FIXME: ugly hack. See #292632 for details.
  system.userActivationScripts.rebuildSycoca = activationScript;
  systemd.user.services.nixos-rebuild-sycoca = {
    description = "Rebuild KDE system configuration cache";
    wantedBy = [ "graphical-session-pre.target" ];
    serviceConfig.Type = "oneshot";
    script = activationScript;
  };
}
