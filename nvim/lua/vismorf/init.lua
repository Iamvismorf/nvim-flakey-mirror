--todo: better way to navigate opened buffers
--https://github.com/saghen/blink.cmp/blob/main/repro.lua
require("lze").load({
	{ import = "vismorf.cmp" },
	{ import = "vismorf.format" },
})
require("vismorf.config")
require("vismorf.plugins")
require("vismorf.lsp")
