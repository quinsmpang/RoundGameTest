--
-- Author: UHEVER
-- Date: 2015-03-20 10:36:12
--
--local LoginScene = require("app.scenes.LoginScene")

local UserInfoLayer = class("UserInfoLayer", function (  )
	return display.newColorLayer(cc.c4b(10, 10, 10, 100))
end)

function UserInfoLayer:ctor(  )
	self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function ( event )
		self:removeFromParent()
	end)

	local bg = Funcs.newMaskedSprite("heros/excavate_main_bg_alpha_mask", "heros/excavate_main_bg.jpg")
		:scale(0.1)
		:pos(display.cx, display.cy)
		:addTo(self)

	-- 关闭按钮
	local closeBtn = cc.ui.UIPushButton.new("heros/herodetail-detail-close.pvr.ccz")
		:pos(bg:getContentSize().width - 10, bg:getContentSize().height - 40)
		:onButtonClicked(function (  )
			print("exit")
			self:removeFromParent()
		end)
		:addTo(bg)

	bg:setTouchSwallowEnabled(true)
	bg:setTouchEnabled(true)

	cc.ui.UILabel.new({
		text = "个人信息",
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		size = 30,
		align = cc.ui.TEXT_ALIGN_CENTER,
		color = cc.c3b(229, 207, 91)
		})
		:align(display.CENTER,360, 400)
		:addTo(bg)

	local heroIcon = display.newSprite("heros/tutorial_head_coco_alpha.jpg", 100, 300)
		:scale(0.8)
		:addTo(bg)

	local heroIconBg = cc.ui.UIPushButton.new("heros/hero_icon_frame_14.pvr.ccz")
		:onButtonClicked(function (  )
		end)
		:scale(1.3)
		:addTo(bg)
		:pos(100, 300)

	-- 英雄名称
	cc.ui.UILabel.new({
		text = "探险家:" .. UserData.userName,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		size = 25,
		align = cc.ui.TEXT_ALIGN_CENTER,
		color = cc.c3b(229, 207, 91)
		})
		:align(display.CENTER_LEFT,180, 330)
		:addTo(bg)

	-- ID
	cc.ui.UILabel.new({
		text = "账号ID:" .. UserData.userId,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		size = 25,
		align = cc.ui.TEXT_ALIGN_CENTER,
		color = cc.c3b(229, 207, 91)
		})
		:align(display.CENTER_LEFT,180, 290)
		:addTo(bg)

	-- 描述文字
	local descLabel = cc.ui.UILabel.new({
		text = "勇敢的年轻探险家伊泽瑞尔已经探索过符文之地上的一些最为偏远和荒废的地区。在对古代恕瑞玛被掩埋的废墟进行探索时，他发现了一个拥有难以置信的神秘力量的护符。可能是做给某个飞升者穿戴的，这个巨大的护符紧套在他的手臂上，将他的原生魔法技术增幅到一个足以让他获得“英雄”名号的程度，让他十分尴尬。",
		color = cc.c3b(229, 207, 170),
		size = 23,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		dimensions = cc.size(bg:getContentSize().width - 40, 300),
		})
		:align(display.BOTTOM_LEFT, 20, -70)
		:addTo(bg)

	-- 注销按钮
	cc.ui.UIPushButton.new({normal = "heros/playerinfo_button_red_1.pvr.ccz", pressed = "heros/playerinfo_button_red_2.pvr.ccz"}, {scale9 = true})
		:setButtonLabel(cc.ui.UILabel.new({
			text = "注销并退出",
			size = 20,
			font = "LoginPanel/DFYuanW7-GB2312.ttf",
			color = cc.c3b(229, 207, 220),
			}))
		:onButtonClicked(function ( event )
			SceneManager.goLoginScene()
		end)
		:setButtonSize(150, 60)
		:pos(360, 50)
		:addTo(bg)

	bg:runAction(cca.seq({cca.scaleTo(0.3, 0.9), cca.scaleTo(0.2, 0.8)}))
end


return UserInfoLayer