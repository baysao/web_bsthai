local lapis = require("lapis")
local json = require("cjson")
local app = lapis.Application()
app:enable("etlua")
app.layout = require("views.index")
local flatdb = require("flatjsondb")
local db = flatdb("./db")
function app:handle_error(err, trace)
    return "There was an error"
  end
  

app:get(
    "/services",
    function(self)
        self.current_view = "views.services"
        return {render = "index"}
    end
)
app:get(
    "/team",
    function(self)
        self.current_view = "views.team"
        local _m = db["member.json"]
        local _t = {}
        for k, v in pairs(_m) do
            _t[#_t + 1] = v;
        end

        -- ngx.log(ngx.ERR, json.encode(self.members))
        table.sort(_t, function(k1,k2) return k1.index < k2.index end)
        self.members = _t
        -- ngx.log(ngx.ERR, json.encode(t))

        return {render = "index"}
    end
)

app:get(
    "/member/:member",
    function(self)
        self.current_view = "views.member"
        -- ngx.log(ngx.ERR, self.params.member)
        self.member = db["member.json"][self.params.member]
       
        
        return {render = "index"}
    end
)
app:get(
    "/faq/:name",
    function(self)
        self.current_view = "views.faq"
        self.post = db["posts" .. "/"..self.params.name .. ".json"]
        return {render = "index"}
    end
)
app:get(
    "/gallery",
    function(self)
        self.gallery_list = db["gallery.json"]
        ngx.log(ngx.ERR, json.encode(self.gallery_list))
        self.current_view = "views.gallery"
        return {render = "index"}
    end
)
app:get(
    "/",
    function(self)
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
        return {render = "index"}
    end
)

return app
