--
-- Author: UHEVER
-- Date: 2015-03-10 10:39:25
--
local HeroInfoLayer = class("HeroInfoLayer", function (  )
	return display.newColorLayer(cc.c4b(10, 10, 10, 150))
end)


HeroInfoLayer.CHECKBOX_BUTTON_IMAGES = {
	off = "heros/stageselect_difficulty_button_normal.pvr.ccz",
    off_pressed = "heros/stageselect_difficulty_button_normal_pressed.pvr.ccz",
    on_pressed = "heros/stageselect_difficulty_button_selected_pressed.pvr.ccz",
    on = "heros/stageselect_difficulty_button_selected.pvr.ccz",
}

function HeroInfoLayer:ctor( idx )
	print(idx)
	self.hero = HeroDataManager.getHeroDataByTable(idx)
	-- 英雄detail
	
	self:initHeroDetailBg()

	self:showImage(hero)
	

	

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
	local icon = display.newSprite(self.hero.m_config.m_icon)
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
	local name = display.newSprite("heros/herodetail_name_frame_2.pvr.ccz")
		--:scale(2.0)
		:pos(150, 220)
		:addTo(self.heroDetailBg)

	cc.ui.UILabel.new({
		text = self.hero.m_config.m_name,
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

	for i=1,3 do
		local cols = 2
		-- if i==3 then
		-- 	cols = 1
		-- end
		for j=1,cols do
			display.newSprite("heros/gocha.pvr.ccz")
				:scale(0.8)
				:pos(270 + 70 * (j - 1), 370 - 70 * (i - 1))
				:addTo(self.heroDetailBg)
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

	local descLabel = cc.ui.UILabel.new({
		text = self.hero.m_config.m_desc,
		--color = cc.c3b(224, 207, 96),
		size = 15,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		dimensions = cc.size(self.leftSprite:getContentSize().width - 40, 100),
		})
		:align(display.BOTTOM_LEFT, 20, self.leftSprite:getContentSize().height - 160)
		:addTo(self.leftSprite)
	--descLabel:setLayoutSize(30, 300)


	-- runaction
	self.leftSprite:runAction(cca.moveTo(0.5, display.cx - 150, display.cy))
end


function HeroInfoLayer:showImage(  )

	if self.leftSprite then
		self.leftSprite:removeFromParent()
		self.leftSprite = nil
	end

	-- 英雄大图
	self.leftSprite = display.newSprite(self.hero.m_config.m_image)
		:pos(display.cx, display.cy)
		:scale(0.6)
		:addTo(self)

	--self.leftSprite:zorder(20)
	

	-- 边框
	local board = display.newSprite("heros/card_bg_green.pvr.ccz")
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
		text = "剩余技能点: " .. self.hero.m_extraPoint,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		})
		:align(display.CENTER, 100, 400)
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


		cc.ui.UILabel.new({
			text = "技能等级: ",
			size = 20,
			})
			:align(display.CENTER, 150, 50)
			:addTo(item)

		local skillLevel = cc.ui.UILabel.new({
			text = 0,
			size = 20,
			})
			:align(display.CENTER, 200, 50)
			:addTo(item)
		local addItem = cc.ui.UIPushButton.new({normal = "heros/herodetail_skill_upgrade_button_1.pvr.ccz", pressed = "heros/herodetail_skill_upgrade_button_2.pvr.ccz"}, {scale9 = true})
			:pos(280, 35)
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