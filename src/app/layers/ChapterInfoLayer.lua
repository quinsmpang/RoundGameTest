--
-- Author: UHEVER
-- Date: 2015-03-27 17:38:26
--
local ChapterInfoLayer = class("ChapterInfoLayer", function ( event )
	return display.newColorLayer(cc.c4b(10, 10, 10, 150))
end)

local chapterTb = require("app.datas.ChapterConfig")

function ChapterInfoLayer:ctor( idx )

	print(chapterTb[idx].desc)
	-- 背景框
	self.bg = display.newScale9Sprite("heros/package_herolist_bg.pvr.ccz", display.cx, display.cy, cc.size(585, 400))
		:scale(1.3)
		:addTo(self)


	-- 关闭按钮
	cc.ui.UIPushButton.new("heros/herodetail-detail-close.pvr.ccz")
		:onButtonClicked(function ( event )
			self:removeFromParent()
		end)
		:pos(self.bg:getContentSize().width - 10, self.bg:getContentSize().height - 10)
		:addTo(self.bg, 10)	

	-- 小东西
	display.newSprite("heros/equip_detail_title_bg.pvr.ccz", 280, 350)
		:addTo(self.bg)

	-- 名字
	cc.ui.UILabel.new({
		text = chapterTb[idx].name,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		size = 18,
		align = cc.ui.TEXT_ALIGN_CENTER,
		color = cc.c3b(229, 207, 91)
		})
		:align(display.CENTER,280, 350)
		:addTo(self.bg)

	-- 描述
	cc.ui.UILabel.new({
		text = chapterTb[idx].desc,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		size = 18,
		align = cc.ui.TEXT_ALIGN_CENTER,
		--color = cc.c3b(229, 207, 91)
		})
		:align(display.CENTER_LEFT,20, 300)
		:addTo(self.bg)

	-- 体力消耗
	cc.ui.UILabel.new({
		text = "体力消耗 :  " .. chapterTb[idx].needVit,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		size = 18,
		align = cc.ui.TEXT_ALIGN_CENTER,
		color = cc.c3b(197, 168, 148),
		})
		:align(display.CENTER_LEFT,20, 240)
		:addTo(self.bg)

	-- 敌方阵容
	cc.ui.UILabel.new({
		text = "敌方阵容 :  " ,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		size = 18,
		align = cc.ui.TEXT_ALIGN_CENTER,
		color = cc.c3b(197, 168, 148),
		})
		:align(display.CENTER_LEFT,20, 180)
		:addTo(self.bg)

	for i=1,#chapterTb[idx].enemys do
		--print(i)
		local enemyData = HeroDataManager.getHeroDataById(chapterTb[idx].enemys[i])
		--print(enemyData.m_config.name)
		local enemyImg = display.newSprite(enemyData.m_config.icon)
			:pos(160 + (i-1) * 90, 180)
			:scale(0.6)
			:addTo(self.bg)

		display.newSprite("heros/hero_icon_frame_1.pvr.ccz")
			:pos(160 + (i-1) * 90, 180)
			:addTo(self.bg)
	end


	-- 可能获得
	cc.ui.UILabel.new({
		text = "可能获得 :  " ,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		size = 18,
		align = cc.ui.TEXT_ALIGN_CENTER,
		color = cc.c3b(197, 168, 148),
		})
		:align(display.CENTER_LEFT,20, 100)
		:addTo(self.bg)

	for i=1,#chapterTb[idx].equips do
		print(i)
		local equipData = EquipConfigManager.getEquipConfigById(chapterTb[idx].equips[i])
		print(equipData)
		local equipImg = display.newSprite(equipData.icon)
			:pos(160 + (i-1) * 90, 80)
			:addTo(self.bg)
		display.newSprite("heros/equip_frame_white.pvr.ccz")
			:pos(160 + (i-1) * 90, 80)
			:addTo(self.bg)
	end

end


return ChapterInfoLayer