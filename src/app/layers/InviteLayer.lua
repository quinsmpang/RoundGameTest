--
-- Author: UHEVER
-- Date: 2015-03-23 15:16:27
--
local InviteLayer = class("InviteLayer", function (  )
	return display.newColorLayer(cc.c4b(10, 10, 10, 100))
end)

function InviteLayer:ctor(  )

	-- 背景框
	self.bg = display.newScale9Sprite("heros/dailylogin_frame.pvr.ccz", display.cx, display.cy, cc.size(585, 460))
		:scale(0.1)
		:addTo(self)

	-- 标题图片
	self.titleBg = display.newSprite("heros/invite_title_bg.pvr.ccz", self.bg:getContentSize().width / 2, self.bg:getContentSize().height - 60)
		:addTo(self.bg)

	-- 标题按钮
	cc.ui.UIPushButton.new({normal = "heros/stageselect_difficulty_button_normal.pvr.ccz", pressed = "heros/stageselect_difficulty_button_normal_pressed.pvr.ccz"}, {scale9 = true})
		:setButtonSize(120, 50)
		:setButtonLabel(cc.ui.UILabel.new({
			text = "输入邀请码",
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			size = 18,
			--align = cc.ui.TEXT_ALIGN_CENTER,
			}))
		:pos(100, 50)
		:addTo(self.titleBg)


	cc.ui.UIPushButton.new({normal = "heros/stageselect_difficulty_button_normal.pvr.ccz", pressed = "heros/stageselect_difficulty_button_normal_pressed.pvr.ccz"}, {scale9 = true})
		:setButtonSize(120, 50)
		:setButtonLabel(cc.ui.UILabel.new({
			text = "邀请好友",
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			size = 18,
			--align = cc.ui.TEXT_ALIGN_CENTER,
			}))
		:pos(250, 50)
		:addTo(self.titleBg)

	cc.ui.UIPushButton.new({normal = "heros/stageselect_difficulty_button_normal.pvr.ccz", pressed = "heros/stageselect_difficulty_button_normal_pressed.pvr.ccz"}, {scale9 = true})
		:setButtonSize(120, 50)
		:setButtonLabel(cc.ui.UILabel.new({
			text = "已邀请的人",
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			size = 18,
			--align = cc.ui.TEXT_ALIGN_CENTER,
			}))
		:pos(400, 50)
		:addTo(self.titleBg)


	-- 关闭按钮
	cc.ui.UIPushButton.new("heros/herodetail-detail-close.pvr.ccz")
		:onButtonClicked(function ( event )
			self:removeFromParent()
		end)
		:pos(self.titleBg:getContentSize().width - 10, self.titleBg:getContentSize().height - 10)
		:addTo(self.titleBg, 30)

	-- listview
	self.lvGrid = cc.ui.UIListView.new({
	--bgColor = cc.c4b(200, 200, 200, 120),
	--bg = "heros/equip_frame_white.pvr.ccz",
	scrollbarImgV = "heros/scroll_bar.pvr.ccz",
	viewRect = cc.rect(10, 25, 560, 330),
	direction = cc.ui.UIScrollView.DIRECTION_VERTICAL,
	})
	:addTo(self.bg, 20)



	self:initList()

	local seq = cca.seq({cca.scaleTo(0.2, 1.2), cca.scaleTo(0.2, 1.0)})
	self.bg:runAction(seq)
end

function InviteLayer:initList(  )
	
	for i=1,10  do
		local item = self.lvGrid:newItem()
		local content
		content = display.newNode()

		-- 添加item
		local itemBg = display.newSprite("heros/task_board.pvr.ccz")
			:pos(250, 50)
			:addTo(content)

		-- 奖励物品
		Funcs.newMaskedSprite("heros/recharge_diamond_icon_1_alpha_mask", "heros/recharge_diamond_icon_1.jpg")
			:pos(50, 50)
			:addTo(itemBg)

		-- 文字背景
		display.newSprite("heros/task_title_bg.pvr.ccz")
			:pos(250, 70)
			:addTo(itemBg)

		-- 文字
		cc.ui.UILabel.new({
			text = "成功邀请到" .. i .. "个玩家",
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			size = 18,
			align = cc.ui.TEXT_ALIGN_CENTER,
			--color = cc.c3b(229, 207, 91)
			})
			:align(display.BOTTOM_LEFT,100, 60)
			:addTo(itemBg)

		-- 奖励
		cc.ui.UILabel.new({
			text = "奖励:     " .. i .. "钻石",
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			size = 18,
			align = cc.ui.TEXT_ALIGN_CENTER,
			color = cc.c3b(100, 50, 91)
			})
			:align(display.BOTTOM_LEFT,100, 20)
			:addTo(itemBg)

		display.newSprite("heros/task_rmb_icon_2.pvr.ccz")
			:addTo(itemBg)
			:pos(170, 30)

		-- 完成任务书
		cc.ui.UILabel.new({
			text = "0/1",
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			size = 25,
			align = cc.ui.TEXT_ALIGN_CENTER,
			color = cc.c3b(100, 50, 91)
			})
			:align(display.BOTTOM_LEFT,450, 35)
			:addTo(itemBg)


		content:setContentSize(500, 100)
		item:addContent(content)
		item:setItemSize(500, 100)
		self.lvGrid:addItem(item)
	end
	print("-------------------")
	self.lvGrid:reload()
end

return InviteLayer