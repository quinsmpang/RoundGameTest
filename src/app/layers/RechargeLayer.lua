--
-- Author: UHEVER
-- Date: 2015-03-23 14:25:03
--
local RechargeLayer = class("RechargeLayer", function (  )
	return display.newColorLayer(cc.c4b(10, 10, 10, 100))
end)


function RechargeLayer:ctor(  )
	-- self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function ( event )
	-- 	self:removeFromParent()
	-- end)

	-- 签到背景框
	self.bg = display.newScale9Sprite("heros/dailylogin_frame.pvr.ccz", display.cx, display.cy, cc.size(680, 460))
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
	local banner = display.newScale9Sprite("heros/gvg_name_bg_red.pvr.ccz", 340, 420, cc.size(640, 35))
		:addTo(self.bg)

	-- 小东西
	display.newSprite("heros/equip_detail_title_bg.pvr.ccz", 340, 420)
		:addTo(self.bg)

	-- 三月签到奖励
	local month = tonumber(os.date("%m"))
	cc.ui.UILabel.new({
		text = "钻石充值",
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		size = 18,
		align = cc.ui.TEXT_ALIGN_CENTER,
		color = cc.c3b(229, 207, 91)
		})
		:align(display.CENTER,340, 420)
		:addTo(self.bg)


	self.lvGrid = cc.ui.UIListView.new({
	--bgColor = cc.c4b(200, 200, 200, 120),
	--bg = "heros/equip_frame_white.pvr.ccz",
	scrollbarImgV = "heros/scroll_bar.pvr.ccz",
	viewRect = cc.rect(20, 30, 640, 340),
	direction = cc.ui.UIScrollView.DIRECTION_VERTICAL,
	})
	:addTo(self.bg, 20)

	self:initList()


	local seq = cca.seq({cca.scaleTo(0.2, 1.2), cca.scaleTo(0.2, 1.0)})
	self.bg:runAction(seq)
end

function RechargeLayer:initList(  )

	-- recharge_list_title_bg.pvr.ccz 文字背景
	for i=1,10 / 2 + 0.5 do
		local item = self.lvGrid:newItem()
		local content
		content = display.newNode()
		local cols = 2
		if 10 / i < 2 then
			cols = 1
		end
		for count = 1,cols do
			local idx = (i-1)*2 + count
			
			local itemBg = Funcs.newMaskedSprite("heros/recharge_list_bg_alpha_mask", "heros/recharge_list_bg.jpg")
				:pos(170 + 320 * (count - 1), 50)
				:addTo(content)

			local random = math.random(1, 7)
			Funcs.newMaskedSprite("heros/recharge_diamond_icon_".. random .. "_alpha_mask", "heros/recharge_diamond_icon_".. random ..".jpg")
				:pos(48, 48)
				:addTo(itemBg)

			-- 文字背景
			display.newSprite("heros/recharge_list_title_bg.pvr.ccz")
				:pos(260, 70)
				:addTo(itemBg)

			-- 文字
		cc.ui.UILabel.new({
			text = random * 1000 .. "钻石",
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			size = 18,
			align = cc.ui.TEXT_ALIGN_CENTER,
			--color = cc.c3b(229, 207, 91)
			})
			:align(display.BOTTOM_LEFT,100, 60)
			:addTo(itemBg)

		-- rmb
		cc.ui.UILabel.new({
			text = random * 10 .. "元",
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			size = 18,
			align = cc.ui.TEXT_ALIGN_CENTER,
			--color = cc.c3b(229, 207, 91)
			color = display.COLOR_BLUE,
			})
			:align(display.BOTTOM_RIGHT,300, 60)
			:addTo(itemBg)

		-- 赠送
		cc.ui.UILabel.new({
			text = "另赠送" .. random * 10 .."钻石",
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			size = 18,
			align = cc.ui.TEXT_ALIGN_CENTER,
			--color = cc.c3b(229, 207, 91)
			color = display.COLOR_GREEN,
			})
			:align(display.BOTTOM_LEFT,100, 25)
			:addTo(itemBg)

			end
			content:setContentSize(660, 100)
			item:addContent(content)
			item:setItemSize(660, 100)
			self.lvGrid:addItem(item)
	end
	--print("-------------------")
	self.lvGrid:reload()
end

return RechargeLayer