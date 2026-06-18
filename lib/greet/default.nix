{
  mkAstalPkg,
  pkgs,
  self,
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  inherit (self.packages.${system}) quarrel;
in
  mkAstalPkg {
    pname = "astal-greet";
    src = ./.;
    packages = [pkgs.json-glib quarrel];

    libname = "greet";
    authors = "Aylur";
    name = "AstalGreet";
    description = "IPC client for greetd";
  }
