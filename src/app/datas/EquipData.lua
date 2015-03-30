--
-- Author: UHEVER
-- Date: 2015-03-12 13:26:09
--
local EquipData = class("EquipData")

function EquipData:ctor(  )
	-- 服务器标示
	self.m_index = nil
	-- 物品id
	self.m_id = nil
	-- 强化等级
	self.m_strongLv = nil

	-- 资源信息
	self.m_config = nil
end

return EquipData