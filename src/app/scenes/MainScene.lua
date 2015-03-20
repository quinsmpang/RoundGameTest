--
-- Author: UHEVER
-- Date: 2015-03-09 14:39:07
--


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


local MainScene = class("MainScene", function (  )
	return display.newScene("MainScene");
end)


function MainScene:ctor(  )


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
	local bg = display.newSprite("heros/main_bg_grass_left.jpg", display.cx, display.cy)
		:addTo(self)
	bg:setScale(display.width / bg:getContentSize().width, display.height / bg:getContentSize().height)


	-- 英雄头像
	local heroIcon = display.newSprite("heros/tutorial_head_coco_alpha.jpg", 80, display.height - 80)
		:scale(0.6)
		:addTo(self)

	local heroIconBg = cc.ui.UIPushButton.new("heros/hero_icon_frame_14.pvr.ccz")
		:onButtonClicked(function (  )
			print("点击头像")
			local layer = UserInfoLayer.new()
				:addTo(self)
		end)
		:addTo(self)
		:pos(80, display.height - 80)

	-- 金钱栏
	local statuPanel = MainStatuPanel.new()
		:pos(300, 600)
		:addTo(self)




	-- 英雄按钮
	cc.ui.UIPushButton.new({normal = "heros/main_hero_button.jpg", pressed = "heros/main_hero_button_shade.jpg"})
		:pos(display.cx - 200, display.cy)
		:onButtonClicked(function (  )
			local herolayer = HeroListLayer.new()
			 	:addTo(self)
		end)
		:addTo(self)

	-- 背包按钮
	cc.ui.UIPushButton.new({normal = "heros/main_package_button.jpg", pressed = "heros/main_package_button_shade.jpg"})
		:pos(display.cx, display.cy)
		:onButtonClicked(function (  )
			local bagLayer = BagListLayer.new()
				:addTo(self)
		end)
		:addTo(self)

	-- 战斗按钮
	cc.ui.UIPushButton.new({normal = "heros/skill4.jpg", pressed = "heros/skill4.jpg"})
		:pos(display.cx + 200, display.cy)
		:onButtonClicked(function (  )
			local scene = GameScene.new()
			display.replaceScene(scene, "fade", 0.5)
		end)
		:addTo(self)


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
	print(EquipConfigManager.getEquipConfigById(1))

	

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





return MainScene