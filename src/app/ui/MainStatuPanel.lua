--
-- Author: UHEVER
-- Date: 2015-03-20 12:24:12
--
local RechargeLayer = require("app.layers.RechargeLayer")

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

	cc.ui.UILabel.new({
		text = UserData.gold,
		size = 22,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		align = cc.ui.TEXT_ALIGN_RIGHT,
		})
		:align(display.BOTTOM_RIGHT, 130, coinBar:getContentSize().height - 33)
		--:pos(100, coinBar:getContentSize().height - 20)
		:addTo(coinBar)

	-- 钻石
	local diamondbar = display.newScale9Sprite("heros/main_status_number_bg.pvr.ccz", 200, 0, cc.size(180, 46))
		:addTo(self)
	display.newSprite("heros/task_rmb_icon_2.pvr.ccz")
		:pos(diamondbar:getContentSize().width - 25, diamondbar:getContentSize().height - 25)
		:scale(1.2)
		:addTo(diamondbar)

	cc.ui.UILabel.new({
		text = UserData.diamond,
		size = 22,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		align = cc.ui.TEXT_ALIGN_RIGHT,
		})
		:align(display.BOTTOM_RIGHT, 130, coinBar:getContentSize().height - 33)
		:addTo(diamondbar)

	cc.ui.UIPushButton.new({normal = "heros/main_status_plus_icon_1.pvr.ccz", pressed = "heros/main_status_plus_icon_2.pvr.ccz"})
		:onButtonClicked(function ( event )
			local layer = RechargeLayer.new()
				:addTo(display.getRunningScene(), 20)
		end)
		:pos(23, 23)
		:addTo(diamondbar)


	-- 体力
	local vitbar = display.newScale9Sprite("heros/main_status_number_bg.pvr.ccz", 400, 0, cc.size(180, 46))
		:addTo(self)
	display.newSprite("heros/task_vit_icon_2.pvr.ccz")
		:pos(vitbar:getContentSize().width - 25, vitbar:getContentSize().height - 25)
		:scale(1.2)
		:addTo(vitbar)

	cc.ui.UILabel.new({
		text = UserData.energy,
		size = 22,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		align = cc.ui.TEXT_ALIGN_RIGHT,
		})
		:align(display.BOTTOM_RIGHT, 130, coinBar:getContentSize().height - 33)
		:addTo(vitbar)

	cc.ui.UIPushButton.new({normal = "heros/main_status_plus_icon_1.pvr.ccz", pressed = "heros/main_status_plus_icon_2.pvr.ccz"})
		:pos(23, 23)
		:addTo(vitbar)

end

return MainStatuPanel