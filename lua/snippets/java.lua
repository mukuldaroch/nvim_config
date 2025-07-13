local ls = require("luasnip")
local s = ls.snippet
-- local i = ls.insert_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	s("todo", fmt("// TODO: {}", { t("") })),
	s("fixme", fmt("// FIXME: {}", { t("") })),
	s("hack", fmt("// HACK: {}", { t("") })),
	s("note", fmt("// NOTE: {}", { t("") })),
	s("perf", fmt("// PERF: {}", { t("") })),
	s("warn", fmt("// WARNING: {}", { t("") })),
	s("bug", fmt("// BUG: {}", { t("") })),
}
