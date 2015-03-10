--
-- Author: UHEVER
-- Date: 2015-03-09 21:03:01
--

local HeroInfoLayer = require("app.layers.HeroInfoLayer")

local HeroListItem = class("HeroListItem", function (  )
	return display.newNode()
end)

function HeroListItem:ctor( hero, idx )

	--display.newSprite("heros/package_hero_bg.pvr.ccz")
	--	:addTo(self)
	local button = cc.ui.UIPushButton.new("heros/package_hero_bg.pvr.ccz", {scale9 = true})
		:setButtonSize(244, 96)
		:onButtonClicked(function (  )
			print("clickedButton : " .. idx)
			local layer = HeroInfoLayer.new(idx)
				:addTo(display.getRunningScene())
		end)
		:addTo(self)
		:setTouchSwallowEnabled(false)
	-- 添加头像
	--local hero = HeroDataManager.getHeroDataByTable(idx)
	--local id = hero:getId()
	display.newSprite("heros/hero" .. hero:getId() .. ".jpg")
		:pos(-75, 0)
		:addTo(self)

	-- 添加名字
	cc.ui.UILabel.new({
		text = hero.m_config.m_name,
		size = 20,
		})
		:pos(30, 20)
		:addTo(self)


	-- 添加装备格子
	for i=1,5 do
		local equp = display.newSprite("heros/gocha.pvr.ccz")
			:scale(0.3)
			:pos(- 30 + (20 + 3)*i, - 30)
			:addTo(self)
	end
end

return HeroListItem