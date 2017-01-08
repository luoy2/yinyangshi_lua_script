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
      --dialog("开始打章鱼，请于五秒内进入主界面")
      sleepRandomLag(500)
      enter_party()
      swip(400, 1250, 400, 600)
      sleepRandomLag(2000)
      tap(400, 1030)
      refresh()
  
      
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


main()

--[[
enter_main_function()
my_swip(200, 1250, 1800, 1250, 50)
local feng_x, feng_y = myFindColor(悬赏)
if feng_x > -1 then tap(feng_x, feng_y) else sysLog('couldnt find feng') end
]]--













------------------------------------------------------------------------------

function one_dungeon_fengyin(skip_lines)
	local bool_table = {}
	for find_time = 1, 6, 1 do
		slow_next_scene()  --4次
		table.insert(bool_table, search_for_fy(0, 10, skip_lines))
	end
	for _,v in pairs(bool_table) do
		if v == true then
			sysLog('此轮有找到怪')
			return true
		else
			sysLog('此轮没有找到怪')
		end
	end
	return false
end




function fy_one_monster(monster_chapter, skip_lines, model)
	if type(elem) == "table" then 
	enter_tansuo()
	choose_chapter(monster_chapter)
	enter_dungeon()
	one_dungeon_fengyin(0, 5, skip_lines)
	mSleep(3000)
	while one_dungeon_fengyin(0, 5, 0) do 	
		enter_tansuo()
		choose_chapter(monster_chapter)
		enter_dungeon()
	end
	enter_main_function()
	my_toast(id, '封印完成')
end

--fy_one_monster(fy_chapter['shouwu'], 0, 'easy')
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





