{
  lib,
  config,
  ...
}: {
  options = {
    lazygit.enable = lib.mkEnableOption "Enable lazygit module";
  };
  config = lib.mkIf config.lazygit.enable {
    plugins.lazygit.enable = true;
    dependencies.lazygit.enable = true;
    keymaps = [
      {
        mode = "n";
        key = "<leader><tab>l";
        action = "<cmd>tablast<cr>";
        options = {
          silent = true;
          desc = "Last tab";
        };
      }
    ];
  };
}
