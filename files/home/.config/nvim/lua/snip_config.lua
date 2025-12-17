-- snip config
-- using luasnip atm.

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

ls.add_snippets( "cs", {
    s({ trig = "///", name = "C# Doc Summary", dscr = "Insert C# style summary tags", wordTrig = false, regTrig = false}, {
       t( {"/// <summary>", "///", "/// </summary>"} ),
    })
})

