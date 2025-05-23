{
  lib,
  pkgs,
  config,
  ...
}: let
  javaTestPath = "${pkgs.vscode-extensions.vscjava.vscode-java-test}/share/vscode/extensions/vscjava.vscode-java-test/server";
  javaDebug = "${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server";
  getJars = plugin:
      map
      (jar: "${plugin}/${jar}")
      (builtins.attrNames (builtins.readDir plugin));
in {
  options = {
    nvim-jdtls.enable = lib.mkEnableOption "Enable nvim-jdtls module";
  };
  config = lib.mkIf config.nvim-jdtls.enable {
    plugins.jdtls = {
      enable = true;
      settings = {
        cmd = [
          "${pkgs.jdt-language-server}/bin/jdtls"
          "-configuration"
          { __raw = ''
            vim.fn.stdpath("cache") .. "/jdtls/config"
          ''; }
          "-data"
          { __raw = ''
            vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t") 
          ''; }
        ];
        java = {
          signatureHelp = true;
          completion = true;
          eclipse = {
            downloadSources = true;
          };
          configuration = {
            updateBuildConfiguration = "automatic";
          };
          maven = {
            downloadSources = true;
          };
          implementationsCodeLens = {
            enabled = true;
          };
          referencesCodeLens = {
            enabled = true;
          };
          references = {
            includeDecompiledSources = true;
          };
          format = {
            enabled = true;
          };
          gradle.enabled = true;
        };
        init_options = {
          bundles = builtins.concatLists [
            (getJars javaTestPath)
            (getJars javaDebug)
          ];
        };
      };
    };
  };
}
#
# extraConfigLua = ''
#   local jdtls = require("jdtls")
#   local cmp_nvim_lsp = require("cmp_nvim_lsp")
#
#   local root_dir = require("jdtls.setup").find_root({ "packageInfo" }, "Config")
#   local home = os.getenv("HOME")
#   local eclipse_workspace = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
#
#   local ws_folders_jdtls = {}
#   if root_dir then
#    local file = io.open(root_dir .. "/.bemol/ws_root_folders")
#    if file then
#     for line in file:lines() do
#      table.insert(ws_folders_jdtls, "file://" .. line)
#     end
#     file:close()
#    end
#   end
#
#   -- for completions
#   local client_capabilities = vim.lsp.protocol.make_client_capabilities()
#   local capabilities = cmp_nvim_lsp.default_capabilities(client_capabilities)
#
#   local config = {
#    capabilities = capabilities,
#    cmd = {
#     "${pkgs.jdt-language-server}/bin/jdt-language-server",
#     "--jvm-arg=-javaagent:" .. home .. "/Developer/lombok.jar",
#     "-data",
#     eclipse_workspace,
#     "--add-modules=ALL-SYSTEM",
#    },
#    root_dir = root_dir,
#    init_options = {
#     workspaceFolders = ws_folders_jdtls,
#    },
#    settings = {
#      java = {
#        signatureHelp = { enabled = true},
#        completion = { enabled = true },
#      },
#    },
#    on_attach = function(client, bufnr)
#       local opts = { silent = true, buffer = bufnr }
#       vim.keymap.set('n', "<leader>lo", jdtls.organize_imports, { desc = 'Organize imports', buffer = bufnr })
#       vim.keymap.set('n', "<leader>df", jdtls.test_class, opts)
#       vim.keymap.set('n', "<leader>dn", jdtls.test_nearest_method, opts)
#       vim.keymap.set('n', '<leader>rv', jdtls.extract_variable_all, { desc = 'Extract variable', buffer = bufnr })
#       vim.keymap.set('n', '<leader>rc', jdtls.extract_constant, { desc = 'Extract constant', buffer = bufnr })
#     end
#   }
#
#   jdtls.start_or_attach(config)
# '';

