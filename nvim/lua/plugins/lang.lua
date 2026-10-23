-- nvim/lua/plugins/lang.lua
return {
  -- Python
  { import = "lazyvim.plugins.extras.lang.python" },
  -- Go
  { import = "lazyvim.plugins.extras.lang.go" },
  -- Rust
  { import = "lazyvim.plugins.extras.lang.rust" },
  -- C/C++
  { import = "lazyvim.plugins.extras.lang.clangd" },
  -- Java
  { import = "lazyvim.plugins.extras.lang.java" },
  -- TypeScript / Angular
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.angular" },
  -- Docker / Compose
  { import = "lazyvim.plugins.extras.lang.docker" },
}