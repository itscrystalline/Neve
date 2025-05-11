{
  lib,
  config,
  ...
}: {
  options = {
    firenvim.enable = lib.mkEnableOption "Enable firenvim module";
  };

  config.plugins.firenvim = lib.mkIf config.firenvim.enable {
    enable = true;
    settings = {
      localSettings = {
        "https://labs.cognitiveclass.ai*" = {
          selector = "textarea:not([class=xterm-helper-textarea])";
        };
      };
    };
  };
}
