module("EquipConfigManager", package.seeall)

EquipConfigTable = require("app.datas.EquipConfig")


-- 通过id获取资源
function getEquipConfigById( id )

	print("--------------------")
	for k,v in pairs(EquipConfigTable) do
		if tonumber(v.id) == id then
			return v
		end
	end
	return nil
end

function getEquipConfigByTbIndex( idx )
	return EquipConfigTable[idx]
end