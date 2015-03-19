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
	-- 图片信息(Table)
	self.m_config = nil
	-- 装备信息(Table)
	self.m_equips = {-1, -1, -1, -1, -1}


end

-- 气血
function HeroData:getBlood(  )
	local blood = self.m_physique * 10 + self.m_power * 3 + self.m_mana * 1 + self.m_endurance * 2
	return blood
end

-- 伤害
function HeroData:getDamage(  )
	local damage = self.m_power * 1
	return damage
end

-- 灵力
function HeroData:getAnima(  )
	local anima = self.m_physique * 0.3 + self.m_power * 0.2 + self.m_mana * 1 + self.m_endurance * 0.1
	return anima
end

-- 防御
function HeroData:getDefence(  )
	local defence = self.m_endurance * 1
	return defence
end


----------------------------通过武器获得的属性-----------------------------

-- 通过四维计算的所带的气血, 伤害， 灵力， 防御
function HeroData:getEquipBaseAttr(  )
	local attr = {}
	-- 四维
	attr.physique = 0
	attr.power = 0
	attr.mana = 0
	attr.endurance = 0
	-- 通过四维计算的属性
	attr.blood = 0
	attr.damage = 0
	attr.anima = 0
	attr.defence = 0

	-- 本身带有的属性
	attr.base_blood = 0
	attr.base_damage = 0
	attr.base_anima = 0
	attr.base_defence = 0

	for i,v in ipairs(self.m_equips) do
		if v ~= -1 then
			if tonumber(v.m_config.addphysique) then
				attr.physique = tonumber(v.m_config.addphysique)
				attr.blood = attr.blood + tonumber(v.m_config.addphysique) * 10
				attr.anima = attr.anima + tonumber(v.m_config.addphysique) * 0.3
			end
			if tonumber(v.m_config.addpower) then
				attr.power = tonumber(v.m_config.addpower)
				attr.blood = attr.blood + tonumber(v.m_config.addpower) * 3
				attr.damage = attr.damage + tonumber(v.m_config.addpower) * 1
				attr.anima = attr.anima + tonumber(v.m_config.addpower) * 0.2
			end
			if tonumber(v.m_config.addmana) then
				attr.mana = tonumber(v.m_config.addmana)
				attr.blood = attr.blood + tonumber(v.m_config.addmana) * 1
				attr.anima = attr.anima + tonumber(v.m_config.addmana) * 1
			end
			if tonumber(v.m_config.addendurance) then
				attr.endurance = tonumber(v.m_config.addendurance)
				attr.blood = attr.blood + tonumber(v.m_config.addendurance) * 2
				attr.anima = attr.anima + tonumber(v.m_config.addendurance) * 0.1
				attr.defence = attr.defence + tonumber(v.m_config.addendurance) * 0.1
			end

			-- 本身带有的属性
			if tonumber(v.m_config.addblood) then
				attr.base_blood = attr.base_blood + tonumber(v.m_config.addblood)
			end
			if tonumber(v.m_config.adddamage) then
				attr.base_damage = attr.base_damage + tonumber(v.m_config.adddamage)
			end
			if tonumber(v.m_config.addanima) then
				attr.base_anima = attr.base_anima + tonumber(v.m_config.addanima)
			end
			if tonumber(v.m_config.adddefence) then
				attr.base_defence = attr.base_defence + tonumber(v.m_config.adddefence)
			end

		end
	end
	return attr
end

-- -- 本身带有的 伤害， 灵力， 防御
-- function HeroData:getEquipAddInfo(  )
-- 	local attr = {}
-- 	attr.damage = 0
-- 	attr.anima = 0
-- 	attr.defence = 0
-- 	for i,v in ipairs(self.m_equips) do
-- 		if v ~= -1 then
-- 			if tonumber(v.m_config.adddamage) then
-- 				attr.damage = attr.damage + tonumber(v.m_config.adddamage)
-- 			end
-- 			if tonumber(v.m_config.addanima) then
-- 				attr.anima = attr.anima + tonumber(v.m_config.addanima)
-- 			end
-- 			if tonumber(v.m_config.adddefence) then
-- 				attr.defence = attr.defence + tonumber(v.m_config.adddefence)
-- 			end
-- 		end
-- 	end
-- 	return attr
-- end


----------------------------通过武器获得的属性-----------------------------


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