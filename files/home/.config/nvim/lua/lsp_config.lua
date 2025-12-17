-- setup lsp servers

local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

vim.lsp.config.pylsp = {
    capabilities = capabilities
}

vim.lsp.config.clangd = {
    capabilities = capabilities
}

vim.lsp.config.asm_lsp = {
    cmd = {"asm-lsp"},
    filetypes = {"asm", "nasm", "vmasm"},
    --capabilities = default_capabilities
}
--lspconfig.tsserver.setup{}
vim.lsp.config.ts_ls = {}

 
vim.lsp.config("omnisharp", {
    cmd = { "dotnet", "/opt/omnisharp/OmniSharp.dll", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
    filetypes = { "cs", "sln", "csproj" },
    root_markers = { "*.sln", "*.csproj", ".git", "omnisharp.json" },
    handlers = {
        ["textDocument/definition"] = require('omnisharp_extended').definition_handler,
        ["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
        ["textDocument/references"] = require('omnisharp_extended').references_handler,
        ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
    },
    settings = {
        enable_ms_build_load_projects_on_demand = false,
        RoslynExtensionsOptions = {
            enableDecompilationSupport = false,
            enableImportCompletion = true,
            enableAnalyzersSupport = true,
        }
    }
})

-- Enable LSPs
vim.lsp.enable("pylsp")
vim.lsp.enable("clangd")
vim.lsp.enable("asm_lsp")
vim.lsp.enable("omnisharp")



local win = require('lspconfig.ui.windows')
local _default_opts = win.default_opts

win.default_opts = function(options)
    local opts = _default_opts(options)
    opts.border = 'single'
    return opts
end
