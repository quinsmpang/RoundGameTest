--
-- Author: UHEVER
-- Date: 2015-03-09 14:39:07
--


local HeroData = require("app.datas.HeroData")
local HeroConfig = require("app.datas.HeroConfig")
require("app.datas.HeroDataManager")
require("app.datas.HeroConfigManager")
local HeroListLayer = require("app.layers.HeroListLayer")

local TestScene = class("TestScene", function (  )
	return display.newScene("TestScene");
end)


function TestScene:ctor(  )

	display.newSprite("Login/splash.jpg", display.cx, display.cy)
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

	
	

	-- 加入按钮
	cc.ui.UIPushButton.new({normal = "Button01.png"}, {scale9 = true})
		:pos(display.cx, display.cy)
		:setButtonLabel(cc.ui.UILabel.new({
			text = "打开背包",
			size = 20,
			color = display.COLOR_WHITE,
			align = cc.ui.TEXT_ALIGN_CENTER,
			}))
		:onButtonClicked(function (  )
			local herolayer = HeroListLayer.new()
			 	:addTo(self)
		end)
		:setButtonSize(120, 40)
		:addTo(self)

		

	local aa = cc.ui.UILabel.new({
		text = "haha",
		size = 30,

		})
		:pos(display.cx, display.cy  + 100)
		:addTo(self)

 	aa:addNodeEventListener(cc.NODE_TOUCH_EVENT, function ( event )
 		print("haha")
 	end)
 	aa:setTouchEnabled(true)


end





return TestScene