final: prev: {
  switchKanata =
    let
      switchKanataText = builtins.readFile ./scripts/kanata.py;
      switchKanata = toString (
        prev.writers.writePython3 "switchKanata" {
        } switchKanataText
      );
    in
    switchKanata;
}
