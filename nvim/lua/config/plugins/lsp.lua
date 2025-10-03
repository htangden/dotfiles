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

            require('lspconfig').jdtls.setup {
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

        end,
    }
}
