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
        "https://twitter.com" = {
          "priority" = 1;
          "takeover" = "never";
        };
        "https://docs.google.com" = {
          "priority" = 1;
          "takeover" = "never";
        };
        "https://www.canva.com" = {
          "priority" = 1;
          "takeover" = "never";
        };
        "https://www.messenger.com" = {
          "priority" = 1;
          "takeover" = "never";
        };
      };
    };
  };
}
