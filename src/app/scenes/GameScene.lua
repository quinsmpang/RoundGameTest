--
-- Author: UHEVER
-- Date: 2015-03-18 13:35:05
--
local GameLayer = require("app.layers.GameLayer")

local GameScene = class("GameScene", function (  )
	return display.newScene("GameScene")
end)


function GameScene:ctor()	
	self:initGameMap()
	self:initGameLayer()
end

function GameScene:initGameMap( levelData )
	local bg = display.newSprite("battle_bg/bbg_arena.jpg", display.cx, display.cy)
		:addTo(self)
	bg:setScale(display.width / bg:getContentSize().width, display.height / bg:getContentSize().height)
end

function GameScene:initGameLayer( levelData )
	local heroDatas = {}
	local enemyDatas = {}
	local hero1 = HeroDataManager.getHeroDataByIndex(1)
	local hero2 = HeroDataManager.getHeroDataByIndex(2)
	local hero3 = HeroDataManager.getHeroDataByIndex(3)
	local hero4 = HeroDataManager.getHeroDataByIndex(1)
	local hero5 = HeroDataManager.getHeroDataByIndex(3)
	table.insert(heroDatas, hero1)
	table.insert(heroDatas, hero2)
	table.insert(heroDatas, hero3)
	table.insert(heroDatas, hero4)
	table.insert(heroDatas, hero5)
	print(#heroDatas)


	table.insert(enemyDatas, hero1)
	table.insert(enemyDatas, hero2)
	table.insert(enemyDatas, hero3)
	table.insert(enemyDatas, hero4)
	table.insert(enemyDatas, hero5)

	local layer = GameLayer.new(heroDatas, enemyDatas)
		:addTo(self, 1)
end

return GameScene