{ lib, pkgs }:
let
  bashScripts =
    builtins.readDir ./bash
    |> builtins.attrNames
    |> map (filename: {
      name = filename;
      text = builtins.readFile bash/${filename};
    })
    |> map pkgs.writeShellApplication;
  pythonScripts =
    builtins.readDir ./python
    |> builtins.attrNames
    |> map (filename: {
      name = filename;
      text = builtins.readFile python/${filename};
    })
    # |> map (
    #   { name, text }:
    #   {
    #     inherit name;
    #     text = lib.strings.splitString "\n" text |> lib.filter (line: !lib.strings.hasPrefix "#!" line);
    #   }
    # )
    |> map (as: pkgs.writers.writePython3Bin as.name { } as.text);
in
bashScripts ++ pythonScripts
