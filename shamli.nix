{ config, pkgs, ... }:
{
  # lightdm
  services.xserver.enable = true;
  services.xserver.displayManager = {
    lightdm = {
      enable = true;
      greeters.slick.enable = true;
    };
  };

  services.xserver.desktopManager.cinnamon.enable = true;
  services.cinnamon.apps.enable = false;

  environment.cinnamon.excludePackages = [];

  users.users."shamli" = {
    isNormalUser = true;
    description = "Shamli";
    extraGroups = [ "video" "networkmanager" "wheel" ];
    packages = (with pkgs; [
      brave vlc evince geany-with-vte libreoffice-fresh file-roller xournalpp gnome-terminal
      gnome-calculator gnome-calendar gnome-screenshot pix
      # dependencies of orchis gtk theme
      sassc gtk-engine-murrine
      kdePackages.kdenlive gimp
    ]) ;
  };
}
