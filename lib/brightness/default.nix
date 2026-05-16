{
  mkAstalPkg,
  pkgs,
  self,
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  inherit (self.packages.${system}) quarrel;
in
  mkAstalPkg {
    pname = "astal-brightness";
    src = ./.;
    packages = [quarrel pkgs.json-glib];

    libname = "brightness";
    authors = "Aylur";
    name = "AstalBrightness";
    description = "Read and control device brightness";
  }
