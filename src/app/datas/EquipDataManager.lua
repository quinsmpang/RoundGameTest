--
-- Author: UHEVER
-- Date: 2015-03-12 16:16:17
--

module("EquipDataManager", package.seeall)

local EquipDataManagerTable = {}

local equipColor = {}
equipColor.white = cc.c3b(220, 220, 220)
equipColor.green = cc.c3b(84, 122, 17)
equipColor.blue = cc.c3b(0, 177, 198)
equipColor.purple = cc.c3b(204, 78, 203)
equipColor.orange = cc.c3b(221, 151, 1)

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


-- 判断是否有多余的装备，但没装备上的  返回值（1: 有可以装备的, 2: 等级不够, false: 没有装备）
function isCanEquip( heroData, equipKind )
	local isYellow = false
	for i,v in ipairs(EquipDataManagerTable) do
		if v.m_config.kind == equipKind then
			-- 再判断是否为绑定装备（如金箍棒只能猴子使用）
			if v.m_config.equipHero ~= 0 then
				if v.m_config.equipHero == heroData.m_id then
					if heroData.m_lv >= v.m_config.lv then
						return 1
					else
						isYellow = 2
					end
				end
			else
				if heroData.m_lv >= v.m_config.lv then
					return 1
				else
					isYellow = 2
				end
			end
		end
	end

	return isYellow
end


-- 获取可装备的列表返回值tb1, tb2 （tb1为可装备，tb2等级不够不可装备）
function getCanEquipTableByKind( heroData, equipKind )
	local tb1 = {}
	local tb2 = {}

	for i,v in ipairs(EquipDataManagerTable) do
		if v.m_config.kind == equipKind then
			-- 再判断是否为绑定装备（如金箍棒只能猴子使用）
			if v.m_config.equipHero ~= 0 then
				if v.m_config.equipHero == heroData.m_id then
					if heroData.m_lv >= v.m_config.lv then
						table.insert(tb1, v)
					else
						table.insert(tb2, v)
					end
				end
			else
				if heroData.m_lv >= v.m_config.lv then
					table.insert(tb1, v)
				else
					table.insert(tb2, v)
				end
			end
		end
	end
	return tb1, tb2

end


-- 获取装备文字颜色
function getTextColorByEquip( equipData )
	if equipData.m_config.lv >= 50 then
		return equipColor.orange
	elseif equipData.m_config.lv >= 40 then
		return equipColor.purple
	elseif equipData.m_config.lv >= 30 then
		return equipColor.blue
	elseif equipData.m_config.lv >= 10 then
		return equipColor.green
	elseif equipData.m_config.lv >= 0 then
		return equipColor.white
	end
end

-- 获取装备强化等级颜色
function getStrongLvTextColorByEquip( equipData )
	if equipData.m_strongLv >= 5 then
		return equipColor.orange
	elseif equipData.m_strongLv >= 4 then
		return equipColor.purple
	elseif equipData.m_strongLv >= 3 then
		return equipColor.blue
	elseif equipData.m_strongLv >= 2 then
		return equipColor.green
	elseif equipData.m_strongLv >= 1 then
		return equipColor.white
	end
end


-- 从table中删除一件装备
function removeEquipDataByEquip( equipData )
	for i,v in ipairs(EquipDataManagerTable) do
		if v.m_index == equipData.m_index then
			table.remove(EquipDataManagerTable, i)
			break
		end
	end
end

-- -- 从table中添加一件装备
-- function addEquipDataWithEquip( equipData )
-- 	table.insert(EquipDataManagerTable, equipData)
-- end

-- 获取所有装备
function getAllEquips(  )
	return EquipDataManagerTable
end