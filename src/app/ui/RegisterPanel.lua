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
			end
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

return RegisterPanel