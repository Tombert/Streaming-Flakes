{
  description = "Thing for my striming shit";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: let
    pkgs = import nixpkgs { system = "x86_64-linux"; };

    makeChromiumWrapper = url: pkgs.writeShellScriptBin "chromium-wrapper-${builtins.replaceStrings ["/" ":" "."] ["_" "_" "_"] url}" ''
      exec ${pkgs.chromium}/bin/chromium --kiosk ${url}
    '';

    chromiumApp = url: {
      type = "app";
      program = "${makeChromiumWrapper url}/bin/chromium-wrapper-${builtins.replaceStrings ["/" ":" "."] ["_" "_" "_"] url}";
    };
  in {
    defaultPackage.x86_64-linux = makeChromiumWrapper "http://192.168.1.1:8096";

    apps.x86_64-linux = {
      jellyfin = chromiumApp "http://192.168.1.1:8096";
      hulu = chromiumApp "http://hulu.com";
      youtube = chromiumApp "http://youtube.com";
      youtubeMusic = chromiumApp "http://music.youtube.com";
      disney = chromiumApp "http://disneyplus.com";
    };
  };
}

