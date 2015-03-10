--
-- Author: UHEVER
-- Date: 2015-03-10 14:34:09
--
module("HeroConfigManager", package.seeall)

local HeroConfigManagerTable = {}


function getHeroConfigById( id )
	for k,v in pairs(HeroConfigManagerTable) do
		if v.m_id == id then
			return v
		end
	end

	return nil
end

function addHeroConfigToTable( heroConfig )
	local num = #HeroConfigManagerTable
	--print("num = " .. num)
	HeroConfigManagerTable[num + 1] = heroConfig
end


function getSize(  )
	return #HeroConfigManagerTable
end