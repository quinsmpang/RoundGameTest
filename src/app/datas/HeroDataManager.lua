--
-- Author: UHEVER
-- Date: 2015-03-09 16:56:29
--


module("HeroDataManager", package.seeall)

HeroDataManagerTable = {}

function initHeroDataManager(  )
	HeroDataManagerTable = {}
end

function getHeroDataByIndex( idx )
	for k,v in pairs(HeroDataManagerTable) do
		if tonumber(v.m_index) == idx then
			return v
		end
	end

	return nil
end

function getHeroDataById( id )
	for k,v in pairs(HeroDataManagerTable) do
		if tonumber(v.m_id) == id then
			return v
		end
	end

	return nil
end

function addHeroDataToTable( heroData )
	local num = #HeroDataManagerTable
	--print("num = " .. num)
	HeroDataManagerTable[num + 1] = heroData
end


function desc(  )
	print("-----------HeroDataManager---(size = " .. HeroDataManager.getSize() .. ")---------")
	for k,v in pairs(HeroDataManagerTable) do
		v:desc()
	end
	print("-----------HeroDataManager------------")
end

function clearHeroDataTable(  )
	HeroDataManagerTable = {}
end

function getHeroDataByTable( idx )
	return HeroDataManagerTable[idx]
end

-- 得到所有英雄
function getAllHeros(  )
	return HeroDataManagerTable
end

-- 获取所有前排英雄
function getAllFrontHeros(  )
	local front = {}
	for k,v in pairs(HeroDataManagerTable) do
		if tonumber(v.m_config.type) == 1 then
			table.insert(front, v)
		end
	end
	return front
end

-- 获取所有中排英雄
function getAllMiddleHeros(  )
	local middle = {}
	for k,v in pairs(HeroDataManagerTable) do
		if tonumber(v.m_config.type) == 2 then
			table.insert(middle, v)
		end
	end
	return middle
end

-- 获取所有后排英雄
function getAllBehindHeros(  )
	local behind = {}
	for k,v in pairs(HeroDataManagerTable) do
		if tonumber(v.m_config.type) == 3 then
			table.insert(behind, v)
		end
	end
	return behind
end


-- 装备武器(英雄, 装备) 可实现换装和新增装备
function loadEquipWithEquipment( heroData, equipData )
	-- 信息交换
	local heroIndex = heroData.m_index
	local equipIndex = equipData.m_index
	local kind = tonumber(equipData.m_config.kind)
	
	for i,v in ipairs(HeroDataManagerTable) do
		print(i,v)
	end
	local currentEquip = heroData.m_equips[kind]
	heroData.m_equips[kind] = equipData
	for i,v in ipairs(HeroDataManagerTable) do
		if v.m_index == heroIndex then
			HeroDataManagerTable[i] = heroData
			-- 删除EquipDataManager里的对应装备
			EquipDataManager.removeEquipDataByEquip(equipData)

			-- 如果是卸下装备，讲卸下的装备放入manager中
			if currentEquip ~= -1 then
				EquipDataManager.addEquipDataToTable(currentEquip) 
			end
			break
		end
	end
end


-- 卸下装备
function unloadEquipWithEquipment( heroData, equipData )
	local heroIndex = heroData.m_index
	local equipIndex = equipData.m_index
	local kind = tonumber(equipData.m_config.kind)

	heroData.m_equips[kind] = -1
	for i,v in ipairs(HeroDataManagerTable) do
		if v.m_index == heroIndex then
			HeroDataManagerTable[i] = heroData
			EquipDataManager.addEquipDataToTable(equipData)
			break
		end
	end

end


-- 战斗力

