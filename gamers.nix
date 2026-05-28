{config, pkgs, userSettings, ...}:
{
  environment.systemPackages = (with pkgs; [ bottles protonup-qt lutris ] );
  users.groups.gamers.members = [ "shamli" "${userSettings.username}" ];
}
