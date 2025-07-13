local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

return {
    s("fixme", { t({ " FIXME: " }), i(1) }),
    s("bug", { t({ " BUG: " }), i(1) }),
    s("fixit", { t({ " FIXIT: " }), i(1) }),
    s("fix", { t({ " FIX: " }), i(1) }),
    s("issue", { t({ " ISSUE: " }), i(1) }),
    s("todo", { t({ " TODO: " }), i(1) }),
    s("perf", { t({ " PERF: " }), i(1) }),
    s("optimize", { t({ " OPTIMIZE: " }), i(1) }),
    s("performance", { t({ " PERFORMANCE: " }), i(1) }),
    s("note", { t({ " NOTE: " }), i(1) }),
    s("hack", { t({ " HACK: " }), i(1) }),
    s("warning", { t({ " WARNING: " }), i(1) }),
    s("xxx", { t({ " XXX: " }), i(1) }),
    s("info", { t({ " INFO: " }), i(1) }),
    s("passed", { t({ " PASSED: " }), i(1) }),
    s("testing", { t({ " TESTING: " }), i(1) }),
    s("failed", { t({ " FAILED: " }), i(1) }),
}
