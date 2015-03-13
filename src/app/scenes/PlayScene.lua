--
-- Author: Your Name
-- Date: 2015-03-03 19:49:09
--

 local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

local rootNode = nil
local killIndex = 1
local isHeroAttack = true

local skillDamage = nil
local spriteHp = nil
local spriteNode = nil
local skillName = nil
local target = nil

local heroPos_tb = {}
local enemyPos_tb = {}

local hero_nodes = {
	"captain_jack.csb",
	"cat_queen.csb",
	"huchey.csb",
	"jones.csb",
	"pharaoh.csb",
}

local enemy_nodes = {
	"tentacle.csb",
	--"generalshark.csb",
	"tentacle.csb",
	--nil,
	"tentacle.csb",
	"tentacle.csb",
	"tentacle.csb",
}

local hero_hp = {
	600,
	600,
	600,
	600,
	600,
}

local enemy_hp = {
	500,
	480,
	620,
	600,
	700,
}

local hero_skill_damage = {
	{250, 1},
	{100, 2},
	{100, 1},
	{100, 1},
	{300, 2},
}

local enemy_skill_damage = {
	{150, 1},
	{100, 2},
	{100, 3},
	{100, 4},
	{100, 2},
}

local hero_skill_name = {
	"玫瑰之刃",
	"噬魂剑",
	"炎爆术",
	"春回大地",
	"高爆射击",
}

local enemy_skill_name = {
	"锐刺鞭笞",
	"蛮力重击",
	"锐刺鞭笞",
	"锐刺鞭笞",
	"锐刺鞭笞",
}


local ACTION_IDLE_ON = 0
local ACTION_IDLE_OFF = 13
local ACTION_ATK_ON = 14
local ACTION_ATK_OFF = 40
local ACTION_DIE_ON = 41
local ACTION_DIE_OFF = 60

local PlayScene = class("PLayScene", function (  )
	return display.newScene("PlayScene")
end)


function PlayScene:ctor(  )
	math.randomseed(os.time())
	-- 添加主背景图
	rootNode = cc.CSLoader:createNode("GameLayer.csb")
		:addTo(self)

	-- 初始化英雄
	self:initSprites(heroPos_tb, hero_nodes, hero_hp, 0)

	-- 初始化敌人
	self:initSprites(enemyPos_tb, enemy_nodes, enemy_hp, 5)


	-- 开始战斗按钮
	local startButton = rootNode:getChildByName("start_button")
	startButton:addTouchEventListener(function ( target, event )
		if event == 2 then
			
			self.begin = scheduler.scheduleGlobal(function (  )
				self:beginAttack()
			end, 2)
			startButton:setVisible(false)
		end
	end)
end

function PlayScene:initSprites( posTb, csbTb, hpTb, partenStart )
	for i=1,#csbTb do
		if csbTb[i] ~= nil then
			local posNode = rootNode:getChildByName("pos_" .. (i + partenStart))
			local sp = cc.CSLoader:createNode(csbTb[i])
				:addTo(posNode, nil, 1)
			local bloodNumLabel = sp:getChildByName("bloodNum")
			bloodNumLabel:setString(hpTb[i])
			local action = cc.CSLoader:createTimeline(csbTb[i])
			action:gotoFrameAndPlay(ACTION_IDLE_ON, ACTION_IDLE_OFF, true)
			posNode:runAction(action)
			posTb[i] = posNode
		end
	end
end


function PlayScene:beginAttack()
	if isHeroAttack then
	 	print("hero开始攻击")
	 	local heroPos = self:getRandom(heroPos_tb)
	 	local enemyPos = self:getRandom(enemyPos_tb)
	 	self:attack(heroPos, enemyPos)
	 	--self:attack(heroPos_tb, enemyPos_tb)
	else
	 	print("enemy开始攻击")
	 	local heroPos = self:getRandom(heroPos_tb)
	 	local enemyPos = self:getRandom(enemyPos_tb)
	 	self:attack(enemyPos, heroPos)
	 	--self:attack(enemyPos_tb, heroPos_tb)
	end

end

function PlayScene:attack( basePosTb, targetPosTb )
	--local basePosTb = self:getRandom(basePosTb1)
	if killIndex > 5 then
		-- 加血10
		local addHpSprite = self:getRandom(targetPosTb)
		for k,v in pairs(addHpSprite) do
			local label = self:labelEffect(200, addHpSprite[k])
			self:setSpriteBloodNum(addHpSprite[k]:getChildByTag(1), 200, k)
		end
		
		killIndex = 1
		isHeroAttack = not isHeroAttack
		--self:beginAttack()
		return
	end
	if basePosTb[killIndex] == nil then
		killIndex = killIndex + 1
		self:attack(basePosTb, targetPosTb)
		return
	end
	target = targetPosTb
	if isHeroAttack then
		skillDamage = hero_skill_damage
		spriteHp = enemy_hp
		spriteNode = hero_nodes
		skillName = hero_skill_name
		ACTION_ATK_ON = 28
		ACTION_ATK_OFF = 54
	else
		skillDamage = enemy_skill_damage
		spriteHp = hero_hp
		spriteNode = enemy_nodes
		skillName = enemy_skill_name
		ACTION_ATK_ON = 14
		ACTION_ATK_OFF = 40
	end

	--basePosTb[killIndex]:stopAllActions()
	-- 攻击者sprite
	local baseSprite = basePosTb[killIndex]:getChildByTag(1)
	local bloodNumLabel = baseSprite:getChildByName("bloodNum")
	local bloodNum = bloodNumLabel:getString()
	-- 血量少于0不允许攻击
	if tonumber(bloodNum) <= 0 then
		killIndex = killIndex + 1
		return
	end 

	-- 获取攻击者的位置
	local baseX, baseY = basePosTb[killIndex]:getPosition()

	-- 攻击者技能的攻击个数
	local skillDamageNum = skillDamage[killIndex][2]

	-- 获得能攻击的敌人数组

	--local targetNum = self:getRandom(targetPosTb)
	local targetSprite
	local skillDamageNumStart = 1
		-- 选取一个目标代号
		for k,v in pairs(targetPosTb) do
			print(k,v)
			--isUnderAttackNum = k
			self:killEffect(basePosTb, targetPosTb, k)

			
			if skillDamageNumStart == skillDamageNum then
				break
			end
			skillDamageNumStart = skillDamageNumStart + 1
		end
	killIndex = killIndex + 1
	
end

function PlayScene:getRandom( spriteTb )
	local number = {}
	for k,v in pairs(spriteTb) do
		local sp = spriteTb[k]:getChildByTag(1)
		local bloodNum = sp:getChildByName("bloodNum")
		if tonumber(bloodNum:getString()) > 0 then
			number[k] = spriteTb[k]
		end
	end
	
	local a = 0
	for k,v in pairs(number) do
		a = a + 1
	end
	--print("--------------------" .. a)
	
	return number
end

function PlayScene:killEffect( basePosTb, targetPosTb, targetIndex )
	local action = cc.CSLoader:createTimeline(spriteNode[killIndex])
	action:gotoFrameAndPlay(ACTION_ATK_ON, ACTION_ATK_OFF, false)
	basePosTb[killIndex]:runAction(action)

	-- func1
	local func1 = cca.callFunc(function ( node, value )
		print("index:----------------- " .. killIndex -1)
		local skillD = -skillDamage[killIndex - 1][1]
		-- 设置加血标签
		local label = self:labelEffect(skillD, node)

		-- 设置血量
		self:setSpriteBloodNum(node:getChildByTag(1), skillD, targetIndex)
		-- 检测游戏状态
		local state = self:checkGameState()
		if state then
			scheduler.unscheduleGlobal(self.begin)

		end
	end)



	local baseSeq = cca.seq({cca.delay(1), cca.blink(0.5, 3), func1})

	targetPosTb[targetIndex]:runAction(baseSeq)
end

function PlayScene:labelEffect( number, node)
	local color = display.COLOR_RED
	if number >= 0 then
		color = display.COLOR_GREEN
		number = "+" .. number
	end
	local label = cc.ui.UILabel.new({
			text = number,
			size = 40,
			color = color,
			})
			:pos(node:getPositionX() - 50, node:getPositionY() + 150)
			:addTo(self)

	label:runAction(cca.seq({cca.moveBy(0.5, 0, 50), cca.callFunc(function ( node )
			node:removeFromParent()
		end)}))
	return label
end

function PlayScene:getSpriteBloodNum( sprite )
	local bloodNumLabel = sprite:getChildByName("bloodNum")
	local bloodNum = tonumber(bloodNumLabel:getString())
	return bloodNum
end

function PlayScene:setSpriteBloodNum( sprite, number, targetIndex )
	local bloodNumLabel = sprite:getChildByName("bloodNum")
	-- if tonumber(bloodNumLabel:getString()) <= 0 then
	-- 	return
	-- end
	local nowBloodNum = tonumber(bloodNumLabel:getString()) + number
	if nowBloodNum <= 0 then
		nowBloodNum = 0
		-- 血量小于0 消失
		sprite:runAction(cca.fadeOut(1.2))
	end
	if nowBloodNum >= spriteHp[targetIndex] then
		nowBloodNum = spriteHp[targetIndex]
	end
	bloodNumLabel:setString(nowBloodNum)

	local percent = nowBloodNum / spriteHp[targetIndex] * 100
	local blood = sprite:getChildByName("blood")
	blood:setPercent(percent)

	-- print("isUnderAttackNum: " .. targetIndex)
	-- print("nowBlood " .. nowBloodNum)
	-- print("spriteHp[isUnderAttackNum] " .. spriteHp[targetIndex])

end

function PlayScene:checkGameState(  )
	local num = 0

	for k,v in pairs(target) do
		if self:getSpriteBloodNum(target[k]:getChildByTag(1)) > 0 then
	 		num = num + 1
	 	end
	end
	print("num = " .. num)

	if num == 0 then
		if isHeroAttack then
			print("----------英雄胜利------------")
		else
			print("----------游戏失败------------")
		end
		-- over
		return true
	end
	return false
end

return PlayScene
