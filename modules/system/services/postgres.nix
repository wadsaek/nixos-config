{lib,config, ...}:{
  options = {
    postgres.enable = lib.mkEnableOption "PostgreSQL";
    postgres.port = lib.mkOption{
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
  };
}
