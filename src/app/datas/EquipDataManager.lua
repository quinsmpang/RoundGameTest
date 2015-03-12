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


-- 获取所有装备
function getAllEquips(  )
	return EquipDataManagerTable
end