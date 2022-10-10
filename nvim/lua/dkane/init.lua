require("dkane.set")
require("dkane.remap")

require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    }
}

local function foo()
    print "hello world\n"
end
