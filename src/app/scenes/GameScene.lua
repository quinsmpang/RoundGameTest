--
-- Author: UHEVER
-- Date: 2015-03-18 13:35:05
--
local GameLayer = require("app.layers.GameLayer")

local GameScene = class("GameScene", function (  )
	return display.newScene("GameScene")
end)


function GameScene:ctor(heros, chapterIdx)	
	self:initGameMap(chapterIdx)
	self:initGameLayer(heros)
end

function GameScene:initGameMap(  )
	local bg = display.newSprite("battle_bg/bbg_arena.jpg", display.cx, display.cy)
		:addTo(self)
	bg:setScale(display.width / bg:getContentSize().width, display.height / bg:getContentSize().height)

	-- 透明的人物背景(下)
	local alphaBg = display.newScale9Sprite("heros/battle_heroes_panel.pvr.ccz", 0, 0, cc.size(720, 250))
		:pos(display.cx, display.cy - 220)
		:addTo(self)
	-- 透明的人物背景(上)
	local alphaBg = display.newScale9Sprite("heros/battle_heroes_panel.pvr.ccz", 0, 0, cc.size(720, 250))
		:pos(display.cx, display.cy + 220)
		:addTo(self)
end

function GameScene:initGameLayer( heroDatas )
	print("herodatas")
	print(heroDatas)
	--local heroDatas = {}
	local enemyDatas = {}
	local hero1 = HeroDataManager.getHeroDataByIndex(1)
	local hero2 = HeroDataManager.getHeroDataByIndex(2)
	local hero3 = HeroDataManager.getHeroDataByIndex(3)
	local hero4 = HeroDataManager.getHeroDataByIndex(4)
	local hero5 = HeroDataManager.getHeroDataByIndex(5)
	local hero6 = HeroDataManager.getHeroDataByIndex(6)
	local hero7 = HeroDataManager.getHeroDataByIndex(7)
	local hero8 = HeroDataManager.getHeroDataByIndex(8)
	local hero9 = HeroDataManager.getHeroDataByIndex(9)
	local hero10 = HeroDataManager.getHeroDataByIndex(10)
	-- table.insert(heroDatas, hero1)
	-- table.insert(heroDatas, hero2)
	-- table.insert(heroDatas, hero3)
	-- table.insert(heroDatas, hero4)
	-- table.insert(heroDatas, hero5)
	-- print(#heroDatas)


	table.insert(enemyDatas, hero6)
	table.insert(enemyDatas, hero7)
	table.insert(enemyDatas, hero8)
	table.insert(enemyDatas, hero9)
	table.insert(enemyDatas, hero10)

	local layer = GameLayer.new(heroDatas, enemyDatas)
		:addTo(self, 1)
end

return GameScene