return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            local lspconfig = require("lspconfig")

            -- PYTHON
            lspconfig.pyright.setup {
                capabilities = capabilities
            }

            -- C/C++
            lspconfig.clangd.setup {
                capabilities = capabilities
            }

            --JS/TS
            lspconfig.ts_ls.setup {
                capabilities = capabilities
            }

            -- RUST
            lspconfig.rust_analyzer.setup {
                capabilities = capabilities
            }


            -- JAVA
            local jdtls_path = vim.fn.expand("~/.local/share/java")
            local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_1.7.0.v20250519-0528.jar")

            lspconfig.jdtls.setup {
              capabilities = capabilities,
              cmd = {
                "java", -- uses the java in PATH (should be 21)
                "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                "-Dosgi.bundles.defaultStartLevel=4",
                "-Declipse.product=org.eclipse.jdt.ls.core.product",
                "-Dlog.level=ALL",
                "-Xms1g",
                "--add-modules=ALL-SYSTEM",
                "--add-opens", "java.base/java.util=ALL-UNNAMED",
                "--add-opens", "java.base/java.lang=ALL-UNNAMED",
                "-jar", launcher_jar,
                "-configuration", jdtls_path .. "/config_linux",
                "-data", vim.fn.expand("~/.local/share/java/workspace") -- or per-project workspace
              },
            }

            -- JULIA
  
            lspconfig.julials.setup{
                cmd = {
                    "julia",
                    "--project=" .. vim.fn.expand("~/.julia/environments/nvim-lspconfig"),
                    "--startup-file=no",
                    "--history-file=no",
                    "-e", [[
                    using Pkg;
                    Pkg.instantiate();  # make sure dependencies are resolved
                    using LanguageServer, SymbolServer;
                    depot_path = get(ENV, "JULIA_DEPOT_PATH", "");
                    project_path = dirname(something(Base.current_project(), Base.load_path_expand(LOAD_PATH[2])));
                    @info "Starting Julia LSP" VERSION project_path depot_path
                    server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path);
                    server.runlinter = true;
                    run(server);
                    ]]
                },
                filetypes = { "julia" },
                root_dir = function(fname)
                    return lspconfig.util.root_pattern("Project.toml", ".git")(fname)
                    or vim.fn.getcwd()
                end,
            }

        end,
    }
}
