--
-- Author: UHEVER
-- Date: 2015-03-10 10:39:25
--
local HeroInfoLayer = class("HeroInfoLayer", function (  )
	return display.newColorLayer(cc.c4b(100, 100, 100, 150))
end)

function HeroInfoLayer:ctor( idx )
	print(idx)
	local hero = HeroDataManager.getHeroDataByTable(idx)
	display.newSprite("heros/hero" .. hero:getId() .. ".jpg")
		:pos(display.cx, display.cy)
		:scale(2.0)
		:addTo(self)


	local closeBtn = cc.ui.UIPushButton.new("heros/ic_com_sina_weibo_sdk_close.png")
		:pos(800, 600)
		:onButtonClicked(function (  )
			self:removeFromParent()
		end)
		:addTo(self)

end

return HeroInfoLayer