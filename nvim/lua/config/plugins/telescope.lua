return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
        },
        config = function()
            local builtin = require('telescope.builtin')

            vim.keymap.set("n", "<leader>fd", builtin.find_files)

            vim.keymap.set("n", "<leader>fc", function()
                builtin.find_files({ cwd = "/home/hugo/code/" })
            end)

            vim.keymap.set("n", "<leader>fg", function()
                builtin.find_files({ cwd = "~/" })
            end)


            vim.keymap.set("n", "<leader>fs", builtin.live_grep)
        end
    }
}
