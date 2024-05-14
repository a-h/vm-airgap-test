# vm-airgap-test

Testing that a Nix copy operation actually copies all of the things needed to build an image in an airgapped environment.

## Tasks

### nix-copy

```bash
nix copy --derivation --to file://${PWD}/nix-copy-output/ .#vm
nix copy --to file://${PWD}/nix-copy-output/ .#vm
```
