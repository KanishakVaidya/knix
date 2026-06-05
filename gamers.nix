{config, pkgs, userSettings, ...}:
{
  # Setting up Gaming Binary Cache
  nix.settings = {
    substituters = [
      "https://nix-gaming.cachix.org"
    ];
    trusted-public-keys = [
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];
  };
  environment.systemPackages = (with pkgs; [ bottles protonup-qt lutris ] );
  users.groups.gamers.members = [ "shamli" "${userSettings.username}" ];
}
