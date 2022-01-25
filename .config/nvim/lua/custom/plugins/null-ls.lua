local null_ls = require "null-ls"
local b = null_ls.builtins

local sources = {

   b.formatting.prettierd.with { filetypes = { "html", "markdown", "css" } },
   b.formatting.deno_fmt,

   -- Lua
   b.formatting.stylua,
   b.diagnostics.luacheck.with { extra_args = { "--global vim" } },

   -- Shell
   b.formatting.shfmt,
   b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

   -- Python 
   b.formatting.black.with { filetypes = {"python"}, 
			                 args = { "--quiet", "--fast", "-", "--target-version py310" } },

    -- C/C++
    b.formatting.clang_format.with { filetypes = {"c", "cpp", "cs", "java"}, }, 

    -- CMake
    b.formatting.cmake_format
}

local M = {}

M.setup = function()
   null_ls.setup {
      debug = true,
      sources = sources,

      -- format on save
      on_attach = function(client)
         if client.resolved_capabilities.document_formatting then
            vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
         end
      end,
   }
end

return M
