return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {
    options = { "buffers", "win", "tabpages", "curdir" },
  },
}
