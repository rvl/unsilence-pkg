{
  description = "Command to remove silent parts of a media file";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;
    flake-utils.url = github:numtide/flake-utils;
    unsilence-src = {
      url = github:lagmoellertim/unsilence;
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, unsilence-src }: {
    overlay = final: prev: {
      unsilence = final.python3Packages.buildPythonApplication {
        name = "unsilence";
        src = unsilence-src;
        postPatch = ''
          sed -i -e 's/\([[:alnum:]_-]\+\).*/\1/g' requirements.txt
        '';
        propagatedBuildInputs = [ final.ffmpeg ] ++ (with final.python3Packages; [ setuptools rich ]);
        makeWrapperArgs = [ "--prefix PATH : ${final.lib.makeBinPath [ final.ffmpeg ]}" ];
        doCheck = false;
        meta = with final.lib; {
          description = "Command to remove silent parts of a media file";
          homepage = "https://github.com/lagmoellertim/unsilence";
          maintainers = with maintainers; [ rvl ];
          platforms = platforms.unix;
          license = licenses.mit;
        };
      };
    };
  } // flake-utils.lib.eachDefaultSystem (system: let
    flake = {
      legacyPackages = nixpkgs.legacyPackages.${system}.extend self.overlay;
      defaultPackage = flake.legacyPackages.unsilence;
      defaultApp = {
        type = "app";
        program = "${flake.defaultPackage}/bin/unsilence";
      };
    };
  in
    flake);
}
