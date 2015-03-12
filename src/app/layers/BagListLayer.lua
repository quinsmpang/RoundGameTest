--
-- Author: UHEVER
-- Date: 2015-03-12 10:09:31
--
local EquipItemBtn = require("app.ui.EquipItemBtn")

local BagListLayer = class("BagListLayer", function (  )
	return display.newLayer()
end)


BagListLayer.CHECKBOX_BUTTON_IMAGES = {
	off = "heros/classbtn.pvr.ccz",
    off_pressed = "heros/classbtnselected.pvr.ccz",
    on_pressed = "heros/classbtnselected.pvr.ccz",
    on = "heros/classbtnselected.pvr.ccz",
}

function BagListLayer:ctor(  )
	local bg = display.newSprite("heros/bg.jpg", display.cx, display.cy)
		:addTo(self)
	bg:setScale(display.width / bg:getContentSize().width, display.height / bg:getContentSize().height)


	-- 返回按钮
	local backBtn = cc.ui.UIPushButton.new({normal = "heros/backbtn.pvr.ccz", pressed = "heros/backbtn-disabled.pvr.ccz"})
		:onButtonClicked(function (  )
			self:removeFromParent()
		end)
		:pos(display.left + 60, display.top - 40)
		:addTo(self)

	-- 装备列表背景
	self.listBg = display.newSprite("heros/equip_detail_bg.pvr.ccz", display.cx + 100, display.cy - 30)
		:addTo(self, 10)

	-- 物件详情
	self.listBg = Funcs.newMaskedSprite("heros/package_detail_bg_alpha_mask", "heros/package_detail_bg.jpg")
		:pos(display.cx - 280, display.cy - 30)
		:addTo(self, 10)

	self:createTabItems()

	local eq = EquipItemBtn.new(EquipConfigManager.getEquipDataByTbIndex(6), 20)
		:pos(400, 40)
		:addTo(self)
	
end


function BagListLayer:createTabItems(  )
	-- 全部
	local allItem = cc.ui.UICheckBoxButton.new(BagListLayer.CHECKBOX_BUTTON_IMAGES, {scale9 = true})
		:setButtonSelected(true)
		:setButtonLabel("off", cc.ui.UILabel.new({
			text = "全部",
			size = 20,
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			}))
		:setButtonLabel("on",cc.ui.UILabel.new({
			text = "全部",
			size = 20,
			color = cc.c3b(251,199,94),
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			}))
		:onButtonClicked(function ( event )
			-- 如果已点击
			if not event.target:isButtonSelected() then
				event.target:setButtonSelected(true)
				return 
			end

			-- 
			self.selectedItem:zorder(1)
			self.selectedItem:setButtonSelected(false)
			self.selectedItem = event.target
			self.selectedItem:zorder(15)

			--local heros = HeroDataManager.getAllHeros()
			--self:initListView(heros)
		end)
		:setButtonLabelAlignment(display.CENTER)
		:pos(display.cx + 370, 460)
		:addTo(self, 15)

	self.selectedItem = allItem

	-- 装备
	local frontItem = cc.ui.UICheckBoxButton.new(BagListLayer.CHECKBOX_BUTTON_IMAGES, {scale9 = true})
		:setButtonLabel("off", cc.ui.UILabel.new({
			text = "装备",
			size = 20,
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			}))
		:setButtonLabel("on",cc.ui.UILabel.new({
			text = "装备",
			size = 20,
			color = cc.c3b(251,199,94),
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			}))
		:onButtonClicked(function ( event )
			-- 如果已点击
			if not event.target:isButtonSelected() then
				event.target:setButtonSelected(true)
				return 
			end

			-- 
			self.selectedItem:zorder(1)
			self.selectedItem:setButtonSelected(false)
			self.selectedItem = event.target
			self.selectedItem:zorder(15)

			--local heros = HeroDataManager.getAllFrontHeros()
			--self:initListView(heros)
		end)
		:setButtonLabelAlignment(display.CENTER)
		:pos(display.cx + 370, 400)
		:addTo(self)

	-- 卷轴
	local middleItem = cc.ui.UICheckBoxButton.new(BagListLayer.CHECKBOX_BUTTON_IMAGES, {scale9 = true})
		:setButtonLabel("off", cc.ui.UILabel.new({
			text = "卷轴",
			size = 20,
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			}))
		:setButtonLabel("on",cc.ui.UILabel.new({
			text = "卷轴",
			size = 20,
			color = cc.c3b(251,199,94),
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			}))
		:onButtonClicked(function ( event )
			-- 如果已点击
			if not event.target:isButtonSelected() then
				event.target:setButtonSelected(true)
				return 
			end

			-- 
			self.selectedItem:zorder(1)
			self.selectedItem:setButtonSelected(false)
			self.selectedItem = event.target
			self.selectedItem:zorder(15)

			--local heros = HeroDataManager.getAllMiddleHeros()
			--self:initListView(heros)

		end)
		:setButtonLabelAlignment(display.CENTER)
		:pos(display.cx + 370, 340)
		:addTo(self)




	-- 灵魂石
	local behindItem = cc.ui.UICheckBoxButton.new(BagListLayer.CHECKBOX_BUTTON_IMAGES, {scale9 = true})
		:setButtonLabel("off", cc.ui.UILabel.new({
			text = "灵魂石",
			size = 20,
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			}))
		:setButtonLabel("on",cc.ui.UILabel.new({
			text = "灵魂石",
			size = 20,
			color = cc.c3b(251,199,94),
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			}))
		:onButtonClicked(function ( event )
			-- 如果已点击
			if not event.target:isButtonSelected() then
				event.target:setButtonSelected(true)
				return 
			end

			-- 
			self.selectedItem:zorder(1)
			self.selectedItem:setButtonSelected(false)
			self.selectedItem = event.target
			self.selectedItem:zorder(15)

			--local heros = HeroDataManager.getAllBehindHeros()
			--self:initListView(heros)
		end)
		:setButtonLabelAlignment(display.CENTER)
		:pos(display.cx + 370, 280)
		:addTo(self)

	-- 消耗品
	local behindItem = cc.ui.UICheckBoxButton.new(BagListLayer.CHECKBOX_BUTTON_IMAGES, {scale9 = true})
		:setButtonLabel("off", cc.ui.UILabel.new({
			text = "消耗品",
			size = 20,
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			}))
		:setButtonLabel("on",cc.ui.UILabel.new({
			text = "消耗品",
			size = 20,
			color = cc.c3b(251,199,94),
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			}))
		:onButtonClicked(function ( event )
			-- 如果已点击
			if not event.target:isButtonSelected() then
				event.target:setButtonSelected(true)
				return 
			end

			-- 
			self.selectedItem:zorder(1)
			self.selectedItem:setButtonSelected(false)
			self.selectedItem = event.target
			self.selectedItem:zorder(15)

			--local heros = HeroDataManager.getAllBehindHeros()
			--self:initListView(heros)
		end)
		:setButtonLabelAlignment(display.CENTER)
		:pos(display.cx + 370, 220)
		:addTo(self)

end


function BagListLayer:initListView( equips )

	if self.lvGrid then
		self.lvGrid:removeFromParent()
		self.lvGrid = nil
	end
		-- 初始化裂变
	self.lvGrid = cc.ui.UIListView.new({
	--bgColor = cc.c4b(200, 200, 200, 120),
	--bg = "heros/dialog_bg.jpg",
	scrollbarImgV = "heros/scroll_bar.pvr.ccz",
	viewRect = cc.rect(display.cx - 350 - 30, display.cy - 175 - 65, 700, 430),
	direction = cc.ui.UIScrollView.DIRECTION_VERTICAL,
	})
	:addTo(self, 20)


	print(#equips)
	for i=1,#equips / 2 + 0.5 do
		local item = self.lvGrid:newItem()
		local content
		content = display.newNode()
		local cols = 2
		if #equips / i < 2 then
			cols = 1
		end
		for count = 1,cols do
			local idx = (i-1)*2 + count
			--local hero = HeroDataManager.getHeroDataByTable(idx)
			local equip = equips[idx]
			--print(hero.m_type)

			-- local listItem = HeroListItem.new(hero)
			-- 	:align(display.CENTER, 180 + 340 * (count - 1), 60)
			-- 	:addTo(content)
		end
		content:setContentSize(700, 130)
		item:addContent(content)
		item:setItemSize(700, 130)
		self.lvGrid:addItem(item)
	end
	print("-------------------")
	self.lvGrid:reload()
end




return BagListLayer