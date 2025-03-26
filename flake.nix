{
  description = "ASIMOV CLI Flake with explicit per-platform packages";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

  outputs = { self, nixpkgs, ... }:
    let
      pkgsFor = system: import nixpkgs { inherit system; };

      mkAsimov = { url, sha256, system, version }:
        let
          pkgs = pkgsFor system;
        in
        pkgs.stdenv.mkDerivation {
          pname = "asimov-cli";
          inherit version;

          src = pkgs.fetchurl {
            inherit url sha256;
          };

          nativeBuildInputs = [ pkgs.gzip ];
          phases = [ "unpackPhase" "installPhase" ];

          unpackPhase = ''
            cp $src asimov.gz
            gunzip asimov.gz
            chmod +x asimov
          '';

          installPhase = ''
            mkdir -p $out/bin
            mv asimov $out/bin/
          '';

          checkPhase = ''
            $out/bin/asimov --version
          '';
          doCheck = true;
        };

      version = "25.0.0-dev.3";

      asimov-x86_64-linux = mkAsimov {
        system = "x86_64-linux";
        url    = "https://github.com/asimov-platform/asimov-cli/releases/download/${version}/asimov-linux-x86-gnu.gz";
        sha256 = "0c30685a1b814364c17a70b629e3b94a24bec0c66c1943bd324cf56b57980326";
        inherit version;
      };

      asimov-aarch64-linux = mkAsimov {
        system = "aarch64-linux";
        url    = "https://github.com/asimov-platform/asimov-cli/releases/download/${version}/asimov-linux-arm-gnu.gz";
        sha256 = "2761b82936598588b7266d6d63abd1271e57d087c14f382f1ab15e523973c3e5";
        inherit version;
      };

      asimov-x86_64-darwin = mkAsimov {
        system = "x86_64-darwin";
        url    = "https://github.com/asimov-platform/asimov-cli/releases/download/${version}/asimov-macos-x86.gz";
        sha256 = "f2620190d96c1d929ce1c43d6e7f6ba751b32b3000d6419c5f032e4e23a2dc3e";
        inherit version;
      };

      asimov-aarch64-darwin = mkAsimov {
        system = "aarch64-darwin";
        url    = "https://github.com/asimov-platform/asimov-cli/releases/download/${version}/asimov-macos-arm.gz";
        sha256 = "c89a0660b1d091c332f6cf1611fe6f9021c8ed48948f2c43e2b05dfeb7afc8de";
        inherit version;
      };
    in {
      packages.x86_64-linux.default = asimov-x86_64-linux;
      packages.aarch64-linux.default = asimov-aarch64-linux;
      packages.x86_64-darwin.default = asimov-x86_64-darwin;
      packages.aarch64-darwin.default = asimov-aarch64-darwin;

      defaultPackage.x86_64-linux = asimov-x86_64-linux;
      defaultPackage.aarch64-linux = asimov-aarch64-linux;
      defaultPackage.x86_64-darwin = asimov-x86_64-darwin;
      defaultPackage.aarch64-darwin = asimov-aarch64-darwin;
    };
}
