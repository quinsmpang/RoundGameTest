
require("config")
require("cocos.init")
require("framework.init")
require("app.funcs.FunctionModals")
require("app.funcs.NetWorkModals")

local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
    cc.FileUtils:getInstance():addSearchPath("res/")
    self:enterScene("LoginScene")
end

return MyApp


-- [[

-- HTTP/1.1 200 OK
-- Date: Fri, 06 Mar 2015 09:53:40 GMT
-- Server: Apache/2.4.9 (Unix) PHP/5.5.14
-- Last-Modified: Fri, 06 Mar 2015 09:42:11 GMT
-- ETag: "95-5109b7fa442c0"
-- Accept-Ranges: bytes
-- Content-Length: 149


-- HTTP/1.0 200 OK
-- Server: SimpleHTTP/0.6 Python/2.7.6
-- Date: Fri, 06 Mar 2015 09:54:25 GMT
-- Content-type: application/octet-stream
-- Content-Length: 149
-- Last-Modified: Fri, 06 Mar 2015 09:42:11 GMT

-- ]]
