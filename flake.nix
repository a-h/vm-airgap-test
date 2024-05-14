{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/23.11";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xc = {
      url = "github:joerdav/xc";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-generators, xc }: {
    vm = nixos-generators.nixosGenerate {
      system = "aarch64-linux";
      specialArgs = {
        pkgs = nixpkgs.legacyPackages.aarch64-linux;
      };
      modules = [
        # Pin nixpkgs to the flake input, so that the packages installed
        # come from the flake inputs.nixpkgs.url.
        ({ ... }: { nix.registry.nixpkgs.flake = nixpkgs; })
        # Install any packages into the system packages.
        ({ ... }: {
          environment.systemPackages = [
            xc.packages.aarch64-linux.xc
          ];
        })
        # Apply the rest of the config.
        ./configuration.nix
      ];
      format = "raw";
    };
  };
}

