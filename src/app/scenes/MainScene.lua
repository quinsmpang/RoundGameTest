--
-- Author: UHEVER
-- Date: 2015-03-09 14:39:07
--


local HeroData = require("app.datas.HeroData")
--local HeroConfig = require("app.datas.HeroConfig")

local EquipData = require("app.datas.EquipData")

require("app.datas.HeroDataManager")
require("app.datas.HeroConfigManager")
require("app.datas.EquipConfigManager")
require("app.datas.EquipDataManager")
local HeroListLayer = require("app.layers.HeroListLayer")
local BagListLayer = require("app.layers.BagListLayer")



local MainScene = class("MainScene", function (  )
	return display.newScene("MainScene");
end)


function MainScene:ctor(  )

	print("----------宋兴第五题--------------")

	-- 创建临时数组保存相同元素个数（有局限性，本数组支持4个）
	local t1 = {{}, {}, {}, {}}

	local a = {8,9,9,1,0,1,2,3,2,5,1,4,4,1,2,3}
	-- 将出现不同次数的数字放到临时数组里
	for i=1,#a do
		-- times用来表示出现相同的次数
		local times = 1
		for j=i + 1,#a do
			if a[i] == a[j] then
				-- 删除相同数字
					table.remove(a,j)
					times = times + 1
				end
		end
		-- 插入相同出现的数字到临时表
		table.insert(t1[times], a[i])
	end

	-- 第一个for循环依次从大到小取出临时二级数组
	for u=#t1,1,-1 do
		-- 这两个for循环是冒泡排序
		for i=1,#t1[u] do
			for j=1,#t1[u]-i do
				if t1[u][j+1] < t1[u][j] then
					local temp = t1[u][j+1]
					t1[u][j+1] = t1[u][j]
					t1[u][j] = temp
				end
			end
		end

		-- 冒泡排序完直接输出
		print("--------出现" .. u .. "次----------")
		for k=1,#t1[u] do
			print(t1[u][k])
		end
	end

	print("-----------宋兴第五题-------------")



	-- 背景图片
	local bg = display.newSprite("heros/main_bg_grass_left.jpg", display.cx, display.cy)
		:addTo(self)
	bg:setScale(display.width / bg:getContentSize().width, display.height / bg:getContentSize().height)

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

		EquipDataManager.addEquipDataToTable(temp)
	end

	

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