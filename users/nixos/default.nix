{ hmUsers, suites, inputs, ... }:
{
  home-manager.users = { inherit (hmUsers) nixos; };

  users.users.nixos = {
    description = "default";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBD9ABNVaBX71Hb/u2IVOr9ZAAhnp7szmE3k6fX0FBPVTmoPMbSbewWdnsvi0syzIb+oWajU4ipHG5UZHkAMpIi8= erin@Gwen"
    ];
  };
}
