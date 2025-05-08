{
  lib,
  config,
  ...
}: {
  options = {
    rainbow-delimiters.enable = lib.mkEnableOption "Enable rainbow-delimiters module";
  };
  config = lib.mkIf config.rainbow-delimiters.enable {
    plugins.rainbow-delimiters = {
      enable = true;
      highlight = [
        "RainbowDelimiterRed"
        "RainbowDelimiterOrange"
        "RainbowDelimiterYellow"
        "RainbowDelimiterGreen"
        "RainbowDelimiterCyan"
        "RainbowDelimiterBlue"
        "RainbowDelimiterViolet"
      ];
    };
  };
}
