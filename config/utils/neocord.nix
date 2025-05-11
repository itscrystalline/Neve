{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    neocord.enable = lib.mkEnableOption "Enable neocord module";
  };
  config = lib.mkIf config.neocord.enable {
    plugins.neocord = {
      enable = true;

      package = (
        pkgs.vimPlugins.neocord.overrideAttrs (final: prev: {
          patches = (prev.patches or []) ++ [./neocord-firenvim.patch];
        })
      );
      settings = {
        auto_update = true;
        blacklist = [];
        client_id = "1157438221865717891";
        debounce_timeout = 10;
        editing_text = "Editing %s...";
        enable_line_number = true;
        logo = "https://repository-images.githubusercontent.com/325421844/ecb73f47-cb89-4ee0-a0fd-9743c2f3569a";
        logo_tooltip = "NixVim";
        file_assets = null;
        file_explorer_text = "Browsing %s...";
        git_commit_text = "Committing changes...";
        global_timer = true;
        line_number_text = "Line %s out of %s";
        log_level = null;
        main_image = "language";
        plugin_manager_text = "Managing plugins...";
        reading_text = "Reading %s...";
        show_time = true;
        terminal_text = "Using Terminal...";
        workspace_text = "Working on %s";
      };
      luaConfig.pre = ''
        enabled = not vim.g.started_by_firenvim
      '';
    };
  };
}
