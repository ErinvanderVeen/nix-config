{ hmUsers, suites, inputs, ... }:
{
  home-manager.users = { inherit (hmUsers) nixos; };

  users.users.nixos = {
    description = "default";
    initialHashedPassword = "$y$j9T$YL05DpRpKY0L9JEbeUvvu/$zdCZDf9iDJ0B3T9n2y7fKoIyHQhhB981Dcdff19Kqf9";
    isNormalUser = true;
    extraGroups = [ "wheel" "media" ];
    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBD9ABNVaBX71Hb/u2IVOr9ZAAhnp7szmE3k6fX0FBPVTmoPMbSbewWdnsvi0syzIb+oWajU4ipHG5UZHkAMpIi8= erin@Gwen"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE+jQ+XfIiLyP9y4GPoPCVqwgry+v6pi/nAma3z6oRqA erin@Tequatl"
    ];
  };
}
