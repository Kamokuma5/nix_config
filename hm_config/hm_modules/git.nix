{ pkgs, ... }:
{
  enable = true;

  userEmail = "kamokuma5@gmail.com";
  userName = "Kamo Kuma";

  extraConfig = {
    init.defaultBranch = "main";
    credential.helper = "cache";
  };
}
