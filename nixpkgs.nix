{
  inputs,
  system,
}:
let
  inherit (inputs)
    nixos-unstable-pinned
    nixos-unstable-small
    ;
  nixpkgs_options = {
    inherit system;

    config = {
      allowUnfree = true;
      trusted-users = [
        "root"
        "wadsaek"
      ];
    };
  };
in
nixpkgs_options
// {
  overlays =
    let
      unstable-small = import nixos-unstable-small nixpkgs_options;
      unstable-pinned = import nixos-unstable-pinned nixpkgs_options;
    in
    [
      (final: prev: {
        electron_31 = final.electron;
        blahaj = prev.blahaj.overrideAttrs {
          owner = "GeopJr";
          repo = "BLAHAJ";
          rev = "6e5ba24f471b31080ca35cabcf7bb16a0d56e846";
          hash = "sha256-8AM2yVqLx3JmDyyu+46hy7d9pD9hC/0aeqqmtpYhbB0=";
        };
        wiki-tui = prev.wiki-tui.overrideAttrs (old: {
          nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [
            prev.gnugrep
            prev.findutils
            prev.gnused
          ];
          postPatch = (old.postPatch or "") + ''
            set -e
            UA='wiki-tui/0.9.1 (+https://github.com/Builditluc/wiki-tui; contact: you@example.com)'

            # For each Rust file in wiki-api/, add a UA header on request builders like:
            #   Client::... .get(endpoint|url) ...
            while IFS= read -r -d "" f; do
              changed=0

              # Inject header after common patterns of .get(...)
              for pat in '.get(endpoint)' '.get(&endpoint)' '.get(url)' '.get(&url)'; do
                if grep -q "$pat" "$f"; then
                  substituteInPlace "$f" --replace "$pat" "$pat.header(reqwest::header::USER_AGENT, \"$UA\")"
                  changed=1
                fi
              done

              # If we added headers, ensure USER_AGENT is imported (idempotent)
              if [ "$changed" = 1 ] && ! grep -q 'header::USER_AGENT' "$f"; then
                sed -i '1 i use reqwest::header::USER_AGENT;' "$f"
              fi
            done < <(find wiki-api -type f -name '*.rs' -print0)

            # Also add origin=* wherever the Action API base params are set (avoids CORS oddities)
            for f in $(grep -RIl --include='*.rs' '("formatversion", "2")' wiki-api || true); do
              if ! grep -q '("origin"' "$f"; then
                substituteInPlace "$f" \
                  --replace '("formatversion", "2"),' \
                            '("formatversion", "2"), ("origin","*"),'
              fi
            done
          '';
        });
        inherit (unstable-pinned) libreoffice-qt davinci-resolve;
      })

    ];
}
