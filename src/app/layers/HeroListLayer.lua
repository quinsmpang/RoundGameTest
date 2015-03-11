--
-- Author: UHEVER
-- Date: 2015-03-09 20:10:57
--

local HeroListItem = require("app.ui.HeroListItem")

local HeroListLayer = class("HeroListLayer", function (  )
	return display.newLayer()
end)


HeroListLayer.CHECKBOX_BUTTON_IMAGES = {
	off = "heros/classbtn.pvr.ccz",
    off_pressed = "heros/classbtnselected.pvr.ccz",
    on_pressed = "heros/classbtnselected.pvr.ccz",
    on = "heros/classbtnselected.pvr.ccz",
}

function HeroListLayer:ctor(  )

	-- 背景图片
	local bg = display.newSprite("heros/bg.jpg", display.cx, display.cy)
		:addTo(self)
	local scaleX = display.width / bg:getContentSize().width
	local scaleY = display.height / bg:getContentSize().height
	bg:setScale(scaleX, scaleY)

	-- 返回按钮
	local backBtn = cc.ui.UIPushButton.new({normal = "heros/backbtn.pvr.ccz", pressed = "heros/backbtn-disabled.pvr.ccz"})
		:onButtonClicked(function (  )
			self:removeFromParent()
		end)
		:pos(display.left + 60, display.top - 40)
		:addTo(self)

	-- 英雄列表背景
	local listBg = display.newSprite("heros/herolist.pvr.ccz", display.cx - 30, display.cy - 30)
		:addTo(self, 10)

	listBg:setScaleX(1.3)
	listBg:setScaleY(1.5)

	-- 添加右侧按钮
	self:createTabItems()


	-- 初始化裂变
	self.lvGrid = cc.ui.UIListView.new({
	--bgColor = cc.c4b(200, 200, 200, 120),
	--bg = "heros/dialog_bg.jpg",
	scrollbarImgV = "heros/scroll_bar.pvr.ccz",
	viewRect = cc.rect(display.cx - 350 - 30, display.cy - 175 - 65, 700, 430),
	direction = cc.ui.UIScrollView.DIRECTION_VERTICAL,
	})
	:addTo(self, 20)

	-- 得到所有数据
	local heros = HeroDataManager.getAllHeros()

	self:initListView(heros)
end


function HeroListLayer:createTabItems(  )
	-- 前中后排按钮
	-- 全部
	local allItem = cc.ui.UICheckBoxButton.new(HeroListLayer.CHECKBOX_BUTTON_IMAGES, {scale9 = true})
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
		end)
		:setButtonLabelAlignment(display.CENTER)
		:pos(display.right - 110, 480)
		:addTo(self, 15)

	self.selectedItem = allItem

	-- 前排
	local frontItem = cc.ui.UICheckBoxButton.new(HeroListLayer.CHECKBOX_BUTTON_IMAGES, {scale9 = true})
		:setButtonLabel("off", cc.ui.UILabel.new({
			text = "前排",
			size = 20,
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			}))
		:setButtonLabel("on",cc.ui.UILabel.new({
			text = "前排",
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

			local heros = HeroDataManager.getAllFrontHeros()
			self:initListView(heros)
		end)
		:setButtonLabelAlignment(display.CENTER)
		:pos(display.right - 110, 420)
		:addTo(self)

	-- 中排
	local middleItem = cc.ui.UICheckBoxButton.new(HeroListLayer.CHECKBOX_BUTTON_IMAGES, {scale9 = true})
		:setButtonLabel("off", cc.ui.UILabel.new({
			text = "中排",
			size = 20,
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			}))
		:setButtonLabel("on",cc.ui.UILabel.new({
			text = "中排",
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
		end)
		:setButtonLabelAlignment(display.CENTER)
		:pos(display.right - 110, 360)
		:addTo(self)

	-- 后排
	local behindItem = cc.ui.UICheckBoxButton.new(HeroListLayer.CHECKBOX_BUTTON_IMAGES, {scale9 = true})
		:setButtonLabel("off", cc.ui.UILabel.new({
			text = "后排",
			size = 20,
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			}))
		:setButtonLabel("on",cc.ui.UILabel.new({
			text = "后排",
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
		end)
		:setButtonLabelAlignment(display.CENTER)
		:pos(display.right - 110, 300)
		:addTo(self)

end

function HeroListLayer:initListView( heros )
	self.lvGrid:cleanup()
	self.lvGrid:reload()
	print(#heros)
	for i=1,#heros / 2 + 0.5 do
		local item = self.lvGrid:newItem()
		local content
		content = display.newNode()
		local cols = 2
		if #heros / i < 2 then
			cols = 1
		end
		for count = 1,cols do
			local idx = (i-1)*2 + count
			local hero = HeroDataManager.getHeroDataByTable(idx)
			local listItem = HeroListItem.new(hero, idx)
				:align(display.CENTER, 180 + 340 * (count - 1), 60)
				:addTo(content)
		end
		content:setContentSize(700, 130)
		item:addContent(content)
		item:setItemSize(700, 130)
		self.lvGrid:addItem(item)
	end
	self.lvGrid:reload()
end


return HeroListLayer