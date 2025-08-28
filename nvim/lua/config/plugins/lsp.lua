return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            local lspconfig = require("lspconfig")

            -- LUA
            lspconfig.lua_ls.setup {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" }, -- Recognize `vim` as a global
                        },
                        workspace = {
                            library = {
                                vim.env.VIMRUNTIME, -- Include Neovim runtime files
                                "${3rd}/luv/library",
                                "${3rd}/busted/library",
                            },
                            checkThirdParty = false, -- Avoid prompts about third-party libraries
                        },
                        telemetry = {
                            enable = false,
                        },
                    }
                }
            }

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
        end,
    }
}
