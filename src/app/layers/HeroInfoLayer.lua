--
-- Author: UHEVER
-- Date: 2015-03-10 10:39:25
--
local HeroInfoLayer = class("HeroInfoLayer", function (  )
	return display.newColorLayer(cc.c4b(100, 100, 100, 150))
end)

function HeroInfoLayer:ctor( idx )
	print(idx)
	self.hero = HeroDataManager.getHeroDataByTable(idx)
	-- 英雄detail
	
	self.heroDetail = display.newSprite("heros/herodetail-bg.jpg")
		:pos(display.cx + 200, display.cy)
		:addTo(self)

	local closeBtn = cc.ui.UIPushButton.new("heros/herodetail-detail-close.pvr.ccz")
		:pos(800, 600)
		:onButtonClicked(function (  )
			self:removeFromParent()
		end)
		:addTo(self)

	self:showImage(hero)
	

	-- 头像
	local icon = display.newSprite(self.hero.m_config.m_icon)
		:pos(100, 350)
		:scale(2.0)
		:addTo(self.heroDetail)

	-- 名字
	local name = display.newSprite("heros/shop_refresh_button_grey.pvr.ccz")
		:pos(100, 220)
		:addTo(self.heroDetail)
	name:setScaleX(1.5)

	cc.ui.UILabel.new({
		text = self.hero.m_config.m_name,
		size = 20,
		})
		:align(display.CENTER, 100, 220)
		:addTo(self.heroDetail)

	-- 等级
	cc.ui.UILabel.new({
		text = "等级 : " .. self.hero.m_lv,
		size = 20,
		})
		:align(display.CENTER ,70, 180)
		:addTo(self.heroDetail)

	-- 经验
	cc.ui.UILabel.new({
		text = "经验 : " .. self.hero.m_experience,
		size = 20,
		})
		:align(display.CENTER ,70, 160)
		:addTo(self.heroDetail)

	for i=1,3 do
		local cols = 2
		-- if i==3 then
		-- 	cols = 1
		-- end
		for j=1,cols do
			display.newSprite("heros/gocha.pvr.ccz")
				:scale(0.8)
				:pos(270 + 70 * (j - 1), 370 - 70 * (i - 1))
				:addTo(self.heroDetail)
		end
	end


	-- 三个按钮
	-- 详细信息
	self.detailBtn = cc.ui.UIPushButton.new({normal = "heros/task_button.pvr.ccz", pressed = "heros/task_button_press.pvr.ccz"}, {scale9 = true})
		:setButtonSize(120, 40)
		:setButtonLabel(cc.ui.UILabel.new({
			text = "详细属性",
			size = 20,
			}))
		:onButtonClicked(function (  )
			
		end)
		:align(display.CENTER, 70, 40)
		:addTo(self.heroDetail)

	-- 图鉴
	self.detailBtn = cc.ui.UIPushButton.new({normal = "heros/task_button.pvr.ccz", pressed = "heros/task_button_press.pvr.ccz"}, {scale9 = true})
		:setButtonSize(100, 40)
		:setButtonLabel(cc.ui.UILabel.new({
			text = "图鉴",
			size = 20,
			}))
		:onButtonClicked(function (  )
			self:showImage()
		end)
		:align(display.CENTER, 200, 40)
		:addTo(self.heroDetail)


	-- 技能升级
	self.detailBtn = cc.ui.UIPushButton.new({normal = "heros/task_button.pvr.ccz", pressed = "heros/task_button_press.pvr.ccz"}, {scale9 = true})
		:setButtonSize(120, 40)
		:setButtonLabel(cc.ui.UILabel.new({
			text = "技能升级",
			size = 20,
			}))
		:onButtonClicked(function (  )
			self:skillUpdate()
		end)
		:align(display.CENTER, 320, 40)
		:addTo(self.heroDetail)

end

function HeroInfoLayer:showImage(  )
	-- 英雄大图
	if self.heroImg then
		return 
	end
	self.heroImg = display.newSprite(self.hero.m_config.m_image)
		:pos(display.cx - 200, display.cy)
		:scale(0.8)
		:addTo(self)
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