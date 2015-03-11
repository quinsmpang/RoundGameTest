--
-- Author: UHEVER
-- Date: 2015-03-09 14:39:07
--


local HeroData = require("app.datas.HeroData")
local HeroConfig = require("app.datas.HeroConfig")
require("app.datas.HeroDataManager")
require("app.datas.HeroConfigManager")
local HeroListLayer = require("app.layers.HeroListLayer")
local MainScene = class("MainScene", function (  )
	return display.newScene("MainScene");
end)


function MainScene:ctor(  )

	-- 背景图片
	local bg = display.newSprite("heros/main_bg_grass_left.jpg", display.cx, display.cy)
		:addTo(self)
	bg:setScale(display.width / bg:getContentSize().width, display.height / bg:getContentSize().height)


	-- 背包按钮
	cc.ui.UIPushButton.new({normal = "heros/main_package_button.jpg", pressed = "heros/main_package_button_shade.jpg"})
		:pos(display.cx, display.cy)
		:onButtonClicked(function (  )
			local herolayer = HeroListLayer.new()
			 	:addTo(self)
		end)
		:addTo(self)


	-- 初始化HeroConfig
	local filePath1 = device.writablePath .. "src/app/datas/HeroConfig.json"
	local file1 = io.open(filePath1, 'r')
	local string1 = file1:read("*all")
	file1:close()

	print(string1)
	local str1 = json.decode(string1)
	print(str1)


	local tabArray1 = str1.HeroConfig
	print(#tabArray1)
	for k,v in pairs(tabArray1) do
		local temp = HeroConfig.new()
		temp.m_icon = v.icon
		temp.m_image = v.image
		temp.m_id = v.id
		temp.m_name = v.name
		temp.m_desc = v.desc
		HeroConfigManager.addHeroConfigToTable(temp)
	end

	local t1 = {{"ccc", "iii"},"asd", "ddd"}
	local s1 = json.encode(t1)
	print(s1)

	print("------------------------------------")
	print("heroConfig: " .. HeroConfigManager.getSize())


	-- 初始化HeroData
	local filePath = device.writablePath .. "src/app/datas/HeroData.json"
	local file = io.open(filePath, 'r')
	local string = file:read("*all")
	file:close()

	print(string)
	local json = require("framework.json")
	local str = json.decode(string)
	print(str)

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

		HeroDataManager.addHeroDataToTable(temp)
	end

	--HeroDataManager.desc()

	local hero = HeroDataManager.getHeroDataByTable(2)
	print("**************")
	print(hero.m_config)


end





return MainScene