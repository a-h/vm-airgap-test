# vm-airgap-test

Testing that a Nix copy operation actually copies all of the things needed to build an image in an airgapped environment.

## Tasks

### nix-create-store

```bash
nix build --store ${PWD}/store .#vm
```

### rm-result

Don't copy the result over to the airgapped environment. The point is to see if the store has everything needed to build the image.

```bash
rm -rf result
```

### nix-copy

Copy the store over to the VM. On a mac, you might want to add `--no-xattrs` to the `tar` command to stop it adding junk to the tarball.

```bash
tar -cvzf vm-airgap-test.tar vm-airgap-test
scp ./vm-airgap-test.tar adrian@192.168.0.97:~/
```

### nix-build-use-store

Once the store has been copied to the airgapped environment, build the image.

```bash
tar -xvzf vm-airgap-test.tar
cd vm-airgap-test
nix build --store ${PWD}/store .#vm
```
