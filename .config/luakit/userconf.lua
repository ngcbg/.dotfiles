local modes = require "modes"

-- Creates new bindings from old ones.
modes.remap_binds("normal", {
    {"<Control-+>", "zi", true},
    {"<Control-/>", "zo", true}
})

modes.add_binds("normal", {{
    "<Control-c>",
    "Copy selected text.",
    function ()
        luakit.selection.clipboard = luakit.selection.primary
    end
}})

modes.add_binds("all", {
  { "<Scroll>", "Scroll the current page.", function (w, o)
    w:scroll{ yrel = settings.get_setting("window.scroll_step") }
    end },
})

local settings = require "settings"
settings.window.home_page = "https://www.startpage.com/search/?q=%s"

-- settings.window.home_page = "https://www.startpage.com/search/?q=%s"

local engines = settings.window.search_engines
-- engines.aur          = "https://aur.archlinux.org/packages.php?O=0&K=%s&do_Search=Go"
-- engines.aw           = "https://wiki.archlinux.org/index.php/Special:Search?fulltext=Search&search=%s"
-- .googleseceng = "https://www.google.com/search?name=f&hl=en&q=%s"
engines.startpage	 = "https://www.startpage.com/do/dsearch?query=$0"

-- engines.default = search_engines.startpage
