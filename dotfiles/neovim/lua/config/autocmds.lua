-- ============================================================================
-- Autocommands Configuration
-- ============================================================================

-- ============================================================================
-- Go Development
-- ============================================================================

-- Format and organize imports on save for Go files
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require('go.format').goimport()
  end,
  group = format_sync_grp,
})

-- ============================================================================
-- Terraform
-- ============================================================================

-- Format Terraform files on save
local terraform_format_grp = vim.api.nvim_create_augroup("TerraformFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.tf", "*.tfvars"},
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
  group = terraform_format_grp,
})
