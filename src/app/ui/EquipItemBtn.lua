--
-- Author: UHEVER
-- Date: 2015-03-12 09:59:33
--
local EquipItemBtn = {}

function EquipItemBtn.new( equipData, num, listener )
	-- 装备图片
	local button = cc.ui.UIPushButton.new(equipData.m_config.icon)
	button:onButtonPressed(function (  )
		button:setScale(0.9)
	end)
	button:onButtonClicked(function (  )
		listener()
	end)
	button:onButtonRelease(function (  )
		button:setScale(1.0)
	end)
	button:setTouchSwallowEnabled(false)

	if listener == nil then
		button:setTouchEnabled(false)
	end



	-- 装备边框
	local borderName = nil

	if equipData.m_config.lv >= 50 then
		borderName = "heros/equip_frame_orange.pvr.ccz"
	elseif equipData.m_config.lv >= 40 then
		borderName = "heros/equip_frame_purple.pvr.ccz"
	elseif equipData.m_config.lv >= 30 then
		borderName = "heros/equip_frame_blue.pvr.ccz"
	elseif equipData.m_config.lv >= 10 then
		borderName = "heros/equip_frame_green.pvr.ccz"
	else
		borderName = "heros/equip_frame_white.pvr.ccz"
	end

	display.newSprite(borderName)
		:pos(0, -1)
		:addTo(button)


	-- 装备个数
	if num then
		cc.ui.UILabel.new({
			text = num,
			size = 20,
			--color = cc.c3b(200, 207, 218),
			--font = "LoginPanel/DFYuanW7-GB2312.ttf",
			})
			:align(display.CENTER_RIGHT, 33, -20)
			:addTo(button)
	end
	return button
end

return EquipItemBtn