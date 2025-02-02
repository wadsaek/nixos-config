{ pkgs, ... }:
{
  environment.systemPackages =
    (with pkgs; [
      #general programming
      gccgo14
      docker_27
      sqlcmd

      #rust
      trunk
      sccache

      #version control
      github-desktop
      lazygit
      gh

      #gamedev
      godot_4
    ])
    ++ [
      (pkgs.vscode-with-extensions.override {
        vscodeExtensions =
          with pkgs.vscode-extensions;
          [
            bbenoist.nix
            ms-python.python

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
    ];
}
