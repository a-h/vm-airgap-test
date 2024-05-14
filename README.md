# vm-airgap-test

Testing that a Nix copy operation actually copies all of the things needed to build an image in an airgapped environment.

## Tasks

### nix-copy

```bash
nix copy --derivation --to file://${PWD}/nix-copy-output/ .#vm
./export-flake-inputs.sh
```

### nix-restore

The restoration process will require git to be installed.

Dir: nix-copy-output

```bash
for x in `grep StorePath *.narinfo | awk '{print $2}'`; do nix copy $x --from file://$PWD/ --offline; done
```

### nix-build

```bash
nix copy --no-check-sigs --to ${PWD}/store/ .#vm
nix copy --derivation --no-check-sigs --to ${PWD}/store/ .#vm
NIX_STORE_DIR=${PWD}/store/ nix build github:a-h/nixos#vm
```
