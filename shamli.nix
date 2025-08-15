{ config, pkgs, ... }:
{
  # GDM
  services.xserver.enable = true;
  services.upower.enable = true;
  services.xserver.displayManager = {
    gdm = {
      enable = true;
      wayland = true;
    };
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gnome
    pkgs.xdg-desktop-portal-gtk
  ];
  services.displayManager.sessionPackages = [ pkgs.gnome-session.sessions ];
  users.users."shamli" = {
    isNormalUser = true;
    description = "Shamli";
    extraGroups = [ "video" "networkmanager" "wheel" ];
    packages = (with pkgs; [
      vlc evince gnome-browser-connector gnome-desktop gvfs geany-with-vte onlyoffice-bin xdg-user-dirs gnome-menus gnome-common gnome-shell gnome-session gnome-power-manager gdm gnome-settings-daemon gnome-terminal gnome-control-center nautilus gnome-tweaks gnome-calculator eog gnome-themes-extra file-roller xournalpp
      # dependencies of orchis gtk theme
      sassc gtk-engine-murrine
      kdePackages.kdenlive gimp
    ]) ;
  };
}
