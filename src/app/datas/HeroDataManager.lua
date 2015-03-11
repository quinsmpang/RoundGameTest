--
-- Author: UHEVER
-- Date: 2015-03-09 16:56:29
--


module("HeroDataManager", package.seeall)

local HeroDataManagerTable = {}


function getHeroDataByIndex( idx )
	for k,v in pairs(HeroDataManagerTable) do
		if v.m_index == idx then
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
		if v.m_type == 1 then
			table.insert(front, v)
		end
	end
	return front
end
