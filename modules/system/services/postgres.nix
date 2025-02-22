{ lib, config, ... }:
{
  options = {
    postgres.enable = lib.mkEnableOption "PostgreSQL";
    postgres.port = lib.mkOption {
      type = lib.types.port;
      default = 5432;
      description = "Port for PostgreSQL";
    };
  };

  config.services.postgresql = lib.mkIf config.postgres.enable {
    inherit (config.postgres) enable;
    settings = {
      inherit (config.postgres) port;
    };

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
  config.networking.firewall.allowedTCPPorts = lib.mkIf config.postgres.enable [ config.postgres.port ];
}
