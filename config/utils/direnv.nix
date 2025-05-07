{
  lib,
  config,
  ...
}: {
  options = {
    direnv.enable = lib.mkEnableOption "Enable direnv module";
  };
  config = lib.mkIf config.direnv.enable {
    plugins.direnv = {
      enable = true;
      autoLoad = true;
    };
  };
}
