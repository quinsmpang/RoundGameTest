--
-- Author: UHEVER
-- Date: 2015-03-24 17:30:31
--
module("ExpConfigManager", package.seeall)

ExpConfigManagerTable = require("app.datas.ExpConfig")

function getTotalExpByHeroLevel( level )
	if type(level) ~= "number" then
		print("level must be number")
		return 1
	end
	for i,v in ipairs(ExpConfigManagerTable) do
		if level == tonumber(v.lv) then
			return tonumber(v.exp)
		end
	end
	return 1
end