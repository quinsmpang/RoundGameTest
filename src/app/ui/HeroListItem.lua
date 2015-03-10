--
-- Author: UHEVER
-- Date: 2015-03-09 21:03:01
--

local HeroInfoLayer = require("app.layers.HeroInfoLayer")

local HeroListItem = class("HeroListItem", function (  )
	return display.newNode()
end)

function HeroListItem:ctor( hero, idx )

	local button = cc.ui.UIPushButton.new("heros/package_hero_bg.pvr.ccz", {scale9 = true})
		:setButtonSize(244, 96)
		:onButtonClicked(function (  )
			print("clickedButton : " .. idx)
			local layer = HeroInfoLayer.new(idx)
				:addTo(display.getRunningScene())
		end)
		:scale(1.25)
		:addTo(self)
		:setTouchSwallowEnabled(false)
	

	-- 添加头像
	local icon = display.newSprite("heros/hero" .. hero:getId() .. ".jpg")
		:pos(-93, 03)
		:scale(1.1)
		:addTo(self)

	-- 头像边框
	display.newSprite("heros/hero_icon_frame_2.pvr.ccz")
		:pos(icon:getPosition())
		:scale(1.2)
		:addTo(self)

	-- 添加名字
	cc.ui.UILabel.new({
		text = hero.m_config.m_name,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		size = 20,
		align = cc.ui.TEXT_ALIGN_CENTER,
		})
		:align(display.CENTER, 60, 30)
		:addTo(self)


	-- 添加装备格子
	for i=1,5 do
		local equp = display.newSprite("heros/gocha.pvr.ccz")
			:scale(0.4)
			:pos(- 40 + (30 + 3)*i, - 30)
			:addTo(self)
	end
end

return HeroListItem