--
-- Author: UHEVER
-- Date: 2015-03-13 20:03:31
--
local HeroEquipAddLayer = class("HeroEquipAddLayer", function (  )
	return display.newColorLayer(cc.c4b(10, 10, 10, 100))
end)

function HeroEquipAddLayer:ctor( heroData, equipIdx )
	self.hero = heroData
	local node = display.newNode()
		:addTo(self)
	local listBg = display.newSprite("heros/herodetail-detail-popup.pvr.ccz", display.cx - 165, display.cy)
		:addTo(node)

	local detailBg = Funcs.newMaskedSprite("heros/package_detail_bg_alpha_mask", "heros/package_detail_bg.jpg")
		:pos(display.cx + 140, display.cy)
		:addTo(node)

	-- listView数据源
	--local useableEquipTb = 

	-- 添加listView
	self.lvGrid = cc.ui.UIListView.new({
	bgColor = cc.c4b(200, 200, 200, 120),
	--bg = "heros/dialog_bg.jpg",
	scrollbarImgV = "heros/scroll_bar.pvr.ccz",
	viewRect = cc.rect(display.cx - 350 - 30, display.cy - 175 - 65, 700, 430),
	direction = cc.ui.UIScrollView.DIRECTION_VERTICAL,
	})
	:addTo(listBg, 20)


	-- print(#heros)
	-- for i=1,#heros / 2 + 0.5 do
	-- 	local item = self.lvGrid:newItem()
	-- 	local content
	-- 	content = display.newNode()
	-- 	local cols = 2
	-- 	if #heros / i < 2 then
	-- 		cols = 1
	-- 	end
	-- 	for count = 1,cols do
	-- 		local idx = (i-1)*2 + count
	-- 		--local hero = HeroDataManager.getHeroDataByTable(idx)
	-- 		local hero = heros[idx]
	-- 		--print(hero.m_type)

	-- 		local listItem = HeroListItem.new(hero)
	-- 			:align(display.CENTER, 180 + 340 * (count - 1), 60)
	-- 			:addTo(content)
	-- 	end
	-- 	content:setContentSize(700, 130)
	-- 	item:addContent(content)
	-- 	item:setItemSize(700, 130)
	-- 	self.lvGrid:addItem(item)
	-- end
	-- --print("-------------------")
	-- self.lvGrid:reload()
end

return HeroEquipAddLayer