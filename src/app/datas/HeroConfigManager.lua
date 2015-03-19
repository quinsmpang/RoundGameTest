--
-- Author: UHEVER
-- Date: 2015-03-10 14:34:09
--
module("HeroConfigManager", package.seeall)

HeroConfigManagerTable = require("app.datas.HeroConfig")


function getHeroConfigById( id )
	for k,v in pairs(HeroConfigManagerTable) do
		if tonumber(v.id) == id then
			return v
		end
	end
	return nil
end



function getSize(  )
	return #HeroConfigManagerTable
end