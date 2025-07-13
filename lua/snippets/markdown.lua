local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

return {
	s("fixme", { t({ "<!-- FIXME: " }), i(1), t({ " -->" }) }),
	s("bug", { t({ "<!-- BUG: " }), i(1), t({ " -->" }) }),
	s("fixit", { t({ "<!-- FIXIT: " }), i(1), t({ " -->" }) }),
	s("fix", { t({ "<!-- FIX: " }), i(1), t({ " -->" }) }),
	s("issue", { t({ "<!-- ISSUE: " }), i(1), t({ " -->" }) }),
	s("todo", { t({ "<!-- TODO: " }), i(1), t({ " -->" }) }),
	s("perf", { t({ "<!-- PERF: " }), i(1), t({ " -->" }) }),
	s("optimize", { t({ "<!-- OPTIMIZE: " }), i(1), t({ " -->" }) }),
	s("performance", { t({ "<!-- PERFORMANCE: " }), i(1), t({ " -->" }) }),
	s("note", { t({ "<!-- NOTE: " }), i(1), t({ " -->" }) }),
	s("hack", { t({ "<!-- HACK: " }), i(1), t({ " -->" }) }),
	s("warning", { t({ "<!-- WARNING: " }), i(1), t({ " -->" }) }),
	s("xxx", { t({ "<!-- XXX: " }), i(1), t({ " -->" }) }),
	s("info", { t({ "<!-- INFO: " }), i(1), t({ " -->" }) }),
	s("passed", { t({ "<!-- PASSED: " }), i(1), t({ " -->" }) }),
	s("testing", { t({ "<!-- TESTING: " }), i(1), t({ " -->" }) }),
	s("failed", { t({ "<!-- FAILED: " }), i(1), t({ " -->" }) }),
	s("plink", { t({ "[ " }), i(1), t({ " ](#)" }) }),
	s("callout", { t({ ">` " }), i(1), t({ " `", "" }), t(">") }),
}
