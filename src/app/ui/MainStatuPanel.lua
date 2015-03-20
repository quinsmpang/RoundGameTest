--
-- Author: UHEVER
-- Date: 2015-03-20 12:24:12
--
local MainStatuPanel = class("MainStatuPanel", function (  )
	return display.newNode()
end)


function MainStatuPanel:ctor(  )
	-- 金币条
	local coinBar = display.newScale9Sprite("heros/main_status_number_bg.pvr.ccz", 0, 0, cc.size(180, 46))
		:addTo(self)
	display.newSprite("heros/shop_gold_icon.pvr.ccz")
		:pos(coinBar:getContentSize().width - 25, coinBar:getContentSize().height - 20)
		:addTo(coinBar)

	local diamondbar = display.newScale9Sprite("heros/main_status_number_bg.pvr.ccz", 200, 0, cc.size(180, 46))
		:addTo(self)
	display.newSprite("heros/task_rmb_icon_2.pvr.ccz")
		:pos(diamondbar:getContentSize().width - 25, diamondbar:getContentSize().height - 25)
		:scale(1.2)
		:addTo(diamondbar)

	local vitbar = display.newScale9Sprite("heros/main_status_number_bg.pvr.ccz", 400, 0, cc.size(180, 46))
		:addTo(self)
	display.newSprite("heros/task_vit_icon_2.pvr.ccz")
		:pos(vitbar:getContentSize().width - 25, vitbar:getContentSize().height - 25)
		:scale(1.2)
		:addTo(vitbar)

end

return MainStatuPanel