--
-- Author: UHEVER
-- Date: 2015-03-16 09:39:38
--
module("Net", package.seeall)

requestCount = 0

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