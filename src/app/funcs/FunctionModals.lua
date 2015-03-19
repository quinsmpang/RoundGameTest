--
-- Author: Your Name
-- Date: 2015-03-05 18:27:49
--
module("Funcs", package.seeall)

function trans( baseNode, targetNode, parent )
	local targetNode = require(targetNode):new()
	print(baseNode)
	print(targetNode)
	print(parent)

	--
	targetNode:addTo(parent)
	targetNode:opacity(0)
	targetNode:setScale(0.3)
	targetNode:setPosition(display.cx, display.cy)
	local baseSpawn = cca.spawn({cca.fadeOut(0.2), cca.scaleTo(0.2, 0.3)})
	local baseFunc = cca.callFunc(function ( node )
		print("--------")
		--print(targetNode)
		node:removeFromParent()
		
		-- 渐出
		local targetSpawn = cca.spawn({cca.fadeIn(0.2), cca.scaleTo(0.2, 1.0)})
		targetNode:runAction(targetSpawn)
	end)
	local baseSeq = cca.seq({baseSpawn, baseFunc})
	baseNode:runAction(baseSeq)
end

-- 提示消息
function alert( message )

	local msg = cc.ui.UILabel.new({
		text = message,
		size = 20,
		font = "LoginPanel/DFYuanW7-GB2312.ttf",
		color = display.COLOR_WHITE,
		align = cc.ui.TEXT_ALIGN_CENTER,
		})
		:opacity(160)

	local alert = cc.ui.UIPushButton.new("heros/main_vit_tips.pvr.ccz", {scale9 = true})
		:setButtonSize(300, 50)
		:pos(display.cx, display.bottom + 100)
		:setButtonLabel(msg)
		:opacity(20)
		:addTo(display.getRunningScene())
	local spawn1 = cca.spawn({cca.moveBy(0.4, 0, 60), cca.fadeIn(0.3)})
	local spawn2 = cca.spawn({cca.moveBy(0.4, 0, -60), cca.fadeOut(0.5)})
	local func = cca.callFunc(function ( node )
		node:removeFromParent()
	end)
	local seq = cca.seq({spawn1, cca.delay(1), spawn2, func})
	alert:runAction(seq)

end


-- 使用Mask遮罩
function newMaskedSprite(__mask, __pic)
	local shipBody = display.newSprite(__pic)
	local fileUtiles = cc.FileUtils:getInstance()
	local defaultVert = fileUtiles:getStringFromFile("default.vsh")
	local maskFrag = fileUtiles:getStringFromFile("mask.fsh")
	local glprogram  = cc.GLProgram:createWithByteArrays(defaultVert, maskFrag)
	local glprogramstate = cc.GLProgramState:getOrCreateWithGLProgram(glprogram)
	cc.Texture2D:setDefaultAlphaPixelFormat(cc.TEXTURE2_D_PIXEL_FORMAT_I8)
	local texture = cc.Director:getInstance():getTextureCache():addImage(__mask)
	cc.Texture2D:setDefaultAlphaPixelFormat(cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888)
	glprogramstate:setUniformTexture("u_mask_texture", texture)
	shipBody:setGLProgramState(glprogramstate)
	return shipBody
end






-- 解析csv
function split(str, reps)  
    local resultStrsList = {};  
    string.gsub(str, '[^' .. reps ..']+', function(w) table.insert(resultStrsList, w) end );  
    return resultStrsList;  
end  


function loadCsvFile(filePath)   
	print(filepath)
    -- 读取文件  
    local data = cc.FileUtils:getInstance():getStringFromFile(filePath);  
  	print(data)
    -- 按行划分  
    local lineStr = split(data, '\n\r');  
  
    --[[  
                从第3行开始保存（第一行是标题，第二行是注释，后面的行才是内容）   
              
                用二维数组保存：arr[ID][属性标题字符串]  
    ]]  
    local titles = split(lineStr[1], ",");  
    local ID = 1;  
    local arrs = {};  
    for i = 3, #lineStr, 1 do  
        -- 一行中，每一列的内容  
        local content = split(lineStr[i], ",");  
  
        -- 以标题作为索引，保存每一列的内容，取值的时候这样取：arrs[1].Title  
        arrs[ID] = {};  
        for j = 1, #titles, 1 do  
            arrs[ID][titles[j]] = content[j];  
        end  
  
        ID = ID + 1;  
    end  
  
    return arrs;  
end  


function SaveTableContent(file, obj)
      local szType = type(obj);
      print(szType);
      if szType == "number" then
            file:write(obj);
      elseif szType == "string" then
            file:write(string.format("%q", obj));
      elseif szType == "table" then
            --把table的内容格式化写入文件
            file:write("{\n");
            for i, v in pairs(obj) do
                  file:write("[");
                  SaveTableContent(file, i);
                  --file:write("]=\n");
                  file:write("]=");
                  SaveTableContent(file, v);
                  file:write(",\n");
             end
            file:write("}\n");
      else
      error("can't serialize a "..szType);
      end
end


function main()  
    local csvConfig = loadCsvFile("/Users/neworigin/code/quick/RoundGameTest/src/app/funcs/equipsutf8.csv");  
    print(csvConfig)

    local file = io.open("/Users/neworigin/code/quick/RoundGameTest/src/app/funcs/222.lua", "w");
      assert(file);
      SaveTableContent(file, csvConfig);
      file:close();
   
      
    --print(csvConfig[1].name .. ":" .. csvConfig[1].pass);  
    --print(csvConfig[2].name .. ":" .. csvConfig[2].pass);  
end  