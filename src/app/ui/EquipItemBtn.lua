--
-- Author: UHEVER
-- Date: 2015-03-12 09:59:33
--
local EquipItemBtn = class("EquipItemBtn", function (  )
	return display.newNode()
end)

function EquipItemBtn:ctor( equip, num )
	-- 装备图片
	display.newSprite(equip.icon)
		:addTo(self)


	-- 装备边框
	local borderName = nil

	if equip.lv >= 50 then
		borderName = "heros/equip_frame_orange.pvr.ccz"
	elseif equip.lv >= 40 then
		borderName = "heros/equip_frame_purple.pvr.ccz"
	elseif equip.lv >= 30 then
		borderName = "heros/equip_frame_blue.pvr.ccz"
	elseif equip.lv >= 10 then
		borderName = "heros/equip_frame_green.pvr.ccz"
	else
		borderName = "heros/equip_frame_white.pvr.ccz"
	end

	display.newSprite(borderName)
		:addTo(self)


	-- 装备个数
	if num then
		cc.ui.UILabel.new({
			text = num,
			size = 20,
			--color = cc.c3b(200, 207, 218),
			--font = "LoginPanel/DFYuanW7-GB2312.ttf",
			})
			:align(display.CENTER_RIGHT, 33, -20)
			:addTo(self)
	end
end

return EquipItemBtn