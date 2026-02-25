{
  description = "David A. Clunie's dicom3tools, packaged for Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    {
      overlays.default = final: prev: { dicom3tools = import ./. { inherit (final) pkgs; }; };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages."${system}";
      in
      {
        packages.dicom3tools = import ./. { inherit pkgs; };
        packages.default = self.packages."${system}".dicom3tools;
        checks = {
          default = self.packages."${system}".dicom3tools;
          overlaid = (pkgs.extend self.overlays.default).dicom3tools;
        };
        formatter = pkgs.nixfmt-tree;
      }
    );
}
