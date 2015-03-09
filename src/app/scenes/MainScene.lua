
local rootNode = nil

local killIndex = 1

local heroPos_tb = {}
local enemyPos_tb = {}

local hero_tb = {}
local enemy_tb = {}

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
	nil,
	"tentacle.csb",
	"tentacle.csb",
}

local hero_hp = {
	300,
	300,
	300,
	300,
	300,
}

local enemy_hp = {
	500,
	380,
	12,
	600,
	300,
}

local hero_skill_damage = {
	350,
	300,
	300,
	300,
	300,
}

local enemy_skill_damage = {
	100,
	200,
	100,
	300,
	100,
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


local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
	math.randomseed(os.time())

	-- 添加背景
    rootNode = cc.CSLoader:createNode("GameLayer.csb")
    	:addTo(self)
    -- 创建英雄精灵
    self:initHeros(5)

    -- 创建敌人精灵
    self:initEnemys(5)

    -- 开始战斗
    local startButton = rootNode:getChildByName("start_button")
    startButton:addTouchEventListener(function ( target, event )
    	if event == 2 then
    		self:enemyKill()
    	end
    end)



end


function MainScene:initHeros( num )
	for i=1,num do
		if hero_nodes[i] ~= nil then
		local posNode = rootNode:getChildByName("pos_" .. i)
		local sp = cc.CSLoader:createNode(hero_nodes[i])
		:addTo(posNode, nil, 1)
		local bloodNum = sp:getChildByName("bloodNum")
			bloodNum:setString(hero_hp[i])
		action = cc.CSLoader:createTimeline(hero_nodes[i])
		action:gotoFrameAndPlay(ACTION_IDLE_ON, ACTION_IDLE_OFF, true)
		action:setTag(10)
		posNode:runAction(action)
		heroPos_tb[i] = posNode
		end	
	end
end

function MainScene:initEnemys( num )
	for i=1,num do
		if enemy_nodes[i] ~= nil then
			local posNode = rootNode:getChildByName("pos_" .. i+5)
			local sp = cc.CSLoader:createNode(enemy_nodes[i])
				:addTo(posNode, nil, 1)
			--enemy_tb[i] = sp
			local bloodNum = sp:getChildByName("bloodNum")
			bloodNum:setString(enemy_hp[i])
			local action = cc.CSLoader:createTimeline(enemy_nodes[i])
			action:gotoFrameAndPlay(ACTION_IDLE_ON, ACTION_IDLE_OFF, true)
			posNode:runAction(action)
			enemyPos_tb[i] = posNode
		end
	end
end

-- 开始厮杀
function MainScene:heroKill(  )
	print("hero_pos:" .. #heroPos_tb)
	print("enemy_pos:" .. #enemyPos_tb)

	if killIndex > #heroPos_tb then
		killIndex = 1
		print("英雄已经厮杀完了")
		self:enemyKill()
		return
	else
		if heroPos_tb[killIndex] == nil then
		killIndex = killIndex + 1
		self:heroKill()
		return
		end
	end

	
	heroPos_tb[killIndex]:stopAllActions()
	local baseX, baseY = heroPos_tb[killIndex]:getPosition()
	local heroSprite = heroPos_tb[killIndex]:getChildByTag(1)
	local enemyNum
	while enemyPos_tb[enemyNum] == nil do
		enemyNum = self:getRandom(1, #enemyPos_tb)
	end
	local enemySprite = enemyPos_tb[enemyNum]:getChildByTag(1)
	local targetX, targetY = enemyPos_tb[enemyNum]:getPosition()
	local move1 = cca.moveTo(2, targetX - 70, targetY)
	
	local func1 = cc.CallFunc:create(function (node ,value)
		-- 英雄执行技能动画
		local action = cc.CSLoader:createTimeline(hero_nodes[killIndex])
		action:gotoFrameAndPlay(ACTION_ATK_ON, ACTION_ATK_OFF, false)
		heroPos_tb[killIndex]:runAction(action)

		-- 出现技能标签
		local skillName = cc.ui.UILabel.new({
			text = hero_skill_name[killIndex],
			size = 20,
			color = display.COLOR_RED,
			align = cc.ui.TEXT_ALIGN_CENTER,
			})
			:pos(value.targetX, value.targetY + 70)
			:addTo(self)
		skillName:setOpacity(0)

		skillName:runAction(cca.seq({cca.fadeIn(0.5), cca.scaleTo(1.0, 2.0), cca.callFunc(function ( node, value )
			local x,y = node:getPosition()
			node:removeFromParent()

			local skillDamage = cc.ui.UILabel.new({
			text = "-" .. hero_skill_damage[killIndex],
			size = 30,
			color = display.COLOR_RED,
			align = cc.ui.TEXT_ALIGN_CENTER,
			})
			:pos(x, y)
			:opacity(0)
			:addTo(self)

			-- 显示伤害值
			skillDamage:runAction(cca.seq({cca.fadeIn(0.5), cca.scaleTo(1.0, 2.0), cca.callFunc(function ( node )
				node:removeFromParent()
				-- 检测游戏是否完成
				-- local num = 0
				-- for i=1,#enemyPos_tb do
				-- 	if enemyPos_tb[i] ~= nil then
				-- 		--todo
				-- 	end
				-- end
				local isEndGame, isSuccess = self:checkBattleResult()
				if isEndGame then
					if isSuccess then
						local successLabel = cc.ui.UILabel.new({
						text = "你赢的了比赛！",
						size = 50,
						color = display.COLOR_RED,
						})
						:pos(display.cx, display.cy)
						:addTo(self)
					else
						local successLabel = cc.ui.UILabel.new({
						text = "你输掉了比赛！",
						size = 50,
						color = display.COLOR_RED,
						})
						:pos(display.cx, display.cy)
						:addTo(self)
					end
				else
					killIndex = killIndex + 1
					self:heroKill()
				end

			end)}))

		end)}))

		-- 敌人掉血，修改血条和血量
		local enemySprite = value.enemySprite
		local blood = enemySprite:getChildByName("blood")
		local bloodNumLabel = enemySprite:getChildByName("bloodNum")

		local bloodNum = bloodNumLabel:getString() - hero_skill_damage[killIndex]
		if bloodNum <= 0 then
			bloodNum = 0
			enemyPos_tb[value.enemyNum] = nil
			print("这里开始")
			enemySprite:runAction(cca.fadeOut(1.2))
		end
		bloodNumLabel:setString(bloodNum)
		-- print(value.enemyNum)
		-- print(bloodNum)
		-- print(enemy_hp[value.enemyNum])
		-- print(bloodNum / enemy_hp[value.enemyNum] * 100)
		blood:setPercent(bloodNum / enemy_hp[value.enemyNum] * 100)



	end,{enemySprite = enemySprite, enemyNum = enemyNum, targetX = targetX, targetY = targetY})


	local func2 = cca.callFunc(function ( )
		local action = cc.CSLoader:createTimeline(hero_nodes[killIndex])
		action:gotoFrameAndPlay(ACTION_IDLE_ON, ACTION_IDLE_OFF, true)
		heroPos_tb[killIndex]:runAction(action)
	end)

	local move2 = cca.moveTo(2, baseX, baseY)

	local seq = cca.seq({move1, func1, cca.delay(2), func2, move2})
	print("base x,y = " .. baseX .. baseY)
	print("target x,y = " .. targetX .. targetY)
	heroPos_tb[killIndex]:runAction(seq)

end



function MainScene:enemyKill(  )
	print("hero_pos:" .. #heroPos_tb)
	print("enemy_pos:" .. #enemyPos_tb)

	if killIndex > #enemyPos_tb then
		killIndex = 1
		print("敌人攻击完毕")
		self:heroKill()
		return
	else
		if enemyPos_tb[killIndex] == nil then
			killIndex = killIndex + 1
			self:enemyKill()
		return 
		end
		
	end

	
	enemyPos_tb[killIndex]:stopAllActions()
	local baseX, baseY = enemyPos_tb[killIndex]:getPosition()
	local enemySprite = enemyPos_tb[killIndex]:getChildByTag(1)
	local heroNum
	while heroPos_tb[heroNum] == nil do
		heroNum = self:getRandom(1, #heroPos_tb)
	end
	local heroSprite = heroPos_tb[heroNum]:getChildByTag(1)
	local targetX, targetY = heroPos_tb[heroNum]:getPosition()
	local move1 = cca.moveTo(2, targetX + 70, targetY)
	
	local func1 = cc.CallFunc:create(function (node ,value)
		-- 英雄执行技能动画
		local action = cc.CSLoader:createTimeline(enemy_nodes[killIndex])
		action:gotoFrameAndPlay(ACTION_ATK_ON, ACTION_ATK_OFF, false)
		enemyPos_tb[killIndex]:runAction(action)

		-- 出现技能标签
		local skillName = cc.ui.UILabel.new({
			text = enemy_skill_name[killIndex],
			size = 20,
			color = display.COLOR_RED,
			align = cc.ui.TEXT_ALIGN_CENTER,
			})
			:pos(value.targetX, value.targetY + 70)
			:addTo(self)
		skillName:setOpacity(0)

		skillName:runAction(cca.seq({cca.fadeIn(0.5), cca.scaleTo(1.0, 2.0), cca.callFunc(function ( node, value )
			local x,y = node:getPosition()
			node:removeFromParent()

			local skillDamage = cc.ui.UILabel.new({
			text = "-" .. enemy_skill_damage[killIndex],
			size = 30,
			color = display.COLOR_RED,
			align = cc.ui.TEXT_ALIGN_CENTER,
			})
			:pos(x, y)
			:opacity(0)
			:addTo(self)

			-- 显示伤害值
			skillDamage:runAction(cca.seq({cca.fadeIn(0.5), cca.scaleTo(1.0, 2.0), cca.callFunc(function ( node )
				node:removeFromParent()
				-- 检测游戏是否完成
				local isEndGame, isSuccess = self:checkBattleResult()
				if isEndGame then
					if isSuccess then
						local successLabel = cc.ui.UILabel.new({
						text = "你赢的了比赛！",
						size = 50,
						color = display.COLOR_RED,
						})
						:pos(display.cx, display.cy)
						:addTo(self)
					else
						local successLabel = cc.ui.UILabel.new({
						text = "你输掉了比赛！",
						size = 50,
						color = display.COLOR_RED,
						})
						:pos(display.cx, display.cy)
						:addTo(self)
					end
				else
					killIndex = killIndex + 1
					self:enemyKill()
				end

			end)}))

		end)}))

		-- 敌人掉血，修改血条和血量
		local heroSprite = value.heroSprite
		local blood = heroSprite:getChildByName("blood")
		local bloodNumLabel = heroSprite:getChildByName("bloodNum")

		local bloodNum = bloodNumLabel:getString() - enemy_skill_damage[killIndex]
		if bloodNum <= 0 then
			bloodNum = 0
			heroPos_tb[value.heroNum] = nil
			heroSprite:runAction(cca.fadeOut(1.2))
		end
		bloodNumLabel:setString(bloodNum)
		blood:setPercent(bloodNum / hero_hp[value.heroNum] * 100)



	end,{heroSprite = heroSprite, heroNum = heroNum, targetX = targetX, targetY = targetY})


	local func2 = cca.callFunc(function ( )
		local action = cc.CSLoader:createTimeline(enemy_nodes[killIndex])
		action:gotoFrameAndPlay(ACTION_IDLE_ON, ACTION_IDLE_OFF, true)
		enemyPos_tb[killIndex]:runAction(action)
	end)

	local move2 = cca.moveTo(2, baseX, baseY)

	local seq = cca.seq({move1, func1, cca.delay(2), func2, move2})
	print("base x,y = " .. baseX .. baseY)
	print("target x,y = " .. targetX .. targetY)
	enemyPos_tb[killIndex]:runAction(seq)





end


function MainScene:getRandom( beginNumber, endNumber )
	return math.random(beginNumber, endNumber)
end


function MainScene:checkBattleResult(  )
	print(os.time())
	local enemyNum = 0
	local heroNum = 0
	for i=1,#enemyPos_tb do
		if enemyPos_tb[i]  ~= nil then
			enemyNum = enemyNum + 1
		end
	end
	if enemyNum <= 0 then
		return true, true
	else
		return false, false
	end

	for i=1,#heroPos_tb do
		if heroPos_tb[i] ~= nil then
			heroNum = heroNum + 1
		end
	end

	if heroNum <= 0 then
		return true, false
	else
		return false, false
	end

	
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
