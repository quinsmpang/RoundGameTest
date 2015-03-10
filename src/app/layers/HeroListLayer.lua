--
-- Author: UHEVER
-- Date: 2015-03-09 20:10:57
--


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
	for i=1,numHeros / 2 do
		local item = self.lvGrid:newItem()
		local content
		content = display.newNode()
		for count = 1,2 do
			local idx = (i-1)*2 + count
			local button = cc.ui.UIPushButton.new("Button01.png", {scale9 = true})
				:setButtonSize(350, 80)
				:setButtonLabel(cc.ui.UILabel.new({	
					text = idx,
					size = 30,
					align = cc.ui.TEXT_ALIGN_CENTER,
					}))
				:onButtonClicked(function (  )
					print("clickedButton")
				end)
				:align(display.CENTER, 175 + 350 * (count - 1), 40)
				:addTo(content)
				:setTouchSwallowEnabled(false)
			-- 添加头像
			local hero = HeroDataManager.getHeroDataByTable(idx)
			local id = hero:getId()
			display.newSprite("heros/hero" .. id .. ".jpg")
				:pos(175 + 350 * (count - 1) - 130, 40)
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