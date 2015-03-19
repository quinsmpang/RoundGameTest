--
-- Author: UHEVER
-- Date: 2015-03-18 13:35:20
--

local HeroCard = require("app.ui.HeroCard")
local EnemyCard = require("app.ui.EnemyCard")

local GameLayer = class("GameLayer", function (  )
	return display.newLayer()
end)


local HeroSprites = {}
local EnemySprites = {}

function GameLayer:ctor( heroDatas, enemyDatas )
	self:initHeroCards(heroDatas)
	self:initEnemyCards(enemyDatas)
end

function GameLayer:initHeroCards( heroDatas )

	local marginX = 20
	local heroNum = #heroDatas
	for i,v in ipairs(heroDatas) do
		local heroData = heroDatas[i]
		HeroSprites[i] = HeroCard.new(heroData)
			:pos(display.cx, display.cy)
			:addTo(self)
		local startPosX = (display.width - (marginX * (heroNum - 1)) - HeroSprites[i]:getContentSize().width * (heroNum - 1)) / 2
		local posX = startPosX + HeroSprites[i]:getContentSize().width * (i-1) + marginX * (i - 1)
		local posY = HeroSprites[i]:getContentSize().height / 2
		print("posx:" .. posX .. "  posy:" .. posY)
		HeroSprites[i]:runAction(cca.moveTo(0.8, posX, posY))
		HeroSprites[i].img:setButtonEnabled(false)
		
	end

end


function GameLayer:initEnemyCards( enemyDatas )
	local marginX = 20
	local enemyNum = #enemyDatas
	for i,v in ipairs(enemyDatas) do
		local enemyData = enemyDatas[i]
		EnemySprites[i] = EnemyCard.new(enemyData)
			:pos(display.cx, display.cy)
			:addTo(self)
		local startPosX = (display.width - (marginX * (enemyNum - 1)) - EnemySprites[i]:getContentSize().width * (enemyNum - 1)) / 2
		local posX = startPosX + EnemySprites[i]:getContentSize().width * (i-1) + marginX * (i - 1)
		local posY = display.height - EnemySprites[i]:getContentSize().height / 2
		print("posx:" .. posX .. "  posy:" .. posY)
		EnemySprites[i]:runAction(cca.moveTo(0.8, posX, posY))
		EnemySprites[i].img:setButtonEnabled(false)
		
	end
end


return GameLayer