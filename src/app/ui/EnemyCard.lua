local EnemyCard = {}

function EnemyCard.new( enemyData )
	--dump(enemyData)

	node = display.newNode()
		
	-- 卡牌（包括图片和边框）


	-- 英雄大图

	node.img = cc.ui.UIPushButton.new(enemyData.m_config.image)
		:onButtonClicked(function ( event )
			print("click")
		end)
		:scale(0.75)
		:addTo(node)
	
	-- 根据英雄判断边框颜色
	local boardImgName = nil
	if enemyData.m_lv >= 120 then
		boardImgName = "heros/card_bg_orange.pvr.ccz"
	elseif enemyData.m_lv >= 70 then
		boardImgName = "heros/card_bg_purple.pvr.ccz"
	elseif enemyData.m_lv >= 40 then
		boardImgName = "heros/card_bg_blue.pvr.ccz"
	elseif enemyData.m_lv >= 20 then
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




	node:scale(0.5)
	return node
end


return EnemyCard