{
  outputs,
  lib,
  config,
  ...
}: let 
  hosts = lib.attrNames outputs.nixosConfigurations;
in {

  services.openssh = {
    enable = true;
    settings = {
      # TODO: Disable
      PasswordAuthentication = true;
      PermitRootLogin = "yes";

      # Automated stale socket cleanup
      StreamLocalBindUnlink = "yes";

      # GUI forwarding
      AcceptEnv = "WAYLAND_DISPLAY";
      X11Forwarding = true;
    };

    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };
}
