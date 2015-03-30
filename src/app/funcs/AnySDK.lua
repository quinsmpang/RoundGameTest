--
-- Author: UHEVER
-- Date: 2015-03-21 00:38:14
--
module("AnySDK", package.seeall)
require "anysdkConst"

function initAnySDK(  )
	
	agent = AgentManager:getInstance()
   	print("agent is---" .. type(agent))

   	--初始化并load plugins(注意：初始化和load最好只进行一次，建议agent设置为全局的)
	--init
	local appKey = "325E41DE-F531-471B-10A0-31140967F1E2";
	local appSecret = "064043440e42a7d577b988c4cb0e9f9a";
	local privateKey = "805EAE6FFC01EE3B889504F3B41D7232";
	local oauthLoginServer = "http://oauth.anysdk.com/api/OauthLoginDemo/Login.php";
	agent:init(appKey,appSecret,privateKey,oauthLoginServer)
	--load
	agent:loadALLPlugin()
end

function getInstance(  )
	return agent
end