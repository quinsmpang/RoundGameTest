--
-- Author: UHEVER
-- Date: 2015-03-12 09:59:33
--
local SkillItemBtn = {}

function SkillItemBtn.new( heroData, idx, listener, pressListener, releaseListener )
	-- 装备图片
	local button
	if idx == 1 then
		button = cc.ui.UIPushButton.new(heroData.m_config.skill_1_icon)
	elseif idx == 2 then
		button = cc.ui.UIPushButton.new(heroData.m_config.skill_2_icon)
	elseif idx == 3 then
		button = cc.ui.UIPushButton.new(heroData.m_config.skill_3_icon)
	elseif idx == 4 then
		button = cc.ui.UIPushButton.new(heroData.m_config.skill_4_icon)
	else
		return nil
	end
	 
	button:onButtonPressed(function ( event )
		button:setScale(0.9)
		if pressListener then
			pressListener(event)
		end
		
	end)
	button:onButtonClicked(function ( event )
		listener( event )
	end)
	button:onButtonRelease(function ( event )
		button:setScale(1.0)
		if releaseListener then
			releaseListener(event)
		end
	end)
	button:setTouchSwallowEnabled(false)

	if listener == nil then
		button:setTouchEnabled(false)
	end



	-- display.newSprite("heros/skill" .. i .. ".jpg")
	-- 	:addTo(self.leftSprite)
	-- 	:scale(0.6)
	-- 	:pos(150 + (i - 1) * 45, 30)
	display.newSprite("heros/equip_frame_white.pvr.ccz")
		:addTo(button)
		:pos(0, -1)
		--:scale(0.6)

	return button
end

return SkillItemBtn