return {

 {
  "kdheepak/lazygit.nvim",
  config = function() end,
 },
 -- ------------------------------------------------------------------------
 {
  -- Adds git releated signs to the gutter, as well as utilities for managing changes
  "lewis6991/gitsigns.nvim",
  opts = {
   -- See `:help gitsigns.txt`
   signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
   },
  },
 },
 -- ------------------------------------------------------------------------
 --[[
 {
  "tpope/vim-fugitive",
  event = "VeryLazy", -- Load it lazily on a very lazy event
  config = function()
   -- Define a Neovim autocmd group for custom fugitive commands
   local FugitiveGroup = vim.api.nvim_create_augroup("FugitiveGroup", {})

   -- Create an autocmd to set up key mappings for Fugitive buffer
   vim.api.nvim_create_autocmd("BufWinEnter", {
    group = FugitiveGroup,
    pattern = "*",
    callback = function()
     if vim.bo.filetype ~= "fugitive" then
      return
     end

     local bufnr = vim.api.nvim_get_current_buf()
     local opts = { buffer = bufnr, remap = false }

     -- Key mappings for Git commands
     vim.keymap.set("n", "<leader>p", function()
      vim.cmd("Git push")
     end, opts)
     vim.keymap.set("n", "<leader>P", function()
      vim.cmd("Git pull --rebase")
     end, opts)
     vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)

     -- Conflict resolution mappings
     vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>", opts)
     vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>", opts)
    end,
   })

   -- Key mapping to open the Git status window in a vertical layout with a custom width
   vim.keymap.set("n", "<leader>g", function()
    -- Open the Git status window in the created split
    vim.cmd("vertical Git")
    local width = math.floor(vim.o.columns * 0.3)
    -- Set the width of the current window
    vim.cmd("vertical resize " .. width)
    -- Remove line numbers for the current window
    vim.wo.number = false
    vim.wo.relativenumber = false
   end)
  end,
 },
--]]
 -- ------------------------------------------------------------------------
 require("telescope").setup({
  defaults = {
   file_ignore_patterns = {
    "%.git/",
    "%.git/*",
    "%.vs/",
    "%.vs/*",
    "%out/",
    "%out/*",
    "%CMakeFiles/*",
    "CMakeCache.txt",
    "cmake_install.cmake",
    "CMakeLists.txt",
    "CMakePresets.json",
    "compile_commands.json",
    "Makefile",

    --	"%.gitignore",
   },
  },
  pickers = {},
  extensions = {},
 }),
 -- ----------------------------------
}
