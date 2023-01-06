{ pkgs, ... }:
{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    overrideDevices = false;
    overrideFolders = false;
    guiAddress = "0.0.0.0:8384";
  };
}
