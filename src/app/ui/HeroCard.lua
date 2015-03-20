local HeroCard = {}

function HeroCard.new( heroData )
	--dump(heroData)

	node = display.newNode()
		


	-- 英雄大图
	node.img = cc.ui.UIPushButton.new(heroData.m_config.image2)
		:onButtonClicked(function ( event )
			print("click")
		end)
		:scale(0.75)
		:addTo(node)
	
	-- 根据英雄判断边框颜色
	local boardImgName = nil
	if heroData.m_lv >= 120 then
		boardImgName = "heros/card_bg_orange.pvr.ccz"
	elseif heroData.m_lv >= 70 then
		boardImgName = "heros/card_bg_purple.pvr.ccz"
	elseif heroData.m_lv >= 40 then
		boardImgName = "heros/card_bg_blue.pvr.ccz"
	elseif heroData.m_lv >= 20 then
		boardImgName = "heros/card_bg_green.pvr.ccz"
	else
		boardImgName = "heros/card_bg_white.pvr.ccz"
	end

	-- 边框
	node.border = display.newSprite(boardImgName)
		--:pos(self.leftSprite:getContentSize().width / 2, self.leftSprite:getContentSize().height / 2)
		:scale(1)
		:addTo(node)

	node:size(node.border:getContentSize().width / 2,node.border:getContentSize().height / 2)

	-- 血条





	node:scale(0.5)
	return node
end


return HeroCard