{ pkgs, ... }:
{
  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";
    extraConfig = ''
      zeroconf_enabled   "yes"

      restore_paused     "yes"
      replaygain         "track"

      audio_output {
        type "pipewire"
        name "MPD Output"
      }
    '';
  };
}
