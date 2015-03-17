--
-- Author: UHEVER
-- Date: 2015-03-16 09:39:38
--
module("Net", package.seeall)

local Domain = "http://127.0.0.1/zzwll/"
address = {}
address.post_login = Domain .. "userlogin.php"
address.post_register = Domain .. "registerUser.php"

-- 检查网络连接状态
function checkNetworkStatus(  )
	local status = {
        [cc.kCCNetworkStatusNotReachable]     = "无法访问互联网",
        [cc.kCCNetworkStatusReachableViaWiFi] = "通过 WIFI",
        [cc.kCCNetworkStatusReachableViaWWAN] = "通过 3G 网络",
    }

    printf("Internet Connection Status: %s", status[network.getInternetConnectionStatus()])
	--if not network.isHostNameReachable("www.cocos2d-x.org") then
	if not network.isInternetConnectionAvailable() then
		Funcs.alert("无法连接到网络")
		
		return false
	end
	return true
end




function onResponse(event, index, dumpResponse)
	local request = event.request
	print("REQUEST %d - event.name = %s", index, event.name)
	if event.name == "completed" then
		 printf("REQUEST %d - getResponseStatusCode() = %d", index, request:getResponseStatusCode())
		 if request:getResponseStatusCode() ~= 200 then
		 else
		 	printf("REQUEST %d - getResponseDataLength() = %d", index, request:getResponseDataLength())
            print("dump:" .. tostring(dumpResponse))
            if dumpResponse then
                printf("REQUEST %d - getResponseString() =\n%s", index, request:getResponseString())
            end
		 end
	elseif event.name ~= "progress" then
		print("ErrorCode:" .. tostring(request:getErrorCode()))
        print("ErrowMsg:" .. tostring(request:getErrorMessage()))
	end

	print("----------------------------------------")
end


-- PostLogin
function PostServer( hostName, data )
	print("post Data to Server")
	--requestCount = requestCount + 1
	local requestCount = 0
	local index = requestCount
	local request = network.createHTTPRequest(function ( event )
		if tolua.isnull(self) then
			print("REQUST COMPLETED, BUT SCENE HAS QUIT")
		end
		onResponse(event, index, false)
		if event.name == "completed" then
			local cookie = network.parseCookie(event.request:getCookieString())
			dump(cookie, "GET COOKIE FROM SERVER")
			print("这就是我要的结果")
			print(event.request:getResponseString())
			
			local result = json.decode(event.request:getResponseString())
			print("这就是我要的结果")
			print(result)
		end
		if event.name == "failed" then
			Funcs.alert("与服务器的连接失败")
			return false
		end
	end, hostName, "POST")
	for k,v in pairs(data) do
		request:addPOSTValue(k, v)
	end
	request:setCookieString(network.makeCookieString({C1 = "V1", C2 =  "V2"}))
	printf("REQUEST START %d", index)
	request:start()
end