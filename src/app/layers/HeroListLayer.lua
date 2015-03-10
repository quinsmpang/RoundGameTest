--
-- Author: UHEVER
-- Date: 2015-03-09 20:10:57
--

local HeroListItem = require("app.ui.HeroListItem")

local HeroListLayer = class("HeroListLayer", function (  )
	return display.newLayer()
end)

function HeroListLayer:ctor(  )

	-- 背景图片
	local bg = display.newSprite("heros/bg.jpg", display.cx, display.cy)
		:addTo(self)
	local scaleX = display.width / bg:getContentSize().width
	local scaleY = display.height / bg:getContentSize().height
	bg:setScale(scaleX, scaleY)

	-- 返回按钮
	local backBtn = cc.ui.UIPushButton.new({normal = "heros/backbtn.pvr.ccz", pressed = "heros/backbtn-disabled.pvr.ccz"})
		:onButtonClicked(function (  )
			self:removeFromParent()
		end)
		:pos(display.left + 60, display.top - 40)
		:addTo(self)


	local listBg = display.newSprite("heros/herolist.pvr.ccz", display.cx - 30, display.cy - 30)
		:addTo(self)
	listBg:setScaleX(1.3)
	listBg:setScaleY(1.5)
	self.lvGrid = cc.ui.UIListView.new({
		--bgColor = cc.c4b(200, 200, 200, 120),
		--bg = "heros/dialog_bg.jpg",
		scrollbarImgV = "heros/scroll_bar.pvr.ccz",
		viewRect = cc.rect(display.cx - 350 - 30, display.cy - 175 - 65, 700, 430),
		direction = cc.ui.UIScrollView.DIRECTION_VERTICAL,
		})
		:addTo(self)

	local numHeros = HeroDataManager.getSize()
	print(numHeros)
	for i=1,numHeros / 2 + 0.5 do
		local item = self.lvGrid:newItem()
		local content
		content = display.newNode()
		local cols = 2
		if numHeros / i < 2 then
			cols = 1
		end
		for count = 1,cols do
			local idx = (i-1)*2 + count
			local hero = HeroDataManager.getHeroDataByTable(idx)
			local listItem = HeroListItem.new(hero, idx)
				:align(display.CENTER, 180 + 340 * (count - 1), 60)
				:addTo(content)
		end
		content:setContentSize(700, 130)
		item:addContent(content)
		item:setItemSize(700, 130)
		self.lvGrid:addItem(item)
	end
	self.lvGrid:reload()
end





return HeroListLayer