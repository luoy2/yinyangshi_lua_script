--确认ocr 识别时间不会出错
--突破次数判断  战斗结束后突破次数-1 必须加入recursion 判断

-- 挑战卷： 649,1167,695,1203
-- 勋章数：928,1166,1008,1205
-- 排名： 1598,1164,1705,1206
-- 刷新： 1617,1032,1739,1090


function get_star(input_table)
  for i = 0,5,1 do
    accept_quest()
    x, y = findColorInRegionFuzzy(0xb3a28d, 95, input_table[1]+63*i-2, input_table[2]-2, input_table[1]+63*i+2, input_table[2]+2)
    if x > -1 then
      star = i
      return star
    end
  end
  accept_quest()
  x, y = findColorInRegionFuzzy(0x645a4f, 95, input_table[1]-2, input_table[2]+38, input_table[1]+2, input_table[2]+42)
  if x > -1 then
    return 6   -- 表示打过了
  else 
    return 5
  end
end


function tupo_from_less_star(items)
  local output_table = {}
  local sortedKeys = getKeysSortedByValue(items, function(a, b) return a < b end)
  for _, key in ipairs(sortedKeys) do
    --sysLog(key.." "..items[key])
    table.insert(output_table, key)
  end
  return output_table
end

function enter_tupo()
  local current_state = check_current_state()
  if current_state == 1 then
    enter_tansuo()
		mSleep(1000)
		return enter_tupo()
	elseif current_state == 21 then
		end_combat(0)
		mSleep(1000)
		return enter_tupo()
	elseif current_state == 22 then
		my_toast(id, '在探索副本！')
		tap(80, 100)												--退出探索本
		mSleep(1500)
		tap(1244, 842)
		return enter_tupo()
  elseif current_state == 3 then
    tap(676, 1457)
    mSleep(200)
    tap(676, 1457)
    sleepRandomLag(2000)
  elseif current_state == 4 then
    sleepRandomLag(2000)
  else
    my_toast(id,'请手动进入探索')
    sleepRandomLag(2000)
    return enter_tupo()
  end
end


function tupo(refresh_count, total_avaliable)
	sysLog(refresh_count..'次刷新')
  if total_avaliable == 0 then
    my_toast(id, "没有挑战卷")
    lua_exit()
  end
  
  star_list = {true, true, true,true, true, true,true, true, true}
	
	keepScreen(true)
  for i = 1,9,1 do
    star_list[i] = get_star(all_enemy[i])
    sysLog('结界'..i..'勋章: ' .. get_star(all_enemy[i]))
    my_toast(id,'结界'..i..'勋章: ' .. get_star(all_enemy[i]))
  end
  keepScreen(false)
	
  tupo_order = tupo_from_less_star(star_list)
  refresh_state = true
  local j = 1  --从第一次开始
  while refresh_state do
    accept_quest()
    if refresh_count == 3	then
      ifrefresh_x, ifrefresh_y = findColorInRegionFuzzy(0x343956, 95, 824, 1081, 829, 1090) --3次前面的灰色进度条  
    elseif refresh_count == 6 then
      ifrefresh_x, ifrefresh_y = findColorInRegionFuzzy(0x343956, 95, 1120,1083,1130,1092)  -- 6次前面的灰色进度条
    else
      ifrefresh_x = 1
    end
		sysLog('tupo state: '..ifrefresh_x)
    if ifrefresh_x == -1 or j == 10 then
      sysLog(refresh_count..'次已打完')
      my_toast(id,refresh_count..'次已打完')
      tap(690, 270)
      sleepRandomLag(2000)
      tap(690, 270)
      refresh_state = false
    else
      sysLog('开始突破'..tupo_order[j])
      tap(all_enemy[tupo_order[j]][1], all_enemy[tupo_order[j]][2])
      sleepRandomLag(1000)
      tap(all_enemy[tupo_order[j]][1]+187, all_enemy[tupo_order[j]][2]+131)
      sleepRandomLag(1000)
      start_combat(0)
      sleepRandomLag(3000)
      sysLog('本轮已战斗'..j..'次...')
      my_toast(id,'本轮已战斗'..j..'次...')
      j = j + 1
      total_avaliable = total_avaliable -1
      sysLog('挑战卷: '..total_avaliable)
      if total_avaliable == 0 then
				my_toast(id, "已打完挑战卷！")
        lockDevice();
        lua_exit();
      end
    end
  end
  sleepRandomLag(2000)
  accept_quest()
  x, y = findColorInRegionFuzzy(0xf3b25e, 95, 1585, 1051, 1595, 1066)  --刷新黄色
  if x == -1 then
    accept_quest()
    waiting_orc = ocrText(dict, 1674,1036,1789,1081, {"0x37332e-0x505050"}, 95, 1, 1) 
    for k,v in pairs(waiting_orc) do
      sysLog(string.format('{x=%d, y=%d, text=%s}', v.x, v.y, v.text))
    end
    minutes = tonumber(waiting_orc[1].text)*10 + tonumber(waiting_orc[2].text)
    seconds = tonumber(waiting_orc[3].text)*10 + tonumber(waiting_orc[4].text) + 0.5
    microseconds = (minutes*60+seconds)*1000
    my_toast(id, '等待'..minutes..'分'..seconds..'秒...')
    sysLog('need to wait '..minutes..' minutes and '..seconds..' seconds('..microseconds..' microseconds)')
    mSleep(microseconds + math.random(1000, 3000))
  end
  tap(1700, 1070)  --点击刷新
  sleepRandomLag(1000)
  tap(1230, 885) --点击确定
  sleepRandomLag(2000)
  tupo(refresh_count, total_avaliable)
end