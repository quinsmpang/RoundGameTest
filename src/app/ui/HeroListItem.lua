--
-- Author: UHEVER
-- Date: 2015-03-09 21:03:01
--

local HeroInfoLayer = require("app.layers.HeroInfoLayer")

local EquipItemBtn = require("app.ui.EquipItemBtn")

local HeroListItem = class("HeroListItem", function (  )
	return display.newNode()
end)

function HeroListItem:ctor( hero, superLayer )

	self.superLayer = superLayer

	local button = cc.ui.UIPushButton.new("heros/package_hero_bg.pvr.ccz", {scale9 = true})
		:setButtonSize(244, 96)
		:onButtonClicked(function (  )
			--print("clickedButton : " .. idx)
			local layer = HeroInfoLayer.new(hero, self.superLayer)
				:addTo(self.superLayer, 50)
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
	display.newSprite("heros/hero_icon_frame_" .. math.floor(hero.m_lv / 10 + 0.99) .. ".pvr.ccz")
		:pos(icon:getPosition())
		:scale(1.2)
		:addTo(self)

	-- 添加名字
	cc.ui.UILabel.new({
		text = hero.m_config.name,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		size = 20,
		align = cc.ui.TEXT_ALIGN_CENTER,
		})
		:align(display.CENTER, 60, 30)
		:addTo(self)


	-- 添加装备格子
	for i=1,5 do
		local equipBg = display.newSprite("heros/gocha.pvr.ccz")
			:scale(0.4)
			:pos(- 40 + (30 + 3)*i, - 30)
			:addTo(self)
		if hero.m_equips[i] ~= -1 then
			-- 显示已装备的装备
			EquipItemBtn.new(hero.m_equips[i], nil, nil)
				:pos(equipBg:getContentSize().width / 2, equipBg:getContentSize().height / 2 + 1)
				:addTo(equipBg)
		else
			-- 查看是否有可以装备的装备
			-- 返回值（1: 有可以装备的, 2: 等级不够, false: 没有装备）
			if EquipDataManager.isCanEquip(hero, i) == 1 then
				display.newSprite("heros/herodetail-equipadd.pvr.ccz")
					:pos(equipBg:getContentSize().width / 2, equipBg:getContentSize().height / 2)
					:scale(1.8)
					:addTo(equipBg)
			elseif EquipDataManager.isCanEquip(hero, i) == 2 then
				display.newSprite("heros/herodetail_icon_plus_yellow.pvr.ccz")
					:pos(equipBg:getContentSize().width / 2, equipBg:getContentSize().height / 2)
					:scale(1.8)
					:addTo(equipBg)
			end
		end
	end
end

return HeroListItem