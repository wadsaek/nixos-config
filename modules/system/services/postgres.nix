{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.services.postgresql;
in
{
  config.services.postgresql = {
  package = pkgs.postgresql_18_jit;
    enableJIT = true;

    ensureDatabases = [ "wadsaek" ];

    ensureUsers = [
      {
        name = "wadsaek";
        ensureDBOwnership = true;
      }
    ];
    identMap = ''
      # ArbitraryMapName systemUser DBUser
      superuser_map      root      postgres
      superuser_map      postgres  postgres
      # Let other names login as themselves
      superuser_map      /^(.*)$   \1
    '';

  };
  config.networking.firewall.allowedTCPPorts = lib.mkIf cfg.enable [
    cfg.settings.port
  ];
  config.environment.systemPackages =
    let
      newPostgres = pkgs.postgresql_18_jit;
    in
    [
      (pkgs.writeScriptBin "upgrade-pg-cluster" ''
        set -eux
        # XXX it's perhaps advisable to stop all services that depend on postgresql
        systemctl stop postgresql

        export NEWDATA="/var/lib/postgresql/${newPostgres.psqlSchema}"
        export NEWBIN="${newPostgres}/bin"

        export OLDDATA="${cfg.dataDir}"
        export OLDBIN="${cfg.finalPackage}/bin"

        install -d -m 0700 -o postgres -g postgres "$NEWDATA"
        cd "$NEWDATA"
        sudo -u postgres "$NEWBIN/initdb" -D "$NEWDATA" ${lib.escapeShellArgs cfg.initdbArgs}

        sudo -u postgres "$NEWBIN/pg_upgrade" \
          --old-datadir "$OLDDATA" --new-datadir "$NEWDATA" \
          --old-bindir "$OLDBIN" --new-bindir "$NEWBIN" \
          "$@"
      '')
    ];
}
