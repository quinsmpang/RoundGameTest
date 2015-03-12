module("EquipConfigManager", package.seeall)

local EquipConfigTable = require("app.datas.EquipConfig")

function getEquipDataByTbIndex( idx )
	return EquipConfigTable[idx]
end