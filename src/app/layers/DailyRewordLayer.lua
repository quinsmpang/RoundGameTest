--
-- Author: UHEVER
-- Date: 2015-03-23 13:14:19
--
local EquipItemBtn = require("app.ui.EquipItemBtn")

local DailyRewordLayer = class("DailyRewordLayer", function ( evnet )
	return display.newColorLayer(cc.c4b(10, 10, 10, 100))
end)

function DailyRewordLayer:ctor(  )
	self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function ( event )
		self:removeFromParent()
	end)

	-- 签到背景框
	self.bg = display.newScale9Sprite("heros/dailylogin_frame.pvr.ccz", display.cx, display.cy, cc.size(560, 460))
		:scale(0.1)
		:addTo(self)


	-- 关闭按钮
	cc.ui.UIPushButton.new("heros/herodetail-detail-close.pvr.ccz")
		:onButtonClicked(function ( event )
			self:removeFromParent()
		end)
		:pos(self.bg:getContentSize().width - 20, self.bg:getContentSize().height - 20)
		:addTo(self.bg, 10)

	-- banner
	local banner = display.newScale9Sprite("heros/gvg_name_bg_red.pvr.ccz", 280, 420, cc.size(530, 35))
		:addTo(self.bg)

	-- 小东西
	display.newSprite("heros/equip_detail_title_bg.pvr.ccz", 280, 420)
		:addTo(self.bg)

	-- 三月签到奖励
	local month = tonumber(os.date("%m"))
	cc.ui.UILabel.new({
		text = month .. "月签到奖励",
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		size = 18,
		align = cc.ui.TEXT_ALIGN_CENTER,
		color = cc.c3b(229, 207, 91)
		})
		:align(display.CENTER,280, 420)
		:addTo(self.bg)



	

	self.lvGrid = cc.ui.UIListView.new({
	--bgColor = cc.c4b(200, 200, 200, 120),
	--bg = "heros/equip_frame_white.pvr.ccz",
	scrollbarImgV = "heros/scroll_bar.pvr.ccz",
	viewRect = cc.rect(20, 30, 520, 340),
	direction = cc.ui.UIScrollView.DIRECTION_VERTICAL,
	})
	:addTo(self.bg, 20)

	self:initList()

	local seq = cca.seq({cca.scaleTo(0.2, 1.2), cca.scaleTo(0.2, 1.0)})
	self.bg:runAction(seq)

end

function DailyRewordLayer:initList(  )
	
	for i=1,30 / 5 + 0.99  do
		local item = self.lvGrid:newItem()
		local content
		content = display.newNode()
		local cols = 5
		if 30 / i < 5 then
			cols = 30 % 5
		end
		for count = 1,cols do
			local idx = (i-1)*3 + count
			--local hero = HeroDataManager.getHeroDataByTable(idx)

			local itemBg = display.newSprite("heros/dailylogin_matrix.pvr.ccz")
			 	:pos(60 + 100 * (count - 1), 50)
				:addTo(content)

			local item = EquipItemBtn.new(EquipDataManager.EquipDataManagerTable[1], 10, nil)
				:pos(itemBg:getContentSize().width / 2, itemBg:getContentSize().height / 2)
				:addTo(itemBg)
		end
		content:setContentSize(520, 100)
		item:addContent(content)
		item:setItemSize(520, 100)
		self.lvGrid:addItem(item)
	end
	print("-------------------")
	self.lvGrid:reload()

	--
end


return DailyRewordLayer