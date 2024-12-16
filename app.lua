local lapis = require("lapis")
local json = require("cjson")
local app = lapis.Application()
app:enable("etlua")
app.layout = require("views.index")
local flatdb = require("flatjsondb")
  local db = flatdb('./db')
app:get("/services", function(self)
  self.current_view = "views.services"
  return { render = "index"}
end)
app:get("/team", function(self)
  self.current_view = "views.team"
  self.members = db["member.json"]
  return { render = "index"}
end)

app:get("/member/:member", function(self)
  
  self.current_view = "views.member"
  -- ngx.log(ngx.ERR, self.params.member)
  self.member = db["member.json"][self.params.member]
  -- ngx.log(ngx.ERR, json.encode(self.member))
  return { render = "index"}
end)
app:get("/faq", function(self)
  self.current_view = "views.faq"
  return { render = "index"}
end)
app:get("/", function(self)

  -- if not db.menu then
  --   db.menu = {}
  -- end
  -- self.menu = db.menu.data
  -- ngx.log(ngx.ERR, json.encode(self.menu))
  -- return db.menu
  -- local val = db.page.key
  -- db.page.key = 'value'
  -- db:save()
  self.current_view = "views.home"
  -- return "Welcome to Lapis " .. require("lapis.version") .. " value:" .. val 
  return { render = "index"}
end)

return app
