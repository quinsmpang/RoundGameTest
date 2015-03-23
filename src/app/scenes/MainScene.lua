--
-- Author: UHEVER
-- Date: 2015-03-09 14:39:07
--


local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

local HeroData = require("app.datas.HeroData")
local EquipData = require("app.datas.EquipData")

require("app.datas.HeroDataManager")
require("app.datas.HeroConfigManager")
require("app.datas.EquipConfigManager")
require("app.datas.EquipDataManager")
require("app.datas.GameInstance")
local HeroListLayer = require("app.layers.HeroListLayer")
local BagListLayer = require("app.layers.BagListLayer")
local GameScene = require("app.scenes.GameScene")
local UserInfoLayer = require("app.layers.UserInfoLayer")
local MainStatuPanel = require("app.ui.MainStatuPanel")
local DailyRewordLayer = require("app.layers.DailyRewordLayer")
local RechargeLayer = require("app.layers.RechargeLayer")
local OpActLayer = require("app.layers.OpActLayer")
local InviteLayer = require("app.layers.InviteLayer")
local MissionLayer = require("app.layers.MissionLayer")
local TodoListLayer = require("app.layers.TodoListLayer")


local MainScene = class("MainScene", function (  )
	return display.newScene("MainScene");
end)


function MainScene:ctor(  )

	-- 初始化Manager
	EquipDataManager.initEquipDataManager()
	HeroDataManager.initHeroDataManager()
	--Funcs.main()

	-- local ttt = require("app.funcs.222")
	-- for k,v in pairs(ttt) do
	-- 	print(k)
	-- 	for k1,v1 in pairs(v) do
	-- 		print(k1,v1)
	-- 	end
	-- end
	-- print(ttt[1].id)
	print("----------宋兴第五题--------------")


	print("-----------宋兴第五题-------------")



	-- 背景图片
	local imgNum = math.random(1, 50)
	local bg = display.newSprite("bg/bg".. imgNum ..".jpg", display.cx, display.cy)
		:addTo(self)
	bg:setScale(display.width / bg:getContentSize().width, display.height / bg:getContentSize().height)

	--bg:setFilters(filter.newFilter("GRAY",{0.2, 0.3, 0.5, 0.1}))


	-- self._filterSprite = display.newFilteredSprite("bg/bg2.jpg", "GRAY",{0.2, 0.3, 0.5, 0.1})
	-- 	:align(display.CENTER, display.cx, display.cy)
	-- 	:addTo(self, 10)


	-- 英雄名字
	local userNameBg = display.newSprite("heros/main_head_name_bg_gold.pvr.ccz", 80, display.height - 155)
		:addTo(self)
	--userNameBg:setScaleX(1.3)


	cc.ui.UILabel.new({
		text = UserData.userName,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		size = 15,
		align = cc.ui.TEXT_ALIGN_CENTER,
		color = cc.c3b(229, 207, 91)
		})
		:align(display.CENTER,userNameBg:getContentSize().width / 2, userNameBg:getContentSize().height / 2)
		:addTo(userNameBg)

	-- 英雄头像
	local heroIcon = display.newSprite("heros/tutorial_head_coco_alpha.jpg", 80, display.height - 80)
		:scale(0.8)
		:addTo(self)

	local heroIconBg = cc.ui.UIPushButton.new("heros/hero_icon_frame_14.pvr.ccz")
		:onButtonClicked(function (  )
			print("点击头像")
			local layer = UserInfoLayer.new()
				:addTo(self)
		end)
		:addTo(self)
		:scale(1.25)
		:pos(80, display.height - 80)

	

	-- 金钱栏
	local statuPanel = MainStatuPanel.new()
		:pos(300, 600)
		:addTo(self)

	-- local test = display.newSprite("heros/activity_list_bg_2.pvr.ccz", display.cx - 200, display.cy + 100)
	-- 	:addTo(self)
	-- test:setAnchorPoint(cc.p(0, 0.5))
	-- test:setScaleX(0)

	-- -- 测试
	-- local testBtn = cc.ui.UICheckBoxButton.new({on = "heros/main_down_button.pvr.ccz", off = "heros/main_up_button.pvr.ccz"}, {scale9 = true})
	-- 	:pos(100, 50)
	-- 	:addTo(self)

	-- testBtn:onButtonClicked(function ( event )
	-- 	if event.target:isButtonSelected() then
	-- 		testBtn:setButtonEnabled(false)
	-- 	local seq =	cca.seq({cca.scaleTo(0.3, 1.0), cca.callFunc(function (  )
	-- 		testBtn:setButtonEnabled(true)
	-- 	end)})
	-- 	test:runAction(seq)
	-- 	else
	-- 		testBtn:setButtonEnabled(false)
	-- 		local seq =	cca.seq({cca.scaleTo(0.3, 0, 1), cca.callFunc(function (  )
	-- 		testBtn:setButtonEnabled(true)
	-- 	end)})
	-- 	test:runAction(seq)
	-- 	end
	-- end)

	self:initTitleMenu()
	self:initMenu()


	-- 初始化HeroData

	local fileUtiles = cc.FileUtils:getInstance()

	-- 初始化EquipData
	local string1 = fileUtiles:getStringFromFile("json/EquipData.json")
	local str1 = json.decode(string1)
	local equipArray = str1.EquipData
	print("equipData : " .. #equipArray)
	for k,v in pairs(equipArray) do
		local temp = EquipData.new()
		temp.m_index = v.index
		temp.m_id = v.id
		temp.m_strongLv = v.strongLv

		temp.m_config = EquipConfigManager.getEquipConfigById(v.id)
		--print("main .." .. temp.m_config)

		EquipDataManager.addEquipDataToTable(temp)
	end

	print("EquipConfigTable .. " .. #EquipConfigManager.EquipConfigTable)
	--dump(EquipConfigManager.getEquipConfigById(6))

	

	local string = fileUtiles:getStringFromFile("json/HeroData.json")
	local str = json.decode(string)
	--print(str)
	local tabArray = str.HeroData
	print(#tabArray)
	for k,v in pairs(tabArray) do
		local temp = HeroData.new()
		temp.m_index = v.index
		temp.m_id = v.id
		temp.m_lv = v.lv
		temp.m_type = v.type
		temp.m_physique = v.physique
		temp.m_power = v.power
		temp.m_mana = v.mana
		temp.m_endurance = v.endurance
		temp.m_experience = v.experience
		temp.m_extraPoint = v.extraPoint
		temp.m_config = HeroConfigManager.getHeroConfigById(v.id)
		for i=1,5 do
			temp.m_equips[i] = EquipDataManager.getEquipedDataByIndex(v.equipedIndexs[i])
		end

		HeroDataManager.addHeroDataToTable(temp)
	end


end


function MainScene:initTitleMenu(  )
	-- 签到
	cc.ui.UIPushButton.new({normal = "heros/main_dailyreward_1.pvr.ccz", pressed = "heros/main_dailyreward_2.pvr.ccz"})
		:onButtonClicked(function ( event )
			local layer = DailyRewordLayer.new()
				:addTo(self, 20)
		end)
		:pos(300, 530)
		:addTo(self)

	-- 充值
	cc.ui.UIPushButton.new({normal = "heros/main_icon_recharge_1.pvr.ccz", pressed = "heros/main_icon_recharge_2.pvr.ccz"})
		:onButtonClicked(function (  )
			local layer = RechargeLayer.new()
				:addTo(self, 20)
		end)
		:pos(400, 530)
		:addTo(self)

	-- 精彩活动
	cc.ui.UIPushButton.new({normal = "heros/main_icon_op_act_1.pvr.ccz", pressed = "heros/main_icon_op_act_2.pvr.ccz"})
		:onButtonClicked(function (  )
			local layer = OpActLayer.new()
				:addTo(self, 20)
		end)
		:pos(500, 530)
		:addTo(self)


	-- 邀请有礼
	cc.ui.UIPushButton.new({normal = "heros/main_invite_1.pvr.ccz", pressed = "heros/main_invite_2.pvr.ccz"})
		:onButtonClicked(function (  )
			local layer = InviteLayer.new()
				:addTo(self, 20)
		end)
		:pos(600, 530)
		:addTo(self)


end


function MainScene:initMenu(  )


	-- 英雄按钮
	local heroBtn = Funcs.newMaskedSprite("heros/main_hero_button_alpha_mask", "heros/main_hero_button.jpg")
		:pos(70, 70)
		:addTo(self)
	heroBtn:setTouchEnabled(true)
	heroBtn:addNodeEventListener(cc.NODE_TOUCH_EVENT, function ( event )
		local herolayer = HeroListLayer.new()
			 	:addTo(self)
	end)


	-- 背包按钮
	local bagBtn = Funcs.newMaskedSprite("heros/main_package_button_alpha_mask", "heros/main_package_button.jpg")
		:pos(170, 70)
		:addTo(self)
	bagBtn:setTouchEnabled(true)
	bagBtn:addNodeEventListener(cc.NODE_TOUCH_EVENT, function ( event )
		local bagLayer = BagListLayer.new()
				:addTo(self)
	end)


	-- 每日活动
	local dailyBtn = Funcs.newMaskedSprite("heros/main_menu_todolist_1_alpha_mask", "heros/main_menu_todolist_1.jpg")
		:pos(270, 70)
		:addTo(self)
	dailyBtn:setTouchEnabled(true)
	dailyBtn:addNodeEventListener(cc.NODE_TOUCH_EVENT, function ( event )
		local layer = TodoListLayer.new()
			:addTo(self, 20)
	end)

	-- 任务
	local taskBtn = Funcs.newMaskedSprite("heros/main_task_button_shade_alpha_mask", "heros/main_task_button.jpg")
		:pos(370, 70)
		:addTo(self)
	taskBtn:setTouchEnabled(true)
	taskBtn:addNodeEventListener(cc.NODE_TOUCH_EVENT, function ( event )
		local layer = MissionLayer.new()
			:addTo(self, 20)
	end)

	-- 碎片合成
	
	local fragmentBtn = Funcs.newMaskedSprite("heros/main_fragment_button_alpha_mask", "heros/main_fragment_button.jpg")
		:pos(470, 70)
		:addTo(self)
	fragmentBtn:setTouchEnabled(true)
	fragmentBtn:addNodeEventListener(cc.NODE_TOUCH_EVENT, function ( event )

	end)

	-- 战斗按钮
	local attackBtn = Funcs.newMaskedSprite("heros/prepare_go_battle_press_alpha_mask", "heros/prepare_go_battle.jpg")
		:pos(display.right - 80, display.bottom + 80)
		:addTo(self)
	attackBtn:setTouchEnabled(true)
	attackBtn:addNodeEventListener(cc.NODE_TOUCH_EVENT, function ( event )
		local scene = GameScene.new()
			display.replaceScene(scene, "fade", 0.5)
	end)
end




return MainScene