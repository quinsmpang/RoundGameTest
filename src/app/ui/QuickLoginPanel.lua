--
-- Author: Your Name
-- Date: 2015-03-05 17:12:00
--

-- 注册面板
local RegisterPanel = import(".RegisterPanel")

local MainScene = import("..scenes.MainScene")


local QuickLoginPanel = class("QuickLoginPanel", function (  )
	local node = cc.CSLoader:createNode("QuickLoginPanel.csb")
	node:setAnchorPoint(cc.p(0.5, 0.5))
	return node
end)

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

	-- 注册按钮
	self.registerBtn = self:getChildByName("register")
	self.registerBtn:addTouchEventListener(function ( node, eventType )
		if eventType == 2 then
			Funcs.trans(self, "app.ui.RegisterPanel", self:getParent())
		end
	end)

	-- 登录按钮
	self.loginBtn = self:getChildByName("login")
	self.loginBtn:addTouchEventListener(function ( node, eventType )
		if eventType == 2 then
			-- 与服务器交互
			print("登录按钮")
			if string.len(self.usernameBox:getString()) == 0 then
				Funcs.alert("用户名不能为空")
			elseif string.len(self.passwordBox:getString()) == 0 then
				Funcs.alert("密码不能为空")
			end
		end
	end)

	-- 快速登录按钮
	self.quickLogin = self:getChildByName("quickLogin")
	self.quickLogin:addTouchEventListener(function ( node, eventType )
		if eventType == 2 then
			-- 与服务器交互
			print("快速登录按钮")

			local scene = MainScene:new()
			display.replaceScene(scene, "fade", 0.5)
		end
	end)


end

return QuickLoginPanel