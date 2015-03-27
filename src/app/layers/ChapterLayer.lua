--
-- Author: UHEVER
-- Date: 2015-03-27 13:13:53
--
local ChapterInfoLayer = require("app.layers.ChapterInfoLayer")

local ChapterLayer = class("ChapterLayer", function (  )
	return display.newColorLayer(cc.c4b(10, 10, 10, 150))
end)

function ChapterLayer:ctor(  )
	-- 背景框
	self.bg = display.newScale9Sprite("heros/package_herolist_bg.pvr.ccz", display.cx, display.cy, cc.size(585, 400))
		:scale(1.3)
		:addTo(self)

	

	local chapNumBg = Funcs.newMaskedSprite("heros/map-title-bg_alpha_mask", "heros/map-title-bg.jpg")
		:addTo(self)
		:pos(display.cx, display.top - 70)


	display.newSprite("heros/maptitle-chapter1.pvr.ccz")
		:pos(chapNumBg:getContentSize().width / 2, chapNumBg:getContentSize().height / 2)
		:addTo(chapNumBg)	


	-- 关闭按钮
	cc.ui.UIPushButton.new("heros/herodetail-detail-close.pvr.ccz")
		:onButtonClicked(function ( event )
			self:removeFromParent()
		end)
		:pos(self.bg:getContentSize().width - 10, self.bg:getContentSize().height - 10)
		:addTo(self.bg, 10)	


	-- 地图
	--display.newSprite("heros/stage-1.pvr.ccz")
		

	cc.ui.UIPushButton.new("heros/stage-1.pvr.ccz")
		:pos(self.bg:getContentSize().width / 2 - 200, self.bg:getContentSize().height / 2)
		:onButtonClicked(function ( event )
			print("chapter1")
			local layer = ChapterInfoLayer.new(1)
				:addTo(self, 20)
		end)
		:scale(1)
		:addTo(self.bg)

	cc.ui.UIPushButton.new("heros/stage-4.pvr.ccz")
		:pos(self.bg:getContentSize().width / 2, self.bg:getContentSize().height / 2)
		:onButtonClicked(function ( event )
			print("haha")
			local layer = ChapterInfoLayer.new(2)
				:addTo(self, 20)
		end)
		:scale(1)
		:addTo(self.bg)


	cc.ui.UIPushButton.new("heros/stage-7.pvr.ccz")
		:pos(self.bg:getContentSize().width / 2 + 200, self.bg:getContentSize().height / 2)
		:onButtonClicked(function ( event )
			print("haha")
			local layer = ChapterInfoLayer.new(3)
				:addTo(self, 20)
		end)
		:scale(1)
		:addTo(self.bg)


end

return ChapterLayer