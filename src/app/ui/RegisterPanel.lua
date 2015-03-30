--
-- Author: Your Name
-- Date: 2015-03-05 20:34:19
--
-- 注册面板
--local QuickLoginPanel = require("app.ui.QuickLoginPanel")


local RegisterPanel = class("RegisterPanel", function (  )
	local node = cc.CSLoader:createNode("RegisterPanel.csb")
	node:setAnchorPoint(cc.p(0.5, 0.5))
	return node
end)

function RegisterPanel:ctor(  )
	local usernameBox = self:getChildByName("username")
	local passwordBox = self:getChildByName("password")
	local repasswordBox = self:getChildByName("repassword")

	-- 确定注册按钮
	local sureBtn = self:getChildByName("sure")
	sureBtn:addTouchEventListener(function ( node, eventType )
		if eventType == 0 then
			if string.len(usernameBox:getString()) == 0 or string.len(passwordBox:getString()) == 0 or string.len(repasswordBox:getString()) == 0 then
				Funcs.alert("请输入要注册的账号和密码！")
				return 
			end
			if passwordBox:getString() ~= repasswordBox:getString() then
				Funcs.alert("两次输入的密码不一样,请重试")
				passwordBox:setString("")
				repasswordBox:setString("")
				return 
			end

			-- 注册
			local data = {}
			data["user_name"] = usernameBox:getString()
			data["user_password"] = passwordBox:getString()
			local result = self:PostServer(Net.address.post_register, data)
			-- print(result)
			-- if not result then
			-- 	Funcs.alert("与服务器的连接异常!")
			-- 	return 
			-- end

		end
	end)

	-- 返回按钮
	local backBtn = self:getChildByName("back")
	backBtn:addTouchEventListener(function ( node, eventType )
		if eventType == 0 then
			Funcs.trans(self, "app.ui.QuickLoginPanel", self:getParent())
		end
	end)

end


-- PostLogin
function RegisterPanel:PostServer( hostName, data )
	print("post Data to Server")
	--requestCount = requestCount + 1
	local requestCount = 0
	local index = requestCount
	local request = network.createHTTPRequest(function ( event )
		if tolua.isnull(self) then
			print("REQUST COMPLETED, BUT SCENE HAS QUIT")
		end
		Net.onResponse(event, index, false)
		if event.name == "completed" then
			local cookie = network.parseCookie(event.request:getCookieString())
			--dump(cookie, "GET COOKIE FROM SERVER")
			print(event.request:getResponseString())
			local result = json.decode(event.request:getResponseString())
			print("这就是我要的结果")
			for k,v in pairs(result) do
				print(k,v)
			end
		end
		if event.name == "failed" then
			Funcs.alert("与服务器的连接失败")
			return false
		end
	end, hostName, "POST")
	for k,v in pairs(data) do
		request:addPOSTValue(k, v)
	end
	request:setCookieString(network.makeCookieString({C1 = "V1", C2 =  "V2"}))
	printf("REQUEST START %d", index)
	request:start()
end


return RegisterPanel