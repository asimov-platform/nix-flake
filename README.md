# Nix Flake for ASIMOV Platform

This repository provides a Nix flake for the [ASIMOV Platform], delivering the **asimov-cli** tool as a Nix package.

## Prerequisites

- [Nix](https://nixos.org) with experimental features enabled (flakes support).  
  Run the following command to enable flakes:

  ```bash
  mkdir -p ~/.config/nix && echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
  ```

## Configuration

Firstly, register this flake in your local Nix registry for easier use
```bash
nix registry add asimov-cli github:asimov-platform/nix-flake
```

## Installation

### Install [asimov-cli]

```bash
nix profile install asimov-cli#default --no-write-lock-file
```

## Usage

After installation, you can run the CLI with:

```bash
asimov --help
```

To check the installed version:

```bash
asimov --version
```

## Troubleshooting

1. Verify Nix installation and flake support

```bash
nix --version
```
Make sure your configuration has experimental-features = nix-command flakes.

2. Confirm asimov is on your PATH

```bash
which asimov
```
If this prints “not found,” you may need to open a new shell or manually source the Nix profile (e.g., source ~/.nix-profile/etc/profile.d/nix.sh on Linux single-user, or source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh on macOS).

3. Reinstall or update
   If something goes wrong, you can remove and reinstall:

```bash
nix profile remove github:asimov-platform/nix-flake
nix profile install github:asimov-platform/nix-flake
```

For additional help, refer to the [Nix documentation](https://nixos.org/manual/nix/stable/)

[ASIMOV Platform]: https://github.com/asimov-platform
[asimov-cli]:       https://github.com/asimov-platform/asimov-cli
