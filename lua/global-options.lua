vim.g.editorconfig = false

vim.diagnostic.config({
	virtual_text = false,
})

vim.o.guicursor = table.concat({
	"n-v-c:block-Cursor",
	"i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
	"r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100",
}, ",")
