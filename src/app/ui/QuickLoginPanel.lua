--
-- Author: Your Name
-- Date: 2015-03-05 17:12:00
--

-- 注册面板
local RegisterPanel = import(".RegisterPanel")

local MainScene = import("..scenes.MainScene")

require "anysdkConst"

local QuickLoginPanel = class("QuickLoginPanel", function (  )
	local node = cc.CSLoader:createNode("QuickLoginPanel.csb")
	node:setAnchorPoint(cc.p(0.5, 0.5))
	return node
end)
local requestCount = 0

function QuickLoginPanel:ctor(  )

	self.usernameBox = self:getChildByName("username")
	self.passwordBox = self:getChildByName("password")
	self.usernameBox:addEventListener(function ( node, event )
		if event == 2 then
			if string.len(self.usernameBox:getString()) > 12 then
				--device.showAlert("haha", "aaa",nil, nil)
				Funcs.alert("账号不能超过12位")
			end
		end
	end)

	
	-- 初始化注册按钮
	self:initRegisterButton()
	
	-- 初始化登陆按钮
	self:initLoginButton()


	-- 初始化快速登陆按钮
	self:initQuickLoginButton()

	--self:initWeibo()

end


function QuickLoginPanel:initWeibo(  )

-- 初始化anysdk登陆
	local user_plugin = AnySDK.getInstance():getUserPlugin()
	local function onActionListener( pPlugin, code, msg )
		print("on user action listener.")
	    if code == UserActionResultCode.kInitSuccess then
	        --do something
	        print("初始化成功")
	    end
	    --处理回调函数	
		if code == UserActionResultCode.kLoginSuccess  then   --登陆成功回调
		    --登陆成功后，游戏相关处理
		    print("登陆成功后，游戏相关处理")
		end
		if code == UserActionResultCode.kLoginTimeOut  then   --登陆失败回调
		    --登陆失败后，游戏相关处理
		    print("登陆超时后，游戏相关处理")
		end
		if code == UserActionResultCode.kLoginCancel  then   --登陆取消回调
		    --登陆失败后，游戏相关处理
		    print("登陆取消后，游戏相关处理")
		end
		if code == UserActionResultCode.kLoginFail  then   --登陆失败回调
		    --登陆失败后，游戏相关处理
		    print("登陆失败后，游戏相关处理")
		end
	end
	user_plugin:setActionListener(onActionListener)

	self.weiboBtn = self:getChildByName("weibo")
	self.weiboBtn:addTouchEventListener(function ( node, eventType )
		if eventType == 2 then
			print(user_plugin)
			print(AnySDK.getInstance():getFrameworkVersion())
			if nil ~= user_plugin then
			    user_plugin:login()
			    print("-------")
			end

		end
	end)

	
end


function QuickLoginPanel:initRegisterButton(  )
	-- 注册按钮
	self.registerBtn = self:getChildByName("register")
	self.registerBtn:addTouchEventListener(function ( node, eventType )
		if eventType == 2 then
			print(device.model)
			print(device.platform)
			print(device.getOpenUDID())
			--device.showActivityIndicator()

			Funcs.trans(self, "app.ui.RegisterPanel", self:getParent())
		end
	end)
end

function QuickLoginPanel:initLoginButton(  )
	-- 登录按钮
	self.loginBtn = self:getChildByName("login")
	self.loginBtn:addTouchEventListener(function ( node, eventType )
		if eventType == 2 then
			-- 与服务器交互
			print("登录按钮")
			-- 检查网络状态
			if not Net.checkNetworkStatus() then
				return
			end
			
			if string.len(self.usernameBox:getString()) == 0 then
				Funcs.alert("用户名不能为空")
				return
			elseif string.len(self.passwordBox:getString()) == 0 then
				Funcs.alert("密码不能为空")
				return
			end
			local data = {}
			data["user_name"] = self.usernameBox:getString()
			data["user_password"] = self.passwordBox:getString()
			print(Net.address.post_login)
			--self:postLogin(Net.address.post_login, data)
			local onSucceed = function (  )
				SceneManager.goMainScene()
			end

			local onFailed = function (  )
				Funcs.alert("账号或密码错误")
			end

			Net.PostServer(Net.address.post_login, data, onSucceed, onFailed)

			-- --  模态视图层
			-- self.loadLayer = display.newColorLayer(cc.c4b(10, 10, 10, 100))
			-- 	:addTo(display.getRunningScene(), 20)

		end
	end)
end


function QuickLoginPanel:initQuickLoginButton(  )

	


	-- 快速登录按钮
	self.quickLogin = self:getChildByName("quickLogin")
	self.quickLogin:addTouchEventListener(function ( node, eventType )
		if eventType == 2 then
			-- 与服务器交互
			print("快速登录按钮")
			if not Net.checkNetworkStatus() then
				return
			end
			local scene = MainScene:new()
			display.replaceScene(scene, "fade", 0.5)
			print("我的天222")
			--local user_plugin = AnySDK.getInstance():getUserPlugin()
			print("------------快速登陆时候的东西-------------")
			
		end
	end)
end




function QuickLoginPanel:onResponse(event, index, dumpResponse)
	local request = event.request
	print("REQUEST %d - event.name = %s", index, event.name)
	if event.name == "completed" then
		 printf("REQUEST %d - getResponseStatusCode() = %d", index, request:getResponseStatusCode())
		 if request:getResponseStatusCode() ~= 200 then
		 else
		 	printf("REQUEST %d - getResponseDataLength() = %d", index, request:getResponseDataLength())
            print("dump:" .. tostring(dumpResponse))
            if dumpResponse then
                printf("REQUEST %d - getResponseString() =\n%s", index, request:getResponseString())
            end
		 end
	elseif event.name ~= "progress" then
		print("ErrorCode:" .. tostring(request:getErrorCode()))
        print("ErrowMsg:" .. tostring(request:getErrorMessage()))
	end

	print("----------------------------------------")
end


-- PostLogin
function QuickLoginPanel:postLogin( hostName, data )
	print("post Data to Server")
	requestCount = requestCount + 1
	local index = requestCount
	local request = network.createHTTPRequest(function ( event )
		if tolua.isnull(self) then
			print("REQUST COMPLETED, BUT SCENE HAS QUIT")
		end
		self:onResponse(event, index, false)
		if event.name == "completed" then
			local cookie = network.parseCookie(event.request:getCookieString())
			dump(cookie, "GET COOKIE FROM SERVER")
			print("这就是我要的结果")
			--print(event.request:getResponseString())
			
			local result = json.decode(event.request:getResponseString())
			print(result)
			if type(result) ~= "table" then
				print("服务器没返回正确数据")
				self.loadLayer:removeFromParent()
			end
			for k,v in pairs(result) do
				print(k,v)
			end
			if result.status == 0 then
				self.loadLayer:removeFromParent()
				Funcs.alert("账号或密码错误")
			elseif result.status == 1 then
				local scene = MainScene:new()
				display.replaceScene(scene, "fade", 0.5)
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





return QuickLoginPanel