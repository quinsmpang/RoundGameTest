--
-- Author: UHEVER
-- Date: 2015-03-15 16:44:50
--
local EquipItemBtn = require("app.ui.EquipItemBtn")

local HeroEquipDetailLayer = class("HeroEquipDetailLayer", function (  )
	return display.newColorLayer(cc.c4b(10, 10, 10, 100))
end)


local isFirstClick = true
function HeroEquipDetailLayer:ctor( heroData, equipKind, superLayer )
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
	

	self:equipDetail(self.hero.m_equips[equipKind])
	-- 设置出现的动画
	local action1 = cca.scaleTo(0.2, 1.15)
	local action2 = cca.scaleTo(0.15, 1.0)
	self.node:runAction(cca.seq({action1, action2}))

	isFirstClick = true

end



function HeroEquipDetailLayer:addEquipList( equipTb, equipName )
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


				if isFirstClick then
					isFirstClick = false
				
				self.node:runAction(cca.seq({cca.moveTo(0.5, display.cx + 160, display.cy), cca.callFunc(function ( node )
				self.detailBg1 = Funcs.newMaskedSprite("heros/package_detail_bg_alpha_mask", "heros/package_detail_bg.jpg")
					:pos(-470, 600)
					:addTo(self.node, -1)
				self.detailBg1:setTouchSwallowEnabled(true)
				self.detailBg1:setTouchEnabled(true)
				self:equipDetail1(equip)
				self.detailBg1:runAction(cca.moveTo(0.5, -470, 0))
				end)}))
				else
					self:equipDetail1(equip)
				end
				
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




function HeroEquipDetailLayer:equipDetail( equip )
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

	-- 详细属性
	local details = self:createTextDetail(equip)
		:pos(30, 280)
		:addTo(self.detailNode)

	-- 装备介绍
	cc.ui.UILabel.new({
		text = equip.m_config.desc,
		size = 17,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		color = EquipDataManager.getTextColorByEquip(equip)
		})
		:align(display.CENTER_LEFT, 25, self.detailBg:getContentSize().height - 270)
		:addTo(self.detailNode)

	-- 判断是否可装备
	if self.hero.m_lv >= tonumber(equip.m_config.lv) then
		if istemp then
			cc.ui.UILabel.new({
			text = "(装备栏已存在其他物品,您可以在背包中用其强化其他装备,解除物品栏)",
			size = 18,
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			color = display.COLOR_RED,
			dimensions = cc.size(260, 150)
			})
			:align(display.CENTER, self.detailBg:getContentSize().width / 2, 40)
			:addTo(self.detailNode)
		else
		-- 装备按钮
		cc.ui.UIPushButton.new({normal = "heros/package_handbook_button_1.pvr.ccz", pressed = "heros/package_handbook_button_2.pvr.ccz"}, {scale9 = true})
			:setButtonSize(120, 50)
			:setButtonLabel(cc.ui.UILabel.new({
				text = "卸下",
				size = 20,
				font = "LoginPanel/DFYuanW7-GB2312.ttf",
				color = cc.c3b(251,199,94),
				}))
			:onButtonClicked(function ( event )
				print("装备按钮")
				HeroDataManager.unloadEquipWithEquipment(self.hero, equip)
				local useableEquipTb, unusealbeEquipTb = EquipDataManager.getCanEquipTableByKind(self.hero, 1)
				print("use : " .. #useableEquipTb)
				print("unuse : " .. #unusealbeEquipTb)

				self.superLayer:replaceEquipByEquip(equip, true)

				-- 退出
				self:removeFromParent()

			end)
			:addTo(self.detailNode)
			:pos(self.detailBg:getContentSize().width / 2, 40)
		end
	else
		cc.ui.UILabel.new({
		text = "等级到达" .. tonumber(equip.m_config.lv) .. "级时可装备",
		size = 18,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		color = display.COLOR_RED
		})
		:align(display.CENTER, self.detailBg:getContentSize().width / 2, 40)
		:addTo(self.detailNode)
	end
	
end


function HeroEquipDetailLayer:equipDetail1( equip )
	if self.detailNode1 then
	self.detailNode1:removeFromParent()
	self.detailNode1 = nil
	end
	
	self.detailNode1 = display.newNode()
		:addTo(self.detailBg1)
	-- 装备图片
	local equipIcon = EquipItemBtn.new(equip, nil, nil)
		:pos(60, self.detailBg1:getContentSize().height - 60)
		:addTo(self.detailNode1)

	-- 装备名称
	cc.ui.UILabel.new({
		text = equip.m_config.name,
		size = 20,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		color = EquipDataManager.getTextColorByEquip(equip)
		})
		:align(display.CENTER_LEFT, 100, self.detailBg1:getContentSize().height - 40)
		:addTo(self.detailNode1)

	-- 强化等级
	cc.ui.UILabel.new({
		text = "强化等级: " .. equip.m_strongLv,
		size = 18,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		color = EquipDataManager.getStrongLvTextColorByEquip(equip)
		})
		:align(display.CENTER_LEFT, 100, self.detailBg1:getContentSize().height - 70)
		:addTo(self.detailNode1)

	-- 半透明背景
	local alphaBg = display.newScale9Sprite("heros/herodetail_name_bg.pvr.ccz", 145, self.detailBg1:getContentSize().height - 180, cc.size(self.detailBg1:getContentSize().width - 40, 150))
		:addTo(self.detailNode1)

	-- 详细属性
	local details = self:createTextDetail(equip)
		:pos(30, 280)
		:addTo(self.detailNode1)

	-- 装备介绍
	cc.ui.UILabel.new({
		text = equip.m_config.desc,
		size = 17,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		color = EquipDataManager.getTextColorByEquip(equip)
		})
		:align(display.CENTER_LEFT, 25, self.detailBg1:getContentSize().height - 270)
		:addTo(self.detailNode1)

	-- 判断是否可装备
	if self.hero.m_lv >= tonumber(equip.m_config.lv) then
		if istemp then
			cc.ui.UILabel.new({
			text = "(装备栏已存在其他物品,您可以在背包中用其强化其他装备,解除物品栏)",
			size = 18,
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			color = display.COLOR_RED,
			dimensions = cc.size(260, 150)
			})
			:align(display.CENTER, self.detailBg1:getContentSize().width / 2, 40)
			:addTo(self.detailNode1)
		else
		-- 装备按钮
		cc.ui.UIPushButton.new({normal = "heros/package_handbook_button_1.pvr.ccz", pressed = "heros/package_handbook_button_2.pvr.ccz"}, {scale9 = true})
			:setButtonSize(120, 50)
			:setButtonLabel(cc.ui.UILabel.new({
				text = "替换",
				size = 20,
				font = "LoginPanel/DFYuanW7-GB2312.ttf",
				color = cc.c3b(251,199,94),
				}))
			:onButtonClicked(function ( event )
				print("装备按钮")
				HeroDataManager.loadEquipWithEquipment(self.hero, equip)
				local useableEquipTb, unusealbeEquipTb = EquipDataManager.getCanEquipTableByKind(self.hero, 1)
				print("use : " .. #useableEquipTb)
				print("unuse : " .. #unusealbeEquipTb)

				self.superLayer:replaceEquipByEquip(equip)

				-- 退出
				self:removeFromParent()

			end)
			:addTo(self.detailNode1)
			:pos(self.detailBg1:getContentSize().width / 2, 40)
		end
	else
		cc.ui.UILabel.new({
		text = "等级到达" .. tonumber(equip.m_config.lv) .. "级时可装备",
		size = 18,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		color = display.COLOR_RED
		})
		:align(display.CENTER, self.detailBg1:getContentSize().width / 2, 40)
		:addTo(self.detailNode1)
	end
	
end


function HeroEquipDetailLayer:createTextDetail( equip )
	local node = display.newNode()
	local tempLabel = node
	local color = EquipDataManager.getTextColorByEquip(equip)
	local createWithText = function ( text )
		local label = cc.ui.UILabel.new({
			text = text,
			size = 15,
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			color = color,
			})
			:align(display.CENTER_LEFT, tempLabel:getPositionX(), tempLabel:getPositionY() - 16)
			:addTo(node)
		tempLabel = label
	end

	
	if tonumber(equip.m_config.addphysique) > 0 then
		createWithText("体质 +" .. equip.m_config.addphysique)
	end
	if tonumber(equip.m_config.addpower) > 0 then
		createWithText("力量 +" .. equip.m_config.addpower)
	end
	if tonumber(equip.m_config.addmana) > 0 then
		createWithText("法力 +" .. equip.m_config.addmana)
	end
	if tonumber(equip.m_config.addendurance) > 0 then
		createWithText("法力 +" .. equip.m_config.addendurance)
	end
	if tonumber(equip.m_config.addblood) > 0 then
		createWithText("气血 +" .. equip.m_config.addblood)
	end
	if tonumber(equip.m_config.adddamage) > 0 then
		createWithText("伤害 +" .. equip.m_config.adddamage)
	end
	if tonumber(equip.m_config.addanima) > 0 then
		createWithText("灵力 +" .. equip.m_config.addanima)
	end
	if tonumber(equip.m_config.adddefence) > 0 then
		createWithText("防御 +" .. equip.m_config.adddefence)
	end

	return node
end

return HeroEquipDetailLayer