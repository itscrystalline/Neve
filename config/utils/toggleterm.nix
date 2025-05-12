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
        size = ''
          function(term)
            if term.direction == "horizontal" then
              return 20
            elseif term.direction == "vertical" then
              return vim.o.columns * 0.3
            else
              return 30
            end
          end
        '';
      };
    };
    extraConfigLua = ''
      local Terminal  = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        -- function to run on opening the terminal
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
        end,
        -- function to run on closing the terminal
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
      })

      function _lazygit_toggle()
        lazygit:toggle()
      end
    '';
  };
}
