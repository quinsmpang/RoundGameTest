--
-- Author: UHEVER
-- Date: 2015-03-10 14:30:18
--
local HeroConfig = class("HeroConfig")

function HeroConfig:ctor(  )
	self.m_icon = nil
	self.m_image = nil
	self.m_id = nil
	self.m_name = nil
end

function HeroConfig:getName(  )
	return self.m_name
end

return HeroConfig