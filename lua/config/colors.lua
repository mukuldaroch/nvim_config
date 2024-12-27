-- Load Nightfox first to apply custom highlights after
require("nightfox").setup({
 options = {
  -- Enable transparency to let terminal background show through Neovim background
  transparent = true,
  -- Enable terminal colors to match the theme's colors in Neovim's terminal
  terminal_colors = true,
  -- Disable dimming of inactive windows
  dim_inactive = false,
  -- Use default values for all modules (treesitter, telescope, etc.)
  module_default = true,
  -- Options for colorblind accessibility adjustments
  colorblind = {
   enable = false, -- Colorblind mode disabled
   simulate_only = false, -- Only simulate colorblind view, don't adjust colors
   severity = {
    protan = 0, -- Severity for red-blind (protanopia)
    deutan = 0, -- Severity for green-blind (deuteranopia)
    tritan = 0, -- Severity for blue-blind (tritanopia)
   },
  },
  -- Style settings for various syntax groups
  styles = {
   comments = "italic", -- Make comments italic
   conditionals = "NONE", -- No specific style for conditionals
   constants = "NONE", -- No specific style for constants
   functions = "NONE", -- No specific style for functions
   keywords = "NONE", -- No specific style for keywords
   numbers = "NONE", -- No specific style for numbers
   operators = "NONE", -- No specific style for operators
   strings = "NONE", -- No specific style for strings
   types = "NONE", -- No specific style for types
   variables = "NONE", -- No specific style for variables
  },

  -- Options for inverting colors in certain contexts
  inverse = {
   match_paren = true, -- Do not invert colors for matching parentheses
   visual = false, -- Do not invert colors for visual selections
   search = true, -- Do not invert colors for search matches
  },

  -- Configure specific theme modules if needed
  modules = {}, -- Empty; defaults will be used
 },

 -- Custom color palettes can be defined here (empty, so defaults will be used)
 palettes = {},
 -- Specific color modifications for each theme (empty, so defaults will be used)
 specs = {},
 -- Override highlight groups if needed (empty, so defaults will be used)
 groups = {},
})
