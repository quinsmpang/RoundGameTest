--
-- Author: UHEVER
-- Date: 2015-03-09 20:10:57
--

local HeroListItem = require("app.ui.HeroListItem")

local HeroListLayer = class("HeroListLayer", function (  )
	return display.newColorLayer(cc.c4b(50, 50, 50, 200))
end)

function HeroListLayer:ctor(  )
	self.lvGrid = cc.ui.UIListView.new({
		bgColor = cc.c4b(200, 200, 200, 120),
		viewRect = cc.rect(100, 100, 750, 400),
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
				:align(display.CENTER, 190 + 350 * (count - 1), 40)
				:addTo(content)
		end
		content:setContentSize(750, 80)
		item:addContent(content)
		item:setItemSize(750, 80)
		self.lvGrid:addItem(item)
	end
	self.lvGrid:reload()
end





return HeroListLayer