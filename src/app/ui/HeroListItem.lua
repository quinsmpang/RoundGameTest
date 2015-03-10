--
-- Author: UHEVER
-- Date: 2015-03-09 21:03:01
--

local HeroInfoLayer = require("app.layers.HeroInfoLayer")

local HeroListItem = class("HeroListItem", function (  )
	return display.newNode()
end)

function HeroListItem:ctor( hero, idx )
	local button = cc.ui.UIPushButton.new("Button01.png", {scale9 = true})
		:setButtonSize(350, 80)
		:setButtonLabel(cc.ui.UILabel.new({	
			text = hero:getId(),
			size = 30,
			align = cc.ui.TEXT_ALIGN_CENTER,
			}))
		:onButtonClicked(function (  )
			print("clickedButton" .. idx)
			local layer = HeroInfoLayer.new(idx)
				:addTo(display.getRunningScene())
		end)
		:addTo(self)
		:setTouchSwallowEnabled(false)
	-- 添加头像
	--local hero = HeroDataManager.getHeroDataByTable(idx)
	--local id = hero:getId()
	display.newSprite("heros/hero" .. hero:getId() .. ".jpg")
		:pos(0, 0)
		:scale(0.8)
		:addTo(self)
end

return HeroListItem