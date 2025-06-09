{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    toggleterm.enable = lib.mkEnableOption "Enable toggleterm module";
  };
  config = lib.mkIf config.toggleterm.enable {
    keymaps = [
      {
        mode = "t";
        key = "<C-x>";
        action = "<C-\\><C-N>";
        options = {
          silent = true;
          desc = "Escape terminal mode";
        };
      }
      # {
      #   mode = "n";
      #   key = "<leader>gg";
      #   action = "<cmd>lua _lazygit_toggle()<CR>";
      #   options = {
      #     silent = true;
      #     noremap = true;
      #     desc = "Open lazygit";
      #   };
      # }
    ];
    plugins.toggleterm = {
      enable = true;
      settings = {
        autochdir = true;
        open_mapping = "[[<leader>n]]";
        start_in_insert = false;
        insert_mappings = false;
        terminal_mappings = false;
        shade_terminals = false;
        size = ''
          function(term)
            if term.direction == "horizontal" then
              return 10
            elseif term.direction == "vertical" then
              return vim.o.columns * 0.2
            else
              return 30
            end
          end
        '';
      };
    };
  };
}
