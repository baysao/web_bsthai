local config = require("lapis.config")

config("development", {
  port=80,
  server = "nginx",
  code_cache = "off",
  num_workers = "1"
})
