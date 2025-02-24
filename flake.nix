{
  description = "Asimov CLI Flake with explicit per-platform packages";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

  outputs = { self, nixpkgs, ... }:
    let
      mkAsimov = { url, sha256, system, version }:
        let
          pkgs = import nixpkgs { inherit system; };
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

      version = "25.0.0-dev.2";
    in {
      packages.x86_64-darwin.default = mkAsimov {
        system = "x86_64-darwin";
        url    = "https://github.com/asimov-platform/asimov-cli/releases/download/${version}/asimov-macos-x86.gz";
        sha256 = "332f2a586bb3d702db60b165f09b96a01995034a35ab109713d01ba53f0cb2cf";
        inherit version;
      };
      packages.aarch64-darwin.default = mkAsimov {
        system = "aarch64-darwin";
        url    = "https://github.com/asimov-platform/asimov-cli/releases/download/${version}/asimov-macos-arm.gz";
        sha256 = "af05128473c3dfda48e7740d2a456a7996a6391ac46a3ef0620cb803afaeb793";
        inherit version;
      };
      packages.x86_64-linux.default = mkAsimov {
        system = "x86_64-linux";
        url    = "https://github.com/asimov-platform/asimov-cli/releases/download/${version}/asimov-linux-x86.gz";
        sha256 = "a64251f846d0cc0280a7f83f25f0db0c4f15ef4caf349ccd45dad22250866060";
        inherit version;
      };
      packages.aarch64-linux.default = mkAsimov {
        system = "aarch64-linux";
        url    = "https://github.com/asimov-platform/asimov-cli/releases/download/${version}/asimov-linux-arm.gz";
        sha256 = "e9ca2393fe6147a01f10a36bd162b8f014fcfc1e964bb65a33e6d0920b34960d";
        inherit version;
      };
    }
}

