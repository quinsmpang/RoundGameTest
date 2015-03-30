--
-- Author: UHEVER
-- Date: 2015-03-23 14:57:32
--
local OpActLayer = class("OpActLayer", function (  )
	return display.newColorLayer(cc.c4b(10, 10, 10, 100))
end)

function OpActLayer:ctor(  )


	-- self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function ( event )
	-- 	self:removeFromParent()
	-- end)


	
	-- 创建左边和右边的背景
	self.contentBg = Funcs.newMaskedSprite("heros/act_list_future_bg_alpha_mask", "heros/act_list_future_bg.jpg")
		:pos(display.cx - 150, display.cy)
		:addTo(self)

	self.listBg = Funcs.newMaskedSprite("heros/act_list_bg_alpha_mask", "heros/act_list_bg.jpg")
		:addTo(self)
		:pos(display.cx + 230, display.cy)

	-- 精彩活动
	cc.ui.UILabel.new({
			text = "精彩活动",
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			size = 18,
			align = cc.ui.TEXT_ALIGN_CENTER,
			color = cc.c3b(229, 207, 91)
			})
			:align(display.CENTER,self.listBg:getContentSize().width / 2, 400)
			:addTo(self.listBg)

	-- 关闭按钮
	cc.ui.UIPushButton.new("heros/herodetail-detail-close.pvr.ccz")
		:onButtonClicked(function ( event )
			self:removeFromParent()
		end)
		:pos(self.listBg:getContentSize().width - 10, self.listBg:getContentSize().height - 10)
		:addTo(self.listBg, 10)
end


return OpActLayer