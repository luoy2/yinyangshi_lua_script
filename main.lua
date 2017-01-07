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
      enter_tupo()
      accept_quest()
      local tupo_avaliable_ocr = ocrText(dict, 650,1166,696,1203, {"0x37332e-0x505050"}, 92, 1, 1) -- 表示范围内横向搜索，以table形式返回识别到的所有结果及其坐标
      local tupo_avaliable = 0
      for k,v in pairs(tupo_avaliable_ocr) do
        sysLog(string.format('{x=%d, y=%d, text=%s}', v.x, v.y, v.text))
        tupo_avaliable = tupo_avaliable*10 + tonumber(v.text)
      end
      my_toast(id, '挑战卷个数: '..tupo_avaliable)
      sysLog('挑战卷个数: '..tupo_avaliable)		
      if tupo_results['100'] == '0' then
        tupo(3, tupo_avaliable)
      elseif tupo_results['100'] == '1' then
        tupo(6, tupo_avaliable)
      else
        tupo(9, tupo_avaliable)
      end
      
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
      --------------------------------队长2人---------------------------------
      mark_1 = tonumber(yh_results['201']) + 2
      mark_2 = tonumber(yh_results['202']) + 2
      mark_3 = tonumber(yh_results['203']) + 2
			if mark_2 == 5 then mark_2 = 6 end
			if mark_3 == 5 then mark_3 = 6 end
      mark_case = {mark_1, mark_2, mark_3}
      printTable(mark_case)
      if yh_results["101"]== "0" then
        toast("开始魂10自动战斗，请进入组队界面后创建队伍，邀请基友"); 
        mSleep(2000)
        while true do 
          team_leader(mark_case, 2)
        end
        --------------------------------队长3人---------------------------------
      elseif yh_results["101"] == "1" then
        toast("开始魂10自动战斗，请进入组队界面后创建队伍，邀请基友"); 
        mSleep(2000)
        while true do 
          team_leader(mark_case, 3)
        end
        --------------------------------加入队伍--------------------------------
      elseif yh_results['101'] == '2' then
        task = "加入队伍"
        --------------------------------等待邀请---------------------------------
      elseif yh_results["101"] == "3" then
        toast("开始魂10自动战斗，请等待基友邀请"); 
        sleepRandomLag(2000)
        while true do 
          accept_invite(mark_case)
        end
        --[[	
      elseif yh_results["101"] == "4" then
        recursive_task()
      elseif yh_results["101"] == "5" then
        while true do 
          solo_yh(mark_case)
        end
        --]]
      else
        dialog("你tm什么都没设置，玩儿我吧？")
        lua_exit()
      end
      -------------------------------------------阴阳寮续车--------------------------------------	
    elseif results['100'] == '3' then
      xu_che()
      -------------------------------------------探索--------------------------------------
    elseif results['100'] == '4' then
      ts_ret,ts_results = showUI("tansuo.json")
      if ts_ret==0 then	
        toast("您选择了取消，停止脚本运行")
        lua_exit()
      end
      local fight_times = tonumber(ts_results['99'])
      local skip_lines = tonumber(ts_results['100'])
      local search_times = tonumber(ts_results['101'])
      if fight_times == 0 then
        fight_times = 999999
      end
      tansuo(fight_times, search_times, skip_lines)
      -------------------------------------------业原火--------------------------------------	
    elseif results['100'] == '5' then
      enter_yeyuanhuo()
      yyh_ret,yyh_results = showUI("yeyuanhuo.json")
      if yyh_ret==0 then	
        toast("您选择了取消，停止脚本运行")
        lua_exit()
      end
      local times = tonumber(yyh_results['100'])
      local difficulty = tonumber(yyh_results['101'])+1
      yeyuanhuo(times, difficulty)
      -------------------------------------------妖气封印--------------------------------------	
    elseif results['100'] == '6' then
      yqfy_ret,yqfy_results = showUI("yqfy.json")
      if yqfy_ret==0 then	
        toast("您选择了取消，停止脚本运行")
        lua_exit()
      end
			--[[
			ss_list = {海坊主, 小黑, 二口女, 骨女, 哥哥, 经验, 金币, 椒图, 饿鬼}
      local fight_times = tonumber(yqfy_results['100'])
      local ss_index = str_split((yqfy_results['101']))
      for k,v in pairs(ss_index) do ss_index[k] = ss_index[k]+1 end          -- format index
      for k,v in pairs(ss_index) do sysLogLst(k,v) end											
      ss_target_table = {}
      for k,v in pairs(ss_index) do table.insert(ss_target_table, ss_list[v]) end	
      if fight_times == 0 then
        fight_times = 999999
      end
      local current_ss_time = 0
      while current_ss_time <= fight_times do
        enter_party()
        tap(400, 1230)
        my_toast(id, '开始刷碎片!')
        mSleep(500)
        refresh_yaoqi(ss_target_table)
        current_ss_time = current_ss_time + 1
        sysLog('刷怪次数： '..current_ss_time..' 总次数： '..fight_times)
      end
			--]]
			ss_list = {海坊主, 小黑, 二口女, 骨女, 哥哥, 经验, 金币, 椒图, 饿鬼, '石距'}
      local fight_times = tonumber(yqfy_results['100'])
      local ss_index = str_split((yqfy_results['101']))
			_G.time_left = tonumber(yqfy_results['102'])*60*1000
			sysLog(_G.time_left)
			local current_ss_time = 0
			if fight_times == 0 then
        fight_times = 999999
      end							
      ss_target_table = {}
      for k,v in pairs(ss_index) do 
				ss_index[k] = ss_index[k] + 1
				table.insert(ss_target_table, ss_list[ss_index[k]])
			end	
			sysLog(tablelength(ss_target_table))
			
			
			if table.contains(ss_target_table, '石距') then
				sysLog('需要打章鱼')
				table.remove(ss_target_table, tablelength(ss_target_table))
				local initial_t = mTime()
				while current_ss_time <= fight_times do
					_G.time_left = _G.time_left - (mTime() - initial_t)
					sysLog(_G.time_left)
					shiju(_G.time_left)
					enter_party()
					tap(400, 1230)
					my_toast(id, '开始刷碎片!')
					mSleep(500)
					refresh_yaoqi(ss_target_table)
					current_ss_time = current_ss_time + 1
					sysLog('刷怪次数： '..current_ss_time..' 总次数： '..fight_times)
				end
      else
					while current_ss_time <= fight_times do
					enter_party()
					tap(400, 1230)
					my_toast(id, '开始刷碎片!')
					mSleep(500)
					refresh_yaoqi(ss_target_table)
					current_ss_time = current_ss_time + 1
					sysLog('刷怪次数： '..current_ss_time..' 总次数： '..fight_times)
				end
			end
      
      -------------------------------------------日常杂项--------------------------------------	
    elseif results['100'] == '7' then
      richang_ret,richang_results = showUI("richang.json")
      if richang_ret==0 then	
        toast("您选择了取消，停止脚本运行")
        lua_exit()
      end
      sysLog(richang_results['101'])
      if richang_results['101'] == '4' then
				if richang_results['100'] == '0' then
          give_friend_heart()
        elseif richang_results['100'] == '1' then
          buy_toilet_paper()
        end
        mSleep(1000)
				enter_main_function()
				lua_exit()
				
			elseif richang_results['101'] == '0' then											--肝狗粮,结界突破,妖气封印,挂业原火
        ts_ret,ts_results = showUI("tansuo.json")
        if ts_ret==0 then	
          toast("您选择了取消，停止脚本运行")
          lua_exit()
        end
        local fight_times = tonumber(ts_results['99'])
        local skip_lines = tonumber(ts_results['100'])
        local search_times = tonumber(ts_results['101'])
        if fight_times == 0 then
          fight_times = 999999
        end
        
        if richang_results['100'] == '0' then
          give_friend_heart()
        elseif richang_results['100'] == '1' then
          buy_toilet_paper()
        end
        mSleep(1000)
        tansuo(fight_times, search_times, skip_lines)
        
      elseif richang_results['101'] == '1' then			
        tupo_ret,tupo_results = showUI("tupo.json")
        if richang_results['100'] == '0' then
          give_friend_heart()
        elseif richang_results['100'] == '1' then
          buy_toilet_paper()
        end
        mSleep(1000)
        
        enter_tupo()
        accept_quest()
        local tupo_avaliable_ocr = ocrText(dict, 650,1166,696,1203, {"0x37332e-0x505050"}, 92, 1, 1) -- 表示范围内横向搜索，以table形式返回识别到的所有结果及其坐标
        local tupo_avaliable = 0
        for k,v in pairs(tupo_avaliable_ocr) do
          sysLog(string.format('{x=%d, y=%d, text=%s}', v.x, v.y, v.text))
          tupo_avaliable = tupo_avaliable*10 + tonumber(v.text)
        end
        my_toast(id, '挑战卷个数: '..tupo_avaliable)
        sysLog('挑战卷个数: '..tupo_avaliable)		
        if tupo_results['100'] == '0' then
          tupo(3, tupo_avaliable)
        elseif tupo_results['100'] == '1' then
          tupo(6, tupo_avaliable)
        else
          tupo(9, tupo_avaliable)
        end	
        
      elseif richang_results['101'] == '2' then
        yqfy_ret,yqfy_results = showUI("yqfy.json")
        if yqfy_ret==0 then	
          toast("您选择了取消，停止脚本运行")
          lua_exit()
        end
				
				ss_list = {海坊主, 小黑, 二口女, 骨女, 哥哥, 经验, 金币, 椒图, 饿鬼, '石距'}
				local fight_times = tonumber(yqfy_results['100'])
				local ss_index = str_split((yqfy_results['101']))
				_G.time_left = tonumber(yqfy_results['102'])*60*1000
				sysLog(_G.time_left)
				local current_ss_time = 0
				if fight_times == 0 then
					fight_times = 999999
				end							
				ss_target_table = {}
				for k,v in pairs(ss_index) do 
					ss_index[k] = ss_index[k] + 1
					table.insert(ss_target_table, ss_list[ss_index[k]])
				end	
				sysLog(tablelength(ss_target_table))
				
        if richang_results['100'] == '0' then
          give_friend_heart()
        elseif richang_results['100'] == '1' then
          buy_toilet_paper()
        end
        mSleep(1000)
				
				if table.contains(ss_target_table, '石距') then
					sysLog('需要打章鱼')
					table.remove(ss_target_table, tablelength(ss_target_table))
					local initial_t = mTime()
					while current_ss_time <= fight_times do
						_G.time_left = _G.time_left - (mTime() - initial_t)
						sysLog(_G.time_left)
						shiju(_G.time_left)
						enter_party()
						tap(400, 1230)
						my_toast(id, '开始刷碎片!')
						mSleep(500)
						refresh_yaoqi(ss_target_table)
						current_ss_time = current_ss_time + 1
						sysLog('刷怪次数： '..current_ss_time..' 总次数： '..fight_times)
					end
				else
						while current_ss_time <= fight_times do
						enter_party()
						tap(400, 1230)
						my_toast(id, '开始刷碎片!')
						mSleep(500)
						refresh_yaoqi(ss_target_table)
						current_ss_time = current_ss_time + 1
						sysLog('刷怪次数： '..current_ss_time..' 总次数： '..fight_times)
					end
				end
        
      elseif richang_results['101'] == '3' then
        enter_yeyuanhuo()
        yyh_ret,yyh_results = showUI("yeyuanhuo.json")
        if yyh_ret==0 then	
          toast("您选择了取消，停止脚本运行")
          lua_exit()
        end
        if richang_results['100'] == '0' then
          give_friend_heart()
        elseif richang_results['100'] == '1' then
          buy_toilet_paper()
        end
        mSleep(1000)
        local times = tonumber(yyh_results['100'])
        local difficulty = tonumber(yyh_results['101'])+1
        yeyuanhuo(times, difficulty)
      end
      
      
      -------------------------------------------开发中--------------------------------------	
    else 
      dialog("你tm什么都没设置，玩儿我吧？")
      lua_exit()
      
    end
  end
  
  
end



	
main()

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





yy_x, yy_y = findImageInRegionFuzzy("invite_na.png", 50,555,631,1484,1359, 0);
if yy_x ~= -1 then        --如果在指定区域找到某图片符合条件
  tap(yy_x, yy_y);            --那么单击该图片
  sysLog(yy_x..';'..yy_y)
else                               --如果找不到符合条件的图片
  my_toast(id,"未找到符合条件的坐标！");
  mSleep(1000)
end
tap(1052,353)													--点击寄存
sleepRandomLag(3000)
tap(110, 1420)  												--点开全部式神
sleepRandomLag(500)
--tap(351, 1180) 												-- 选择sr
tap(425, 1312)													--ssr
sleepRandomLag(1000)
swip(293, 1400, 1800, 600)  			--拖动酒吞进入寄存
sleepRandomLag(1000)
tap(1200, 1030)												-- 点击确认
sleepRandomLag(1000)
tap(70, 70)														-- 退出界面
sleepRandomLag(1000)
tap(70, 70)
sleepRandomLag(3000)
tap(1846, 308)
toast('开始等待6小时')
mSleep(6*3600*1000)

--snapshot("invite_na.png", 697,693,805,734); --全屏截图（分辨率1080*1920）
--]]

--/User/Library/XXIDEHelper/xsp/Temp/5星.png

--page 2





