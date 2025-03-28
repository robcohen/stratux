{
  description = "Stratux pi-gen image builder";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        devShells.default = pkgs.mkShell {
          name = "stratux-image-builder";

          buildInputs = with pkgs; [
            git
            coreutils
            gnutar
            gzip
            debootstrap
            qemu-user-static
            rsync
            dosfstools
            parted
            kmod
            curl
            xz
            util-linux
            wget
            btrfs-progs
          ];

          shellHook = ''
            echo "📦 Stratux image build environment ready."
            echo "Run ./image_build/build.sh inside the repo."
          '';
        };
      });
}

