local present, mason = pcall(require, "mason")

if not present then
  return
end

local pres, masonRegister = pcall(require, "mason-registry")

if not pres then
  return
end


local options = {
  ensure_installed = {
    "lua-language-server",
    "pyright",
    "eslint-lsp",
    "typescript-language-server",

    -- cpp
    "clangd",
    "codelldb",

    -- go
    "gopls",
    "goimports-reviser",
    "delve",

    -- rust
    "rust-analyzer",

  },
 max_concurrent_installers = 10,
}

mason.setup(options)


vim.api.nvim_create_user_command("MasonInstallAll", function()
  -- check if plugin is already ensure_installed
  for _, plugin in ipairs(options.ensure_installed) do
    if not masonRegister.is_installed(plugin) then
      vim.cmd("MasonInstall " .. table.concat({plugin}, " "))
    end

  end
end, {})

-- vim.cmd("MasonInstallAll")
