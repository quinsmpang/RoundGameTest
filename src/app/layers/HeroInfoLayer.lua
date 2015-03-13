--
-- Author: UHEVER
-- Date: 2015-03-10 10:39:25
--
local EquipItemBtn = require("app.ui.EquipItemBtn")
local HeroEquipAddLayer = require("app.layers.HeroEquipAddLayer")

local HeroInfoLayer = class("HeroInfoLayer", function (  )
	return display.newColorLayer(cc.c4b(10, 10, 10, 150))
end)


HeroInfoLayer.CHECKBOX_BUTTON_IMAGES = {
	off = "heros/stageselect_difficulty_button_normal.pvr.ccz",
    off_pressed = "heros/stageselect_difficulty_button_normal_pressed.pvr.ccz",
    on_pressed = "heros/stageselect_difficulty_button_selected_pressed.pvr.ccz",
    on = "heros/stageselect_difficulty_button_selected.pvr.ccz",
}

function HeroInfoLayer:ctor( hero )
	--print(idx)
	self.hero = hero
	-- 英雄detail
	
	self:initHeroDetailBg()

	self:showImage()
	

	

end

function HeroInfoLayer:initHeroDetailBg(  )
	self.heroDetailBg = display.newSprite("heros/herodetail-bg.jpg")
		:pos(display.cx, display.cy)
		:addTo(self, 10)

	-- 关闭按钮
	local closeBtn = cc.ui.UIPushButton.new("heros/herodetail-detail-close.pvr.ccz")
		:pos(self.heroDetailBg:getContentSize().width - 10, self.heroDetailBg:getContentSize().height - 10)
		:onButtonClicked(function (  )
			self:removeFromParent()
		end)
		:addTo(self.heroDetailBg)

	-- 头像
	local icon = display.newSprite(self.hero.m_config.icon)
		:pos(130, 330)
		:scale(2.0)
		:addTo(self.heroDetailBg)

	-- 英雄类型
	display.newSprite("heros/card_att_int_big.pvr.ccz")
		:pos(40, 220)
		:scale(0.8)
		:addTo(self.heroDetailBg)

	--名字底纹
	local nameBg = display.newSprite("heros/battle_heroes_panel.pvr.ccz")
		:pos(150, 220)
		:addTo(self.heroDetailBg)
	nameBg:setScaleX(0.25)
	nameBg:setScaleY(0.28)

	-- 名字边框
	local name = display.newSprite("heros/herodetail_name_frame_".. math.floor(self.hero.m_lv / 10 + 0.99) ..".pvr.ccz")
		--:scale(2.0)
		:pos(150, 220)
		:addTo(self.heroDetailBg)

	cc.ui.UILabel.new({
		text = self.hero.m_config.name,
		size = 20,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		align = cc.ui.TEXT_ALIGN_CENTER,
		})
		:align(display.CENTER, 150, 220)
		:addTo(self.heroDetailBg)

	-- 等级
	cc.ui.UILabel.new({
		text = "等级 : " .. self.hero.m_lv,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		size = 20,
		})
		:align(display.CENTER ,70, 180)
		:addTo(self.heroDetailBg)

	-- 经验
	cc.ui.UILabel.new({
		text = "经验 : " .. self.hero.m_experience,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		size = 20,
		})
		:align(display.CENTER ,70, 160)
		:addTo(self.heroDetailBg)

	local idx = 0
	for i=1,3 do
		
		for j=1,2 do
			idx = idx + 1
			-- 创建装备格子背景
			local itemBg = display.newSprite("heros/gocha.pvr.ccz")
				:scale(0.8)
				:addTo(self.heroDetailBg)

			-- 创建装备格子按钮
			if self.hero.m_equips[idx] ~= -1 then
				-- 显示已装备的装备（装备详情）
				local equipDetailBtn = EquipItemBtn.new(self.hero.m_equips[idx], nil, function (  )
					print("装备详情")
				end)
					:pos(itemBg:getContentSize().width / 2, itemBg:getContentSize().height / 2 + 1)
					:addTo(itemBg)
			else
				-- 查看是否有可以装备的装备(添加装备)

				-- 绿色加号
				if EquipDataManager.isCanEquip(self.hero, idx) == 1 then
					local addEquipBtn = cc.ui.UIPushButton.new("heros/herodetail-equipadd.pvr.ccz")
						:onButtonClicked(function ( event )
							print("添加装备" .. event.target:getTag())
							local layer = HeroEquipAddLayer.new(self.hero, event.target:getTag())
								:addTo(self, 30)
						end)
						:onButtonPressed(function ( event )
							event.target:setScale(0.8)
						end)
						:onButtonRelease(function ( event )
							event.target:setScale(1.2)
						end)
						:pos(itemBg:getContentSize().width / 2, itemBg:getContentSize().height / 2)
						:addTo(itemBg)
					addEquipBtn:setTag(idx)

				-- 黄色加号
				elseif EquipDataManager.isCanEquip(self.hero, idx) == 2 then
					local addEquipBtn = cc.ui.UIPushButton.new("heros/herodetail_icon_plus_yellow.pvr.ccz")
						:onButtonClicked(function ( event )
							print("添加装备(不可用)" .. event.target:getTag())
							-- local layer = HeroEquipAddLayer.new(self.hero, event.target:getTag())
							-- 	:addTo(self, 30)
						end)
						:onButtonPressed(function ( event )
							event.target:setScale(0.8)
						end)
						:onButtonRelease(function ( event )
							event.target:setScale(1.2)
						end)
						:pos(itemBg:getContentSize().width / 2, itemBg:getContentSize().height / 2)
						:addTo(itemBg)
					addEquipBtn:setTag(idx)
				else
					print("没有可用装备")
				end

			end

			if i==1 then
				itemBg:pos(305, 370)
				break
			end
			itemBg:pos(270 + 70 * (j - 1), 370 - 70 * (i - 1))

		end
	end


	-- 三个按钮

	-- 详细信息
	self.detailBtn = cc.ui.UICheckBoxButton.new(HeroInfoLayer.CHECKBOX_BUTTON_IMAGES, {scale9 = true})
		:setButtonLabel(cc.ui.UILabel.new({
			text = "详细信息",
			size = 18,
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			}))
		:setButtonSize(110, 45)
		:setButtonLabelAlignment(display.CENTER)
		:onButtonClicked(function (  )
			self.skillUpBtn:setButtonSelected(false)
			self.imgBtn:setButtonSelected(false)
			if not self.detailBtn:isButtonSelected() then
				local action1 = cca.moveTo(0.5, display.cx, display.cy)
				local action2 = cca.moveTo(0.5, display.cx, display.cy)
				self.leftSprite:runAction(cca.seq({action1, cca.callFunc(function ( node )
					node:removeFromParent()
					self.leftSprite = nil
				end)}))
				
				self.heroDetailBg:runAction(action2)

			else
				self:showHeroAttr()
				self.heroDetailBg:runAction(cca.moveTo(0.5, display.cx + 200, display.cy))
			end
		end)
		:onButtonStateChanged(function ( event )
			if event.state == "on" then
				--todo
			end
		end)
		:align(display.CENTER, 70, 40)
		:addTo(self.heroDetailBg)

	-- 图鉴
	self.imgBtn = cc.ui.UICheckBoxButton.new(HeroInfoLayer.CHECKBOX_BUTTON_IMAGES, {scale9 = true})
		:setButtonSelected(true)
		:setButtonLabel(cc.ui.UILabel.new({
			text = "图鉴",
			size = 18,
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			}))
		:setButtonSize(110, 45)
		:setButtonLabelAlignment(display.CENTER)
		:onButtonClicked(function ( event )
			self.detailBtn:setButtonSelected(false)
			self.skillUpBtn:setButtonSelected(false)
			if not self.imgBtn:isButtonSelected() then
				local action1 = cca.moveTo(0.5, display.cx, display.cy)
				local action2 = cca.moveTo(0.5, display.cx, display.cy)
				self.leftSprite:runAction(cca.seq({action1, cca.callFunc(function ( node )
					node:removeFromParent()
					self.leftSprite = nil
				end)}))
				
				self.heroDetailBg:runAction(action2)

				
			else
				self:showImage()
				self.heroDetailBg:runAction(cca.moveTo(0.5, display.cx + 200, display.cy))

			end
		end)
		:align(display.CENTER, 190, 40)
		:addTo(self.heroDetailBg)


	-- 技能升级
	self.skillUpBtn = cc.ui.UICheckBoxButton.new(HeroInfoLayer.CHECKBOX_BUTTON_IMAGES, {scale9 = true})
		:setButtonLabel(cc.ui.UILabel.new({
			text = "技能升级",
			size = 18,
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			}))
		:setButtonSize(110, 45)
		:setButtonLabelAlignment(display.CENTER)
		:onButtonClicked(function (  )
			self.detailBtn:setButtonSelected(false)
			self.imgBtn:setButtonSelected(false)
			if not self.skillUpBtn:isButtonSelected() then
				local action1 = cca.moveTo(0.5, display.cx, display.cy)
				local action2 = cca.moveTo(0.5, display.cx, display.cy)
				self.leftSprite:runAction(cca.seq({action1, cca.callFunc(function ( node )
					node:removeFromParent()
					self.leftSprite = nil
				end)}))
				
				self.heroDetailBg:runAction(action2)

			else
				self:showSkillUpdate()
				self.heroDetailBg:runAction(cca.moveTo(0.5, display.cx + 200, display.cy))
			end
		end)
		:align(display.CENTER, 310, 40)
		:addTo(self.heroDetailBg)

	-- runaction
	self.heroDetailBg:runAction(cca.moveTo(0.5, display.cx + 200, display.cy))

end

function HeroInfoLayer:showHeroAttr(  )
	if self.leftSprite then
		self.leftSprite:removeFromParent()
		self.leftSprite = nil
	end

	self.leftSprite = display.newSprite("heros/herodetail-detail-popup.pvr.ccz")
		:pos(display.cx, display.cy)
		:addTo(self)

	-- 小东西
	local titleBg = display.newSprite("heros/equip_detail_title_bg.pvr.ccz")
		:pos(self.leftSprite:getContentSize().width / 2, self.leftSprite:getContentSize().height - 40)
		:addTo(self.leftSprite)
	titleBg:setScaleX(0.6)


	cc.ui.UILabel.new({
		text = "英雄介绍",
		color = cc.c3b(224, 207, 96),
		size = 16,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		})
		:align(display.CENTER, self.leftSprite:getContentSize().width / 2, self.leftSprite:getContentSize().height - 40)
		:addTo(self.leftSprite)


	-- 英雄描述
	local descLabel = cc.ui.UILabel.new({
		text = self.hero.m_config.desc,
		--color = cc.c3b(224, 207, 96),
		size = 15,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		dimensions = cc.size(self.leftSprite:getContentSize().width - 40, 100),
		})
		:align(display.BOTTOM_LEFT, 20, self.leftSprite:getContentSize().height - 160)
		:addTo(self.leftSprite)
	

	-- 小东西
	titleBg = display.newSprite("heros/equip_detail_title_bg.pvr.ccz")
		:pos(self.leftSprite:getContentSize().width / 2, self.leftSprite:getContentSize().height - 200)
		:addTo(self.leftSprite)
	titleBg:setScaleX(0.6)


	cc.ui.UILabel.new({
		text = "英雄属性",
		color = cc.c3b(224, 207, 96),
		size = 16,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		})
		:align(display.CENTER, self.leftSprite:getContentSize().width / 2, self.leftSprite:getContentSize().height - 200)
		:addTo(self.leftSprite)

	-- 具体属性
	self:createAttrInfoRow("体质", self.hero.m_physique, 0)
		:pos(30, self.leftSprite:getContentSize().height - 240)
		:addTo(self.leftSprite)


	self:createAttrInfoRow("力量", self.hero.m_power, 0)
		:pos(30, self.leftSprite:getContentSize().height - 260)
		:addTo(self.leftSprite)

	self:createAttrInfoRow("法力", self.hero.m_mana, 0)
		:pos(30, self.leftSprite:getContentSize().height - 280)
		:addTo(self.leftSprite)

	self:createAttrInfoRow("耐力", self.hero.m_endurance, 0)
		:pos(30, self.leftSprite:getContentSize().height - 300)
		:addTo(self.leftSprite)	


	self:createAttrInfoRow("气血", self.hero:getBlood(), self.hero:getEquipBlood())
		:pos(30, self.leftSprite:getContentSize().height - 320)
		:addTo(self.leftSprite)	


	self:createAttrInfoRow("伤害", self.hero:getEquipDamage(), self.hero:getEquipDamage())
		:pos(30, self.leftSprite:getContentSize().height - 340)
		:addTo(self.leftSprite)	

	self:createAttrInfoRow("灵力", self.hero:getEquipAnima(), self.hero:getEquipAnima())
		:pos(30, self.leftSprite:getContentSize().height - 360)
		:addTo(self.leftSprite)	

	self:createAttrInfoRow("防御", self.hero:getEquipDefence(), self.hero:getEquipDefence())
		:pos(30, self.leftSprite:getContentSize().height - 380)
		:addTo(self.leftSprite)	

	-- runaction
	self.leftSprite:runAction(cca.moveTo(0.5, display.cx - 150, display.cy))
end


function HeroInfoLayer:createAttrInfoRow( attrName, baseAttr, equipAttr )
	local row = display.newNode()
	local name = cc.ui.UILabel.new({
		text = attrName .. ":",
		color = cc.c3b(197, 168, 148),
		size = 15,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		})
		:align(display.CENTER_LEFT,0, 0)
		:addTo(row)

	local base = cc.ui.UILabel.new({
		text = baseAttr,
		--color = cc.c3b(199, 189, 139),
		size = 15,
		--font = "LoginPanel/DFYuanW7-GB2312.ttf",
		})
		:align(display.CENTER_LEFT, name:getContentSize().width  + name:getPositionX() + 5, 0)
		:addTo(row)

	if equipAttr ~= 0 then
		local equip = cc.ui.UILabel.new({
		text = "+" .. equipAttr,
		color = cc.c3b(121, 146, 20),
		size = 15,
		--font = "LoginPanel/DFYuanW7-GB2312.ttf",
		})
		:align(display.CENTER_LEFT, base:getContentSize().width  + base:getPositionX() + 5, 0)
		:addTo(row)
	end
	
	return row
end


function HeroInfoLayer:showImage(  )

	if self.leftSprite then
		self.leftSprite:removeFromParent()
		self.leftSprite = nil
	end

	-- 英雄大图
	self.leftSprite = display.newSprite(self.hero.m_config.image)
		:pos(display.cx, display.cy)
		:scale(0.6)
		:addTo(self)

	--self.leftSprite:zorder(20)
	
	-- 根据英雄判断边框颜色
	local boardImgName = nil
	if self.hero.m_lv >= 120 then
		boardImgName = "heros/card_bg_orange.pvr.ccz"
	elseif self.hero.m_lv >= 70 then
		boardImgName = "heros/card_bg_purple.pvr.ccz"
	elseif self.hero.m_lv >= 40 then
		boardImgName = "heros/card_bg_blue.pvr.ccz"
	elseif self.hero.m_lv >= 20 then
		boardImgName = "heros/card_bg_green.pvr.ccz"
	else
		boardImgName = "heros/card_bg_white.pvr.ccz"
	end

	-- 边框
	local board = display.newSprite(boardImgName)
		:pos(self.leftSprite:getContentSize().width / 2, self.leftSprite:getContentSize().height / 2)
		:scale(1.75)
		:addTo(self.leftSprite)

	-- 点击放大缩小
	self.leftSprite:setTouchEnabled(true)
	self.leftSprite:setTouchSwallowEnabled(true)
	local isScale = false
	self.leftSprite:addNodeEventListener(cc.NODE_TOUCH_EVENT, function ( event )
		self.leftSprite:setTouchEnabled(false)
		if isScale then
			isScale = false
			
			local spawn = cca.spawn({cca.rotateBy(0.5, 90), cca.scaleTo(0.5, 0.6), cca.moveTo(0.5, display.cx - 150, display.cy)})
			self.leftSprite:runAction(cca.seq({spawn, cca.callFunc(function ( node )
				self.leftSprite:zorder(0)
				node:setTouchEnabled(true)
			end)}))
			return 
		end
		self.leftSprite:zorder(20)
		isScale = true
		local scaleX = display.height / self.leftSprite:getContentSize().width
		local scaleY = display.width / self.leftSprite:getContentSize().height
		local spawn = cca.spawn({cca.rotateBy(0.5, -90), cca.scaleTo(0.5, scaleX, scaleY), cca.moveTo(0.5, display.cx, display.cy)})
		self.leftSprite:runAction(cca.seq({spawn, cca.callFunc(function ( node )
			--self.leftSprite:zorder(0)
			node:setTouchEnabled(true)
		end)}))

	end)

	-- 技能
	for i=1,4 do
		-- 技能边框

		display.newSprite("heros/skill" .. i .. ".jpg")
			:addTo(self.leftSprite)
			:scale(0.6)
			:pos(220 + (i - 1) * 45, 30)
		display.newSprite("heros/equip_frame_white.pvr.ccz")
		:addTo(self.leftSprite)
		:pos(220 + (i - 1) * 45, 30)
		:scale(0.6)
	end

	-- 类型
	display.newSprite("heros/card_att_int_big.pvr.ccz")
		:pos(30, 80)
		:scale(0.8)
		:addTo(self.leftSprite)


	-- 英雄星级
	display.newSprite("heros/card_star_big.pvr.ccz")
		:pos(30, 30)
		:addTo(self.leftSprite)
		:scale(0.8)

	-- RunAction
	self.leftSprite:runAction(cca.moveTo(0.5, display.cx - 150, display.cy))

end



function HeroInfoLayer:showSkillUpdate(  )
	if self.leftSprite then
		self.leftSprite:removeFromParent()
		self.leftSprite = nil
	end

	self.leftSprite = display.newSprite("heros/herodetail-detail-popup.pvr.ccz")
		:pos(display.cx, display.cy)
		:addTo(self)

	-- 剩余技能点
	self.skillPointLabel = cc.ui.UILabel.new({
		size = 20,
		text = "剩余技能点数: " .. self.hero.m_extraPoint,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		color = cc.c3b(197, 168, 148),
		})
		:align(display.CENTER, self.leftSprite:getContentSize().width / 2, self.leftSprite:getContentSize().height - 40)
		:addTo(self.leftSprite)

	-- visible
	local visible = true
	if self.hero.m_extraPoint == 0 then
		visible = false
	end

	-- 存加技能的数组
	local skillTb = {}
	for i=1,4 do
		local item = display.newSprite("heros/recharge_list_bg.jpg")
			:scale(0.8)
			:pos(145, 330 - (i - 1) * 80)
			:addTo(self.leftSprite)

		-- 技能图片
		local skillPic = display.newSprite("heros/skill" .. i .. ".jpg")
			:pos(48, 48)
			:addTo(item)

		-- 技能边框
		display.newSprite("heros/equip_frame_white.pvr.ccz")
			:pos(skillPic:getContentSize().width / 2, skillPic:getContentSize().height / 2)
			:addTo(skillPic)

		-- 技能名称
		cc.ui.UILabel.new({
			text = "技能名称！",
			size = 18,
			})
			:align(display.BOTTOM_LEFT, 100, 60)
			:addTo(item)

		-- 技能等级
		cc.ui.UILabel.new({
			text = "技能等级: ",
			size = 18,
			})
			:align(display.BOTTOM_LEFT, 100, 20)
			:addTo(item)

		local skillLevel = cc.ui.UILabel.new({
			text = 0,
			size = 20,
			})
			:align(display.BOTTOM_LEFT, 190, 18)
			:addTo(item)
		local addItem = cc.ui.UIPushButton.new({normal = "heros/herodetail_skill_upgrade_button_1.pvr.ccz", pressed = "heros/herodetail_skill_upgrade_button_2.pvr.ccz"}, {scale9 = true})
			:pos(280, 45)
			:onButtonClicked(function (  )
				local temp = tostring(skillLevel:getString()) + 1
				self.hero.m_extraPoint = self.hero.m_extraPoint - 1
				self.skillPointLabel:setString("剩余技能点: " .. self.hero.m_extraPoint)
				skillLevel:setString(temp)
				if self.hero.m_extraPoint == 0 then
					for i=1,#skillTb do
						skillTb[i]:setVisible(false)
					end
				end
			end)
			:addTo(item)
		table.insert(skillTb, addItem)
		addItem:setVisible(visible)
	end

	self.leftSprite:runAction(cca.moveTo(0.5, display.cx - 150, display.cy))

	
end



return HeroInfoLayer