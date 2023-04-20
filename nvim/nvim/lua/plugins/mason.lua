require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    },
	ensure_installed = { "pyright", "vscode-html-language-server" },

})
require("mason-lspconfig").setup()
require("lspconfig").pyright.setup {}
require("lspconfig").html.setup {}
