--
-- Author: UHEVER
-- Date: 2015-03-20 11:24:46
--
local LoginScene = require("app.scenes.LoginScene")
local MainScene = require("app.scenes.MainScene")

module("SceneManager", package.seeall)


function goLoginScene(  )
	local scene = LoginScene.new()
	display.replaceScene(scene, "fade", 0.8)
end


function goMainScene(  )
	local scene = MainScene.new()
	display.replaceScene(scene, "fade", 0.8)
end