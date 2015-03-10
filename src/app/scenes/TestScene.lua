--
-- Author: UHEVER
-- Date: 2015-03-09 14:39:07
--


local HeroData = require("app.scenes.HeroData")
require("app.scenes.HeroDataManager")
local HeroListLayer = require("app.layers.HeroListLayer")

local TestScene = class("TestScene", function (  )
	return display.newScene("TestScene");
end)


function TestScene:ctor(  )

	display.newSprite("Login/splash.jpg", display.cx, display.cy)
		:addTo(self)

	local filePath = device.writablePath .. "src/app/datas/HeroData.json"
	-- local file = io.open("/Users/neworigin/code/quick/RoundGameTest/src/app/datas/HeroData.json", 'r')
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

		HeroDataManager.addHeroDataToTable(temp)
	end

	HeroDataManager.desc()

	

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