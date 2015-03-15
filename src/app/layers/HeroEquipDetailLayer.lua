--
-- Author: UHEVER
-- Date: 2015-03-15 16:44:50
--
local HeroEquipDetailLayer = class("HeroEquipDetailLayer", function (  )
	return display.newColorLayer(cc.c4b(10, 10, 10, 100))
end)

function HeroEquipDetailLayer:ctor( heroData, equipKind, superLayer )
	-- 初始化成员变量
	self.hero = heroData
	self.superLayer = superLayer

	self.node = display.newNode()
		:pos(display.cx, display.cy)
		:addTo(self)
	self.node:scale(0.1)

	-- 设置可触摸
	self:setTouchEnabled(true)
	self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function ( event )
		self:removeFromParent()
	end)


end

return HeroEquipDetailLayer