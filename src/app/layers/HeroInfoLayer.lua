--
-- Author: UHEVER
-- Date: 2015-03-10 10:39:25
--
local HeroInfoLayer = class("HeroInfoLayer", function (  )
	return display.newColorLayer(cc.c4b(10, 10, 10, 150))
end)

function HeroInfoLayer:ctor( idx )
	print(idx)
	self.hero = HeroDataManager.getHeroDataByTable(idx)
	-- 英雄detail
	
	self.heroDetailBg = display.newSprite("heros/herodetail-bg.jpg")
		:pos(display.cx + 200, display.cy)
		:addTo(self)

	-- 关闭按钮
	local closeBtn = cc.ui.UIPushButton.new("heros/herodetail-detail-close.pvr.ccz")
		:pos(self.heroDetailBg:getContentSize().width - 10, self.heroDetailBg:getContentSize().height - 10)
		:onButtonClicked(function (  )
			self:removeFromParent()
		end)
		:addTo(self.heroDetailBg)

	self:showImage(hero)
	

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
	local detailBtn = cc.ui.UIPushButton.new({normal = "heros/task_button.pvr.ccz", pressed = "heros/task_button_press.pvr.ccz"}, {scale9 = true})
		:setButtonSize(120, 40)
		:setButtonLabel(cc.ui.UILabel.new({
			text = "详细属性",
			size = 20,
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			}))
		:onButtonClicked(function (  )
			
		end)
		:align(display.CENTER, 70, 40)
		:addTo(self.heroDetailBg)

	-- 图鉴
	local picInfoBtn = cc.ui.UIPushButton.new({normal = "heros/task_button.pvr.ccz", pressed = "heros/task_button_press.pvr.ccz"}, {scale9 = true})
		:setButtonSize(100, 40)
		:setButtonLabel(cc.ui.UILabel.new({
			text = "图鉴",
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			size = 20,
			}))
		:onButtonClicked(function (  )
			self:showImage()
		end)
		:align(display.CENTER, 200, 40)
		:addTo(self.heroDetailBg)


	-- 技能升级
	local skillUpBtn = cc.ui.UIPushButton.new({normal = "heros/task_button.pvr.ccz", pressed = "heros/task_button_press.pvr.ccz"}, {scale9 = true})
		:setButtonSize(120, 40)
		:setButtonLabel(cc.ui.UILabel.new({
			text = "技能升级",
			size = 20,
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			}))
		:onButtonClicked(function (  )
			self:skillUpdate()
		end)
		:align(display.CENTER, 320, 40)
		:addTo(self.heroDetailBg)

end


function HeroInfoLayer:showImage(  )
	-- 英雄大图

	-- 背景
	self.leftSprite = display.newSprite(self.hero.m_config.m_image)
		:pos(display.cx - 150, display.cy)
		:scale(0.6)
		:addTo(self)

	

	-- 边框
	local board = display.newSprite("heros/card_bg_green.pvr.ccz")
		:pos(self.leftSprite:getContentSize().width / 2, self.leftSprite:getContentSize().height / 2)
		:scale(1.75)
		:addTo(self.leftSprite)

	self.leftSprite:setTouchEnabled(true)
	self.leftSprite:setTouchSwallowEnabled(true)
	local isScale = false
	self.leftSprite:addNodeEventListener(cc.NODE_TOUCH_EVENT, function ( event )
		if isScale then
			isScale = false
			local scale = 1.75
			
			local spawn = cca.spawn({cca.rotateBy(0.5, 90), cca.scaleTo(0.5, 0.6), cca.moveTo(0.5, display.cx - 150, display.cy)})
			self.leftSprite:runAction(spawn)
			return 
		end
		isScale = true
		local scaleX = display.height / self.leftSprite:getContentSize().width
		local scaleY = display.width / self.leftSprite:getContentSize().height
		local spawn = cca.spawn({cca.rotateBy(0.5, -90), cca.scaleTo(0.5, scaleX, scaleY), cca.moveTo(0.5, display.cx, display.cy)})
		self.leftSprite:runAction(spawn)

	end)

	-- 技能
	for i=1,4 do
		-- 技能边框
		display.newSprite("heros/gocha.pvr.ccz")
			:addTo(self.leftSprite)
			:pos(220 + (i - 1) * 45, 30)
			:scale(0.6)
		display.newSprite("heros/skill" .. i .. ".jpg")
			:addTo(self.leftSprite)
			:scale(0.6)
			:pos(220 + (i - 1) * 45, 30)
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

end

function HeroInfoLayer:skillUpdate(  )
	if self.heroImg then
		self.heroImg:removeFromParent()
		self.heroImg = nil
		return
	end

	self.skillUpdate = display.newSprite("heros/herodetail-detail-popup.pvr.ccz")
		:pos(display.cx - 150, display.cy)
		:addTo(self)

	-- 剩余技能点
	self.skillPointLabel = cc.ui.UILabel.new({
		text = "剩余技能点: " .. self.hero.m_extraPoint,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		})
		:align(display.CENTER, 100, 400)
		:addTo(self.skillUpdate)

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
			:pos(140, 330 - (i - 1) * 80)
			:addTo(self.skillUpdate)

		display.newSprite("heros/skill" .. i .. ".jpg")
			:pos(45, 45)
			:addTo(item)
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

	
end

return HeroInfoLayer