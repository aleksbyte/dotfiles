-- https://github.com/CRAG666/code_runner.nvim

require('code_runner').setup {
  term = {
--    position = "vert",
    position = "belowright",
    size = 15
  },
  filetype = {
    java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
    python = "python3",
  	typescript = "deno run"
  },
  project = {
    ["~/deno/example"] = {
        name = "ExapleDeno",
        description = "Project with deno using other command",
        file_name = "http/main.ts",
        command = "deno run --allow-net"
    },
    ["~/cpp/example"] = {
        name = "ExapleCpp",
        description = "Project with make file",
        command = "make buid & cd buid/ & ./compiled_file"
    }
  },
--  filetype_path = "/home/myuser/.config/nvim/code_runner.json"
--  project_path = "/home/myuser/.config/nvim/projects.json"
}

vim.api.nvim_set_keymap('n', '<leader>r', ':RunCode<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<leader>rf', ':RunFile<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<leader>rp', ':RunProject<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<leader>crf', ':CRFiletype<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<leader>crp', ':CRProjects<CR>', { noremap = true, silent = false })
