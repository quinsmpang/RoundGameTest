--
-- Author: UHEVER
-- Date: 2015-03-13 20:03:31
--
local EquipItemBtn = require("app.ui.EquipItemBtn")

local HeroEquipAddLayer = class("HeroEquipAddLayer", function (  )
	return display.newColorLayer(cc.c4b(10, 10, 10, 100))
end)

function HeroEquipAddLayer:ctor( heroData, equipKind, superLayer )
	-- 初始化成员变量
	self.hero = heroData
	self.superLayer = superLayer

	print("HeroEquipAddLayer kind : " .. equipKind)
	
	self.node = display.newNode()
		:pos(display.cx, display.cy)
		:addTo(self)
	self.node:scale(0.1)
	--self.node:setAnchorPoint(cc.p(1, 1))

	-- 设置可触摸
	self:setTouchEnabled(true)
	self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function ( event )
		self:removeFromParent()
	end)

	
	local listBg = display.newSprite("heros/herodetail-detail-popup.pvr.ccz", -165, 0)
		:addTo(self.node)

	self.detailBg = Funcs.newMaskedSprite("heros/package_detail_bg_alpha_mask", "heros/package_detail_bg.jpg")
		:pos(140, 0)
		:addTo(self.node)
	self.detailBg:setTouchSwallowEnabled(true)
	self.detailBg:setTouchEnabled(true)

	-- listView数据源
	local useableEquipTb, unusealbeEquipTb = EquipDataManager.getCanEquipTableByKind(heroData, equipKind)
	print("use : " .. #useableEquipTb)
	print("unuse : " .. #unusealbeEquipTb)

	-- 添加listView
	self.lvGrid = cc.ui.UIListView.new({
	--bgColor = cc.c4b(200, 200, 200, 120),
	--bg = "heros/dialog_bg.jpg",
	scrollbarImgV = "heros/scroll_bar.pvr.ccz",
	viewRect = cc.rect(15, 20, 258, 410),
	direction = cc.ui.UIScrollView.DIRECTION_VERTICAL,
	})
	:addTo(listBg, 20)

	if #useableEquipTb > 0 then
		self:addEquipList(useableEquipTb, "当前可装备")
	end
	if #unusealbeEquipTb > 0 then
		self:addEquipList(unusealbeEquipTb, "当前不可装备")
	end
	

	-- 设置出现的动画
	local action1 = cca.scaleTo(0.2, 1.15)
	local action2 = cca.scaleTo(0.15, 1.0)
	self.node:runAction(cca.seq({action1, action2}))

end

function HeroEquipAddLayer:addEquipList( equipTb, equipName )
	for i=0,#equipTb / 3 + 0.99 do
		local item = self.lvGrid:newItem()
		local content
		content = display.newNode()
		local cols = 3
		if #equipTb / i < 3 then
			cols = #equipTb - (i-1) * 3
		end

		if i == 0 then
			-- 小东西
			local titleBg = display.newSprite("heros/equip_detail_title_bg.pvr.ccz")
				:pos(129, 20)
				:addTo(content)
			titleBg:setScaleX(0.6)


			cc.ui.UILabel.new({
				text = equipName,
				color = cc.c3b(224, 207, 96),
				size = 16,
				font = "LoginPanel/DFYuanW7-GB2312.ttf",
				})
				:align(display.CENTER, 129, 20)
				:addTo(content)

			content:setContentSize(258, 40)
			item:addContent(content)
			item:setItemSize(258, 40)
			self.lvGrid:addItem(item)
		else
			for count = 1,cols do
			local idx = (i-1)*3 + count
			local equip = equipTb[idx]
			print("idx : " .. idx)

			local EquipBtn = EquipItemBtn.new(equip, nil, function (  )
				print("equipID : " .. equip.m_id)
				print("equipKind : " .. equip.m_config.kind)
				print("equipFor : " .. equip.m_config.equipHero)
				self:equipDetail(equip)
			end)
				:addTo(content)
				:pos(50 + 80 * (count - 1), 40)
			end
			content:setContentSize(258, 80)
			item:addContent(content)
			item:setItemSize(258, 80)
			self.lvGrid:addItem(item)
		end

		
		
	end
	--print("-------------------")
	self.lvGrid:reload()
end

function HeroEquipAddLayer:equipDetail( equip )
	if self.detailNode then
		self.detailNode:removeFromParent()
		self.detailNode = nil
	end

	self.detailNode = display.newNode()
		:addTo(self.detailBg)
	-- 装备图片
	local equipIcon = EquipItemBtn.new(equip, nil, nil)
		:pos(60, self.detailBg:getContentSize().height - 60)
		:addTo(self.detailNode)

	-- 装备名称
	cc.ui.UILabel.new({
		text = equip.m_config.name,
		size = 20,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		color = EquipDataManager.getTextColorByEquip(equip)
		})
		:align(display.CENTER_LEFT, 100, self.detailBg:getContentSize().height - 40)
		:addTo(self.detailNode)

	-- 强化等级
	cc.ui.UILabel.new({
		text = "强化等级: " .. equip.m_strongLv,
		size = 18,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		color = EquipDataManager.getStrongLvTextColorByEquip(equip)
		})
		:align(display.CENTER_LEFT, 100, self.detailBg:getContentSize().height - 70)
		:addTo(self.detailNode)

	-- 半透明背景
	local alphaBg = display.newScale9Sprite("heros/herodetail_name_bg.pvr.ccz", 145, self.detailBg:getContentSize().height - 180, cc.size(self.detailBg:getContentSize().width - 40, 150))
		:addTo(self.detailNode)

	-- 判断是否可装备
	if self.hero.m_lv >= equip.m_config.lv then
		-- 装备按钮
		cc.ui.UIPushButton.new({normal = "heros/package_handbook_button_1.pvr.ccz", pressed = "heros/package_handbook_button_2.pvr.ccz"}, {scale9 = true})
			:setButtonSize(120, 50)
			:setButtonLabel(cc.ui.UILabel.new({
				text = "装备",
				size = 20,
				font = "LoginPanel/DFYuanW7-GB2312.ttf",
				color = cc.c3b(251,199,94),
				}))
			:onButtonClicked(function ( event )
				print("装备按钮")
				HeroDataManager.heroEquipWithEquipment(self.hero, equip)
				local useableEquipTb, unusealbeEquipTb = EquipDataManager.getCanEquipTableByKind(self.hero, 1)
				print("use : " .. #useableEquipTb)
				print("unuse : " .. #unusealbeEquipTb)

				self.superLayer:replaceEquipByEquip(equip)
				-- 退出
				self:removeFromParent()


			end)
			:addTo(self.detailNode)
			:pos(self.detailBg:getContentSize().width / 2, 40)
	else
		cc.ui.UILabel.new({
		text = "等级到达" .. equip.m_config.lv .. "级时可装备",
		size = 18,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		color = display.COLOR_RED
		})
		:align(display.CENTER, self.detailBg:getContentSize().width / 2, 40)
		:addTo(self.detailNode)
	end
	
end

return HeroEquipAddLayer