{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    catppuccin.enable = lib.mkEnableOption "Enable catppuccin module";
  };
  config = lib.mkIf config.catppuccin.enable {
    colorschemes = {
      catppuccin = {
        enable = true;
        package = pkgs.vimPlugins.catppuccin-nvim.overrideAttrs (final: prev: {
          patches = (prev.patches or []) ++ [./catppuccin_pink.patch];
        });
        settings = {
          background = {
            light = "macchiato";
            dark = "mocha";
          };
          custom_highlights = ''
            function(colors)
              return {
                AlphaHeader = { fg = colors.pink },
                TelescopeBorder = { fg = colors.pink },
                LazygitBorder = { fg = colors.pink },
                FloatBorder = { fg = colors.pink },
                LspInfoBorder = { fg = colors.pink },
                DapUIFloatBorder = { fg = colors.pink },
                MiniNotifyBorder = { fg = colors.pink },
                NeoTreeDirectoryName = { fg = colors.pink },
                NeoTreeDirectoryIcon= { fg = colors.pink },
                NeoTreeRootName = { fg = colors.pink },
                NeoTreeTitleBar = { bg = colors.pink },
                lualine_a_normal = { bg = colors.pink },
                lualine_b_normal = { fg = colors.pink },
                lualine_c_normal = { fg = colors.pink },
              }
            end
          '';
          flavour = "mocha"; # "latte", "mocha", "frappe", "macchiato" or raw lua code
          disable_bold = false;
          disable_italic = false;
          disable_underline = false;
          transparent_background = false;
          term_colors = true;
          integrations = {
            cmp = true;
            noice = true;
            notify = true;
            neotree = true;
            harpoon = true;
            gitsigns = true;
            which_key = true;
            illuminate = {
              enabled = true;
            };
            treesitter = true;
            treesitter_context = true;
            telescope.enabled = true;
            indent_blankline.enabled = true;
            mini.enabled = true;
            native_lsp = {
              enabled = true;
              inlay_hints = {
                background = true;
              };
              underlines = {
                errors = ["underline"];
                hints = ["underline"];
                information = ["underline"];
                warnings = ["underline"];
              };
            };
            rainbow_delimiters = true;
          };
        };
      };
    };
  };
}
