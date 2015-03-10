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
	cc.ui.UIPushButton.new("heros/backbtn.pvr.ccz")
		:onButtonClicked(function (  )
			self:removeFromParent()
		end)
		:pos(20, 600)
		:addTo(self)

	display.newSprite("heros/herolist.pvr.ccz", display.cx, display.cy)
		:scale(1.5)
		--:opacity(150)
		:addTo(self)
	self.lvGrid = cc.ui.UIListView.new({
		bgColor = cc.c4b(200, 200, 200, 120),
		--bg = "heros/dialog_bg.jpg",
		scrollbarImgV = "heros/scroll_bar.pvr.ccz",
		viewRect = cc.rect(display.cx - 400, display.cy - 210, 800, 420),
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
				:align(display.CENTER, 160 + 320 * (count - 1), 50)
				:addTo(content)
		end
		content:setContentSize(650, 100)
		item:addContent(content)
		item:setItemSize(650, 100)
		self.lvGrid:addItem(item)
	end
	self.lvGrid:reload()
end





return HeroListLayer