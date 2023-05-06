{ pkgs, ... }: {
  services.usbmuxd.enable = true;

  environment.systemPackages = with pkgs; [
    libimobiledevice
    ifuse
  ];

  environment.shellAliases = {
    iphone = "mkdir -p ~/iPhone; ifuse ~/iPhone";
  };
}
