local ls = require("luasnip") -- Load LuaSnip
local s = ls.snippet          -- Create snippets
local i = ls.insert_node      -- Insert node
local t = ls.text_node        -- Text node

-- Define a snippet for an "if" statement
ls.add_snippets("lua", {
	s("if", {
		t("if ("),
		i(1, "condition"),
		t(") {"),
		t({ "", "\t" }),
		i(2, "// body"),
		t({ "", "}" }),
		i(0), -- Cursor lands here after snippet expansion
	}),
})

ls.add_snippets("cpp", {
	s("ios", {
		t({
			"#include <iostream>",
			"using namespace std;",
			"",
			"int main() {",

			"return 0;",
			"}",
		}),
	}),
})

ls.add_snippets("cpp", {
	s("leetcode", {
		t({
			"#include <iostream>",
			"#include <vector>",
			"using namespace std;",
			"int main() {",
			"}",
		}),
	}),
})
