--
init("0", 1)
--setScreenScale(1536,2048)
width,height = getScreenSize()
sysLog("width: "..width.."; height: "..height)


require "utils"
require "party_info"
require "yuhun_info"
require "inCombat"
require "tansuo"
require "xuche"
require "tupo"
require "spec"
require "richang"
require '悬赏封印'
pos = require("bblibs/pos")

dict = createOcrDict("dict.txt") 
id = createHUD()     --创建一个HUD
my_toast(id,"欢迎使用大便脚本！")     --显示HUD内容




function main()
  ret,results = showUI("ui.json")
  if ret==0 then	
    toast("您选择了取消，停止脚本运行")
    lua_exit()
  else
    toast_screensize()
    
    --↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓获取UI配置↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
    -------------------------------------------个人突破--------------------------------------
    if results['100'] == '0' then	
      tupo_ret,tupo_results = showUI("tupo.json")
			return main_tupo(tupo_ret,tupo_results)

      
      -------------------------------------------石距--------------------------------------
    elseif results['100'] == '1' then
			dialog("功能开发中， 请关注更新日志，将于最近上线")
  
      -------------------------------------------御魂10--------------------------------------
    elseif results['100'] == '2' then
      yh_ret,yh_results = showUI("yuhun.json")
			return main_yh(yh_ret,yh_results)
      -------------------------------------------阴阳寮续车--------------------------------------	
    elseif results['100'] == '3' then
      xu_che()
      -------------------------------------------探索--------------------------------------
    elseif results['100'] == '4' then
      ts_ret,ts_results = showUI("tansuo.json")
			return main_tansuo(ts_ret, ts_results)
      
      -------------------------------------------业原火--------------------------------------	
    elseif results['100'] == '5' then
      enter_yeyuanhuo()
      yyh_ret,yyh_results = showUI("yeyuanhuo.json")
			return main_yeyuanhuo(yyh_ret,yyh_results)
      -------------------------------------------妖气封印--------------------------------------	
    elseif results['100'] == '6' then
      yqfy_ret,yqfy_results = showUI("yqfy.json")
			return main_yqfy(yqfy_ret, yqfy_results)
      
      -------------------------------------------日常杂项--------------------------------------	
    elseif results['100'] == '7' then
      richang_ret,richang_results = showUI("richang.json")
			main_richang(richang_ret,richang_results)
      -------------------------------------------开发中--------------------------------------	
    else 
      dialog("你tm什么都没设置，玩儿我吧？")
      lua_exit()
      
    end
  end
  
  
end

function in_party()
	local statue = party_statue()
	while statue == 1 do
			mSleep(500)
			my_toast(id, '等待队伍开始')
			statue = party_statue()
	end
		if statue == 2 then
			my_toast(id, '进入战斗')
			mSleep(500)
		else
			my_toast(id, '队长跑了,自己开始队伍')
			tap(1547, 1157)
			if_outof_sushi()
			sleepRandomLag(1000)
	end
end

main()

--[[
enter_main_function()
my_swip(200, 1250, 1800, 1250, 50)
local feng_x, feng_y = myFindColor(悬赏)
if feng_x > -1 then tap(feng_x, feng_y) else sysLog('couldnt find feng') end
]]--













------------------------------------------------------------------------------


-----------------------------------------------------------------------------

--[[
find_yaoqi(海坊主)
find_yaoqi(小黑)
find_yaoqi(经验)
find_yaoqi(金币)
find_yaoqi(椒图)
find_yaoqi(二口女)
find_yaoqi(骨女)
find_yaoqi(哥哥)
find_yaoqi(饿鬼)
--snapshot("invite_na.png", 697,693,805,734); --全屏截图（分辨率1080*1920）
--]]

--/User/Library/XXIDEHelper/xsp/Temp/5星.png

--page 2





