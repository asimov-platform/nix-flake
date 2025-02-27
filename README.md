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

[ASIMOV Platform]: https://github.com/asimov-platform
[asimov-cli]:       https://github.com/asimov-platform/asimov-cli
