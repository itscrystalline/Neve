{
  lib,
  config,
  ...
}: let
  makeIgnore = list:
    builtins.listToAttrs (map (elem: {
        name = elem;
        value = {
          priority = 1;
          takeover = "never";
        };
      })
      list);
in {
  options = {
    firenvim.enable = lib.mkEnableOption "Enable firenvim module";
  };

  config.plugins.firenvim = lib.mkIf config.firenvim.enable {
    enable = true;
    settings = {
      localSettings =
        {
          "https://labs.cognitiveclass.ai*" = {
            selector = "textarea:not([class=xterm-helper-textarea])";
          };
        }
        // makeIgnore [
          "https://twitter.com"
          "https://docs.google.com"
          "https://www.canva.com"
          "https://www.instagram.com"
          "https://www.messenger.com"
          "https://nc.iw2tryhard.dev"
        ];
    };
  };
}
