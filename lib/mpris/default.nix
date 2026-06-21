{
  mkAstalPkg,
  pkgs,
  self,
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  inherit (self.packages.${system}) quarrel;
in
  mkAstalPkg {
    pname = "astal-mpris";
    src = ./.;
    packages = [
      quarrel
      pkgs.libsoup_3
      pkgs.gdk-pixbuf
      pkgs.json-glib
    ];

    libname = "mpris";
    authors = "Aylur";
    name = "AstalMpris";
    description = "Control mpris players";
  }
