--
-- Author: UHEVER
-- Date: 2015-03-09 15:56:14
--
local HeroData = class("HeroData")
local HeroConfig = require("app.datas.HeroConfig")

function HeroData:ctor(  )
	-- index
	self.m_index = nil
	-- id
	self.m_id = nil
	-- 等级
	self.m_lv = 0
	-- 前中后排 1.前  2.中  3.后
	self.m_type = 0
	-- 体质
	self.m_physique = 0
	-- 力量
	self.m_power = 0
	-- 法力
	self.m_mana = 0
	-- 耐力
	self.m_endurance = 0
	-- 经验值
	self.m_experience = 0
	-- 额外点数
	self.m_extraPoint = 0

	self.m_config = nil


end

-- 气血
function HeroData:getBlood(  )
	local blood = self.m_physique * 10 + self.m_power * 3 + self.m_mana * 1 + self.m_endurance * 2
	return blood
end

function HeroData:desc(  )
	print("----------------------")
	print("index : " .. self.m_index)
	print("id : " .. self.m_id)
	print("lv : " .. self.m_lv)
	print("physique : " .. self.m_id)
	print("power : " .. self.m_power)
	print("mana : " .. self.m_mana)
	print("endurance : " .. self.m_endurance)
	print("experience : " .. self.m_experience)
	print("extraPoint : " .. self.m_extraPoint)
	print("blood : " .. self:getBlood())
	print("----------------------")
end

function HeroData:getId(  )
	return self.m_id
end

function HeroData:getConfig(  )
	return self.m_config
end

return HeroData