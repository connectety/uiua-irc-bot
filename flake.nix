{
  description = "IRC status bot written in Uiua";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    uiua-unstable.url = "github:uiua-lang/uiua";
  };

  outputs = { self, nixpkgs, uiua-unstable }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          uiua = uiua-unstable.packages.${system}.default;
        in {
          default = pkgs.stdenv.mkDerivation {
            pname = "uiua-irc-bot";
            version = "0.1.0";

            src = ./.;

            nativeBuildInputs = [ uiua ];

            buildPhase = ''
              uiua stand --name irc
            '';

            installPhase = ''
              mkdir -p $out/bin
              cp irc $out/bin/
            '';
          };
        }
      );
    };
}
