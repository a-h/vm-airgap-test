{ pkgs, ... }: {
  documentation = {
    enable = false;
  };
  virtualisation = {
    docker = {
      enable = true;
    };
  };
  # Enable OpenSSH and ACPID (for shutdown).
  services = {
    openssh.enable = true;
    acpid.enable = true;
  };
  # Setup nix to use flakes.
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings = {
      trusted-users = [ "root" "@wheel" ];
    };
  };
  users.users = {
    adrian = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      initialPassword = "password";
      openssh.authorizedKeys.keys = [
        # github.com/a-h.keys
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4ZYYVVw4dsNtzOnBCTXbjuRqOowMOvP3zetYXeE5i+2Strt1K4vAw37nrIwx3JsSghxq1Qrg9ra0aFJbwtaN3119RR0TaHpatc6TJCtwuXwkIGtwHf0/HTt6AH8WOt7RFCNbH3FuoJ1oOqx6LZOqdhUjAlWRDv6XH9aTnsEk8zf+1m30SQrG8Vcclj1CTFMAa+o6BgGdHoextOhGMlTx8ESAlgIXCo+dIVjANE2qbfAg0XL0+BpwlRDJt5OcgzrILXZ1jSIYRW4eg/JBcDW/WqorEummxhB26Y6R0jeswRF3DOQhU2fAhbsCWdairLam42rFGlKfWyTbgjRXl/BNR"
      ];
      packages = [
        pkgs.vim
      ];
    };
  };
  system.stateVersion = "23.11";
}
