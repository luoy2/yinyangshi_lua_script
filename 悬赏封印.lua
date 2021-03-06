f_zero = {0xdad4c3,"3|6|0xcec8b7,3|9|0xddd7c5,2|13|0xe9e4d2,2|17|0xf8f2e0,0|21|0xdcd6c5,-4|23|0xd2ccbb,-11|19|0xdad5c3,-11|14|0xdbd6c4,-4|-2|0xd0cab9",85}
f_one = {0xf2edda,"0|2|0xf5f0dd,0|3|0xf0ead8,0|5|0xe8e2d0,0|6|0xe6e0ce,0|8|0xe2ddcb,0|11|0xded8c6,0|15|0xddd8c6,1|24|0xf4efdc,-3|3|0xd0cab9",85}
f_two = {0xc3bcac,"6|0|0xd7d1c0,9|4|0xdad4c3,9|8|0xeae5d3,5|15|0xdbd5c4,-2|21|0xe4decc,-2|24|0xefead7,4|24|0xccc6b5,10|23|0xe9e4d2,-3|5|0xede8d6",85}
f_three = {0xe0dac9,"7|-1|0xdad4c3,9|1|0xebe6d3,9|6|0xece7d4,6|9|0xe0dbc9,0|10|0xaea798,9|11|0xcfc9b8,11|16|0xf4efdc,9|22|0xf6f1de,-2|3|0xd3cdbc",85}
f_four = {0xf3eedb,"-2|2|0xcec8b7,-4|5|0xc5bfae,-6|7|0xa0998a,-10|13|0xb8b1a2,-5|16|0xaaa393,2|15|0xf2edda,2|22|0xc6c0af,6|14|0x847c6f,1|-3|0xded8c6",90}
f_five = {0xa49e8e,"-3|0|0xdad5c3,-4|12|0xd2ccbb,1|9|0xaca596,8|13|0xd7d1c0,7|24|0x958e80,1|26|0xa69f8f,-6|21|0x968f81,0|23|0x938c7e,8|0|0xc2bcab",90}
f_seven = {0xded9c7,"2|-1|0xcfc9b8,7|-2|0xe7e2cf,10|1|0xf0ebd8,9|5|0xdad4c2,7|9|0xf1ecd9,5|14|0xf3eedb,4|17|0xe5dfcd,2|20|0xe6e1cf,-2|1|0xe4dfcd",85}
f_slash = {0xd2ccbb,"-1|2|0xa49d8e,-2|4|0xede7d5,-3|6|0xa59e8f,-4|8|0xd2ccbb,-5|10|0xa9a293,-7|14|0xb4ae9e,-9|18|0xc7c0b0,-10|21|0xa29b8c,13|23|0xd6d0bf",85}
f_num = {f_zero, f_one, f_two, f_three, f_four,f_five, f_seven}

fy_chapter = {
shouwu = {13, 0}, shantu = {16, 0}, duyan = {11,0}, chounv = {10,0}, jue = {10,0}, zhoushen = {8, 0}, 
jiumingmao ={18, 1}, hudiejing = {6, 0}, taohuayao = 'yh_3'}




-------------------------------------------------------------------------------

function xsFindColor(color, position)
	accept_quest()
	local point = findMultiColorInRegionFuzzyExt(color[1], color[2], color[3], position[1], position[2], position[3], position[4])
	if #point ~= 0 then  --如果找到符合条件的点
    for var = 1,#point do
        sysLog(point[var].x..":"..point[var].y)
    end
	end
	return point
end

function find_xuanshang()
	keepScreen(true)
	for i = 1,3,1 do
		sysLog(i..':')
		for j = 1, 7, 1 do
			local x, y = xsFindColor(f_num[j], xuanshang_t_table[i])
			sysLog(j-1)
		end
	end
	keepScreen(false)
end


--------------11------------------
fy_target = {0xffffec,"-19|10|0xffffec,-35|26|0xffffff,6|24|0xf7b9c4,-8|24|0x563419,24|14|0x452815",90,0,0,1535,2047}
战斗图标 = {0xdbddfc,"5|6|0x8d8eba,-14|-9|0x394275,23|16|0x32396a,-9|36|0xeb9fa8,-2|-44|0xf3b0bb,42|5|0xd28389",90,0,0,1535,2047}

function search_for_fy(fight_times, search_times, skip_lines)
	sysLog('search_for_fy')
	local if_fight = false
  local count = 0
  my_toast(id, '寻找封印怪。。。')
  while count < search_times do
		local qTime = mTime()
    accept_quest()
		keepScreen(true)
    local f_x, f_y = myFindColor(fy_target)
		keepScreen(false)
    if f_x > -1 then
      my_toast(id, '找到封印怪')
      --sysLog('x:'..exp_x..' y:'..exp_y)
      result = '找到封印怪'
      --toast("s:" .. result .. "time:" .. mTime() - qTime)
			tap(f_x, f_y)
			if_outof_sushi()
			mSleep(500)
			my_toast(id, '检测狗粮')
			accept_quest()
			local ready_x, ready_y = findMultiColorInRegionFuzzy(0xfffffa,"5|-39|0xfffff9,27|-34|0xfff3d1,27|-1|0xfffaeb,51|-17|0xfff2d0", 90, 1789, 1274, 1798, 1283)
			while ready_x == -1 do
				mSleep(500)
				accept_quest()
				ready_x, ready_y = findMultiColorInRegionFuzzy(0xfffffa,"5|-39|0xfffff9,27|-34|0xfff3d1,27|-1|0xfffaeb,51|-17|0xfff2d0", 90, 1789, 1274, 1798, 1283)
			end
			my_toast(id, '可以准备')
			if_change(slot, skip_lines)
			start_combat(0)
			mSleep(2000)
			if_fight = true
    else
      result = '未找到'
      --toast("s:" .. result .. "time:" .. mTime() - qTime)
    end
    count = count + 1
  end
	return if_fight
end

function slow_next_scene()
	sysLog('next_scene')
  my_swip(1977, 1346, 1700, 1346, 10)
end

function one_dungeon_fengyin(skip_lines)
	local bool_table = {}
	for find_time = 1, 8, 1 do
		slow_next_scene()  --4次
		table.insert(bool_table, search_for_fy(0, 3, skip_lines))
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




function fy_one_monster(monster_chapter, skip_lines, difficuty)
	enter_tansuo()
	choose_chapter(monster_chapter)
	enter_dungeon(difficuty)
	mSleep(3000)
	while one_dungeon_fengyin(skip_lines) do 	
		enter_tansuo()
		local currentchapter_x, currentchapter_y = findMultiColorInRegionFuzzy(0xa88341,"0|-6|0x4c3828,0|9|0xd9d0bf", 95, 835, 534, 1173, 859)
		if currentchapter_x > -1 then
			sysLog('kuajierukou')
			tap(1010, 710)
			mSleep(1000)
		else
			choose_chapter(monster_chapter)
		end
		enter_dungeon(difficuty)
	end
	my_toast(id, '封印一次完成')
end

function fy_all(fy_order, skip_lines)
	for _, v in pairs(fy_order) do
		fy_one_monster(v[1], skip_lines, v[2])
	end
		sysLog('任务结束')
		enter_main_function()
end



--fy_order = {fy_chapter['hudiejing']}
--fy_all(fy_order, 0)

function find_mystery_monster(input_str)

end



