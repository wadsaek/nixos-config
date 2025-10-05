{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.packages.programming = lib.mkEnableOption "programming packages";
  config.packages.programming = lib.mkDefault config.packages.full;

  config.environment.systemPackages = lib.optionals config.packages.programming (
    (with pkgs; [
      #rust
      sccache

      #version control
      lazygit
      gitui
      rusty-man
      gh
    ])
    ++ lib.optionals config.packages.graphical [
      pkgs.github-desktop
      pkgs.godot_4-mono

      (pkgs.vscode-with-extensions.override {
        vscodeExtensions = with pkgs.vscode-extensions; [
          bbenoist.nix
          # ms-python.python

          #csharp
          ms-dotnettools.csdevkit
          ms-dotnettools.csharp
          ms-dotnettools.vscode-dotnet-runtime
          #ormulahendry.dotnet

          #rust
          rust-lang.rust-analyzer

          vscodevim.vim
          usernamehw.errorlens
        ];
      })
    ]
    ++ [
      (pkgs.writeShellScriptBin "slackwarebeatch" ''
        echo "hello world!"
      '')
    ]
  );
}
