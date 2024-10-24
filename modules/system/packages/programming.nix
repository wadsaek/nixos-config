{ pkgs, ... }:
{
  environment.systemPackages =
    (with pkgs; [
      #general programming
      gccgo14
      docker_27
      sqlcmd

      #rust
      rustup
      cargo-watch
      trunk
      sccache

      #haskell
      ghc

      #version control
      github-desktop
      gh

      #cs
      roslyn
      dotnet-sdk_8

      #gamedev
      godot_4

      #js
      nodejs_22
      sass
      nodePackages.pnpm

      #python
      python312
      python312Packages.requests

      #  wget
    ])
    ++ [
      (pkgs.vscode-with-extensions.override {
        vscodeExtensions =
          with pkgs.vscode-extensions;
          [
            bbenoist.nix
            ms-python.python
            ms-azuretools.vscode-docker
            #github.codespaces

            #csharp
            ms-dotnettools.csdevkit
            ms-dotnettools.csharp
            ms-dotnettools.vscode-dotnet-runtime
            #ormulahendry.dotnet

            #rust
            rust-lang.rust-analyzer
            tamasfe.even-better-toml

            justusadam.language-haskell
            haskell.haskell

            esbenp.prettier-vscode
            vscodevim.vim
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "vscode-tidalcycles";
              publisher = "tidalcycles";
              version = "1.4.1";
              sha256 = "sha256-pT9MwjS4Kn90VuTYfl82mGQuSNtD8tKc3h0jccz+EBI=";
            }
            {
              name = "remote-ssh-edit";
              publisher = "ms-vscode-remote";
              version = "0.47.2";
              sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
            }
            {
              name = "rust-syntax";
              publisher = "dustypomerleau";
              version = "0.6.1";
              sha256 = "a3d8973e1c248a6c6825cd5d2dd689f270722c86894a9197fe72842c2dba8c65";
            }
            {
              name = "errorlens";
              publisher = "usernamehw";
              version = "3.17.0";
              sha256 = "134100cd8ba46a2bbf0ca44410fe074234573c0ab007870fd8fc0cd41ddcd289";
            }
            {
              name = "es7-react-js-snippets";
              publisher = "dsznajder";
              version = "4.4.3";
              sha256 = "405f79d0986f5486ad840ca0bdadf0c143b304b8c19bb1c4dd281ca7b7f6d0f7";
            }
            {
              name = "bootstrap5-vscode";
              publisher = "AnbuselvanRocky";
              version = "0.4.4";
              sha256 = "51030f8103f3fdc77399328804490ff162c2777041f325133c79af4871ed33cf";
            }
            {
              name = "hotrice";
              publisher = "wadsaek";
              version = "0.1.0";
              sha256 = "ea24fceace36489b20dace157bd221f32ececcf8614655346a7c939b3e18e419";
            }
            {
              name = "todo-tree";
              publisher = "gruntfuggly";
              version = "0.0.226";
              sha256 = "sha256-Fj9cw+VJ2jkTGUclB1TLvURhzQsaryFQs/+f2RZOLHs=";
            }
            {
              name = "dependi";
              publisher = "fill-labs";
              version = "0.7.4";
              sha256 = "sha256-6nU0bVAe/vwq43ECLwypIkMAG/q5+P2bE1RPAjeTCX4=";
            }
          ];
      })
    ]
    ++ [
      (pkgs.writeShellScriptBin "slackwarebeatch" ''
        echo "hello world!"
      '')
    ];
}
