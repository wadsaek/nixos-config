{ pkgs }:
builtins.readDir ./bash
|> builtins.attrNames
|> map (filename: {
  name = filename;
  text = builtins.readFile bash/${filename};
})
|> map pkgs.writeShellApplication
