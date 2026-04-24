local cwd = vim.fn.getcwd()
local work = vim.fn.expand("~/work")
local canonical = vim.fn.expand("~/canonical")

local enable = vim.startswith(cwd, work) or vim.startswith(cwd, canonical)

return {
	"github/copilot.vim",
	cond = enable
}
