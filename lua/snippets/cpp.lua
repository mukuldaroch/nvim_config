local ls = require("luasnip") -- Load LuaSnip
local s = ls.snippet -- Create snippets
local i = ls.insert_node -- Insert node
local t = ls.text_node -- Text node
-- local fmt = require("luasnip.extras.fmt").fmt

return {
    s("fixme", { t({ "// FIXME: " }), i(1) }),
    s("bug", { t({ "// BUG: " }), i(1) }),
    s("fixit", { t({ "// FIXIT: " }), i(1) }),
    s("fix", { t({ "// FIX: " }), i(1) }),
    s("issue", { t({ "// ISSUE: " }), i(1) }),
    s("todo", { t({ "// TODO: " }), i(1) }),
    s("perf", { t({ "// PERF: " }), i(1) }),
    s("optimize", { t({ "// OPTIMIZE: " }), i(1) }),
    s("performance", { t({ "// PERFORMANCE: " }), i(1) }),
    s("note", { t({ "// NOTE: " }), i(1) }),
    s("hack", { t({ "// HACK: " }), i(1) }),
    s("warning", { t({ "// WARNING: " }), i(1) }),
    s("xxx", { t({ "// XXX: " }), i(1) }),
    s("info", { t({ "// INFO: " }), i(1) }),
    s("passed", { t({ "// PASSED: " }), i(1) }),
    s("testing", { t({ "// TESTING: " }), i(1) }),
    s("failed", { t({ "// FAILED: " }), i(1) }),

    s("leetcode", {
        t({
            "#include <iostream>",
            "#include <vector>",
            "using namespace std;",
            "",
        }),
        i(1), -- 👈 cursor goes here first
        t("int main() {"),
        t({ "", "\t" }),
        -- i(2),
        t({ "", "}" }),
        -- i(0), -- 👈 after you're done typing and tabbing, cursor lands here
    }),
}
