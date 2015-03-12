module("EquipConfigManager", package.seeall)

local EquipConfigTable = require("app.datas.EquipConfig")


-- 通过id获取资源
function getEquipConfigById( id )
	for k,v in pairs(EquipConfigTable) do
		if v.id == id then
			return v
		end
	end

	return nil
end

function getEquipConfigByTbIndex( idx )
	return EquipConfigTable[idx]
end