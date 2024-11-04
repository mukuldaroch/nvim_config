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
