--
-- Author: UHEVER
-- Date: 2015-03-28 15:44:45
--
local GameScene = require("app.scenes.GameScene")

local HeroSelectLayer = class("HeroSelectLayer", function (  )
	return display.newColorLayer(cc.c4b(10, 10, 10, 200))
end)

--local nowSelected = {}
local selectedBgs = {}
local selectedItems = {}

function HeroSelectLayer:ctor( index )
	self.chapterIndex = index
	selectedBgs = {}
	selectedItems = {}
	-- herilist背景
	self.heroListBg = display.newSprite("heros/herolist.pvr.ccz")
		:pos(display.cx, display.cy + 100)
		:addTo(self)

	-- 返回按钮
	cc.ui.UIPushButton.new({normal = "heros/backbtn.pvr.ccz", pressed = "heros/backbtn-disabled.pvr.ccz"})
		:onButtonClicked(function (  )
			self:removeFromParent()
		end)
		:pos(50, display.top - 50)
		:addTo(self)



	-- 已选择的英雄栏
	local selectBg = display.newSprite("heros/heroselected.pvr.ccz")
		:pos(display.cx, display.cy - 200)
		:addTo(self)

	-- 战斗力
	cc.ui.UILabel.new({
		text = "战斗力",
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		size = 18,
		align = cc.ui.TEXT_ALIGN_CENTER,
		})
		:align(display.CENTER, 50, 70)
		:addTo(selectBg)

	-- 战斗力点数
	self.fightNumber = cc.ui.UILabel.new({
		text = 0,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		size = 18,
		align = cc.ui.TEXT_ALIGN_CENTER,
		})
		:align(display.CENTER, 50, 40)
		:addTo(selectBg)

	for i=1,5 do
		local bg = Funcs.newMaskedSprite("heros/herobucket_alpha_mask", "heros/herobucket.jpg")
		:pos(160 + (i-1) * 100, 50)
		:addTo(selectBg)
		table.insert(selectedBgs, bg);
	end


	-- listView
	self.lvGrid = cc.ui.UIListView.new({
	bgColor = cc.c4b(200, 200, 200, 120),
	--bg = "heros/dialog_bg.jpg",
	scrollbarImgV = "heros/scroll_bar.pvr.ccz",
	viewRect = cc.rect(10, 10, 550, 300),
	direction = cc.ui.UIScrollView.DIRECTION_VERTICAL,
	})
	:addTo(self.heroListBg, 20)


	local heroDatas = HeroDataManager.getAllHeros()

	self:initList(heroDatas)

	self.heros = heroDatas


	-- 开始按钮
	local startBtn = Funcs.newMaskedSprite("heros/prepare_go_battle_press_alpha_mask", "heros/prepare_go_battle.jpg")
		:pos(display.width - 80, 80)
		:addTo(self)

	startBtn:setTouchEnabled(true)
	startBtn:addNodeEventListener(cc.NODE_TOUCH_EVENT, function ( event )
		if #selectedItems == 0 then
			Funcs.alert("请至少选择一名英雄进行战斗")
			return
		end

		local allHeros = {}
		for i=1,#selectedItems do
			table.insert(allHeros, self.heros[selectedItems[i]:getTag()])
		end

		local scene = GameScene.new(allHeros, self.chapterIndex)
		display.replaceScene(scene, "fade", 0.5)
	end)

end

function HeroSelectLayer:initList( heros )
	print(#heros)
	for i=1,#heros / 5 + 0.99 do
		local item = self.lvGrid:newItem()
		local content
		content = display.newNode()
		local cols = 5
		if #heros / i < 5 then
			cols = #heros % 5
		end
		for count = 1,cols do
			local idx = (i-1)*5 + count
			--local hero = HeroDataManager.getHeroDataByTable(idx)
			local hero = heros[idx]
			print(hero.m_type)

		-- 添加头像
		local icon = cc.ui.UIPushButton.new(hero.m_config.icon)
			
			:pos(70 + (count-1) * 100 , 50)
			:scale(0.7)
			:addTo(content)
		icon:setTag(idx)
		icon:onButtonPressed(function ( event )
			event.target:setScale(0.65)
		end)
		icon:onButtonRelease(function ( event )
			event.target:setScale(0.7)
		end)
		icon:onButtonClicked(function ( event )
				print(event.target:getTag())
				if event.target:getChildByName("mask") then
					event.target:getChildByName("mask"):removeFromParent()
					table.removebyvalue(selectedItems, event.target)
					self:removeHeroFromSelected(event.target:getTag())
					
					return
				end

				if #selectedItems < 5 then
					local maskBg = display.newSprite("heros/herodetail-equipmask.pvr.ccz")
					:scale(2)
					:addTo(event.target)
				maskBg:setName("mask")
				display.newSprite("heros/tick.pvr.ccz")
					:scale(0.6)
					:pos(maskBg:getContentSize().width - 20, 20)
					:addTo(maskBg)
				table.insert(selectedItems, event.target)
				self:addHeroToSelected(heros[event.target:getTag()], event.target:getTag())
				
				end

				


		end)
		icon:setTouchSwallowEnabled(false)




		-- 头像边框
		display.newSprite("heros/hero_icon_frame_" .. math.floor(hero.m_lv / 10 + 0.99) .. ".pvr.ccz")
			:pos(icon:getContentSize().width / 2, icon:getContentSize().height / 2)
			:scale(1.5)
			:addTo(icon)


		end
		content:setContentSize(550, 100)
		item:addContent(content)
		item:setItemSize(550, 100)
		self.lvGrid:addItem(item)
	end
	--print("-------------------")
	self.lvGrid:reload()
end


function HeroSelectLayer:addHeroToSelected( hero, tag )
	self:calcFightNumber()
	for i=1,#selectedBgs do
		if not selectedBgs[i]:getChildByName("have") then

			local icon = cc.ui.UIPushButton.new(hero.m_config.icon)
		:pos(50, 60)
		:scale(0.7)
		:addTo(selectedBgs[i])
	icon:setTag(tag)
	icon:setName("have")

	-- 头像边框
	display.newSprite("heros/hero_icon_frame_" .. math.floor(hero.m_lv / 10 + 0.99) .. ".pvr.ccz")
		:pos(icon:getContentSize().width / 2, icon:getContentSize().height / 2)
		:scale(1.5)
		:addTo(icon)

		return
			
		end
	end
	


end


function HeroSelectLayer:removeHeroFromSelected( tag )
	self:calcFightNumber()
	for i=1,#selectedBgs do
		if selectedBgs[i]:getChildByTag(tag) then
			selectedBgs[i]:getChildByTag(tag):removeFromParent()
		end
	end
	-- for i=1,#selectedItems do
	-- 	selectedBgs[i]:addChild(selectedItems[i])
	-- end
end

function HeroSelectLayer:calcFightNumber(  )
	local num = 0
	for i=1,#selectedItems do
		num = self.heros[selectedItems[i]:getTag()]:getFightNumber() + num
	end
	self.fightNumber:setString(num)
end

return HeroSelectLayer