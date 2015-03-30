--
-- Author: Your Name
-- Date: 2015-03-05 14:07:00
--
local QuickLoginLayer = import("..ui.QuickLoginPanel")


local LoginScene = class("LoginScene", function (  )
	return display.newScene("LoginScene")
end)

local panel = nil

function LoginScene:ctor(  )

	-- 添加背景
	local bg = display.newSprite("Login/splash.jpg", display.cx, display.cy)
		:addTo(self)
	local scaleX = display.width / bg:getContentSize().width
	local scaleY = display.height / bg:getContentSize().height
	bg:setScale(scaleX, scaleY)

	local bgTrans = display.newColorLayer(cc.c4b(10, 10, 10, 150))
		:addTo(self)

	-- 第一次启动时的快速登录界面
	panel = QuickLoginLayer:new( self )
		:pos(display.cx, display.cy)
		:addTo(bgTrans)
    
    

    
end


function LoginScene:trans( base , target )
	print("base:" .. base)
	print("target:" .. target)
end


return LoginScene