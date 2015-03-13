--
-- Author: UHEVER
-- Date: 2015-03-12 16:16:17
--

module("EquipDataManager", package.seeall)

local EquipDataManagerTable = {}

function addEquipDataToTable( equipData )
	local num = #EquipDataManagerTable
	EquipDataManagerTable[num + 1] = equipData
end

-- 获取已经装备到身上的装备
function getEquipedDataByIndex( idx )
	if idx == -1 then
		return -1
	end

	for i,v in ipairs(EquipDataManagerTable) do
		if v.m_index == idx then
			local temp = v
			table.remove(EquipDataManagerTable, i)
			return temp
		end
	end

	return -1
end


-- 判断是否有多余的装备，但没装备上的
function isCanEquip( heroData, equipIdx )
	for i,v in ipairs(EquipDataManagerTable) do
		if heroData.m_lv >= v.m_config.lv and v.m_config.kind == equipIdx then
			-- 再判断是否为绑定装备（如金箍棒只能猴子使用）
			--print("我的天")
			if v.m_config.equipHero ~= 0 then
				if v.m_config.equipHero == heroData.m_id then
					return true
				end
			-- 如果不是绑定类型的装备
			else
				return true
			end
		end
	end

	return false
end

-- 获取所有装备
function getAllEquips(  )
	return EquipDataManagerTable
end