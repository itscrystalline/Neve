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
    highlightOverride = {
      RainbowDelimiterRed.fg = "#f38ba8";
      RainbowDelimiterYellow.fg = "#f9e2af";
      RainbowDelimiterBlue.fg = "#89b4fa";
      RainbowDelimiterOrange.fg = "#fab387";
      RainbowDelimiterGreen.fg = "#a6e3a1";
      RainbowDelimiterViolet.fg = "#cba6f7";
      RainbowDelimiterCyan.fg = "#94e2d5";
    };
  };
}
