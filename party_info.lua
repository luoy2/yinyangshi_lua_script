join_party = switch {
  [1] = function () tap(1700,630) end, --加入队伍1
  [2] = function () tap(1700,790) end,	--加入队伍2
  [3] = function () tap(1700,960) end,	--加入队伍3
	[4] = function ()	tap(1700,1120) end	--加入队伍4
}



function enter_party1()
		local current_state = check_current_state()
		if current_state == 'party' then
		elseif current_state == 1 then		
			accept_quest()
			local x, y = myFindColor(组队)
			if x > -1 then
				tap(x, y)
				mSleep(500)
			else                               
				toast("没找到组队 ╮（╯▽╰）╭");
			end
			mSleep(1000)
			tap(400, 1250)
			mSleep(500)
			return enter_party()
		--主界面
		elseif current_state == 21 then
			my_toast(id, '正在战斗中！等待完成战斗进入主界面。。')
			end_combat(0)
			mSleep(2000)
			return enter_party()
		elseif current_state == 22 then
			my_toast(id, '在探索副本')
			tap(80, 100)												--退出探索本
			mSleep(1500)
			tap(1244, 842)
			mSleep(2000)
			tap(1244, 842)
			mSleep(3000)
			enter_party()
			return enter_party()
		elseif current_state == 3 then
			my_toast(id, '在探索界面')
			local x, y = myFindColor(顶点退出)
			sysLogLst(x, y)
			tap(x, y)
			mSleep(3000)
			enter_party()
		elseif current_state == 4 then
			local redcross_x, redcross_y = myFindColor(右上红叉)
			tap(redcross_x, redcross_y)
			mSleep(1000)
			return enter_party()
		else
			my_toast(id, '请手动进入主界面！')
			mSleep(2000)
			return enter_party()
		end
end

function enter_party()
local current_state = check_current_state()
if current_state == 'party' then
else
	enter_main_function()
	mSleep(500)
	sub_function:case('party')
	mSleep(1000)
	return enter_party()
end
end



function refresh()
	tap(1200, 1300)
	sleepRandomLag(500)
	accept_quest()
	x, y = findColorInRegionFuzzy(0xe2c36d, 95, 1615, 594, 1623, 607) --找色是否有队伍
	if x > -1 then
		join_party:case(1)
		sleepRandomLag(500)
		--x, y = findImageInRegionFuzzy("refresh.png", 50, 1143, 1264, 1297, 1331, 0); 
		accept_quest()
		x, y = findColorInRegionFuzzy(0xf3b25e, 95, 1091, 1272, 1108, 1283)  --刷新黄色 如果未找到说明在队伍
		if x == -1 then
			toast("已加入队伍")
			start_combat(0)
		else
			sleepRandomLag(200)
			refresh()
		end
	else
	sleepRandomLag(200)
	refresh()
	end
end
------------------------------------------------------妖气封印--------------------------------------------------------
function shiju(time_left)
	if time_left <= 0 then
		sysLog('可以打石距')
		sleepRandomLag(500)
		enter_party()
		swip(400, 1250, 400, 600)
		sleepRandomLag(2000)
		tap(400, 1030)
		refresh()
		_G.time_left = 60*60*1000
	else
		sysLog('等待'.._G.time_left..'毫秒')
	end
end

------------------------------------------------------妖气封印--------------------------------------------------------
function yqfyFindColor(color, position)
	accept_quest()
	local x, y = findMultiColorInRegionFuzzy(color[1], color[2], color[3], position[1], position[2], position[3], position[4])
	return x, y
	end



function find_yaoqi(input_ss)
	keepScreen(true)
	for i = 1,4,1 do
		local x, y = yqfyFindColor(input_ss, yqfy_ocr_table[i])
		if x > -1 then
			sysLog(i)
			return(i)
		end
	end
	keepScreen(false)
end


function refresh_yaoqi(input_ss_table)
	tap(1200, 1300)
	sleepRandomLag(500)
	accept_quest()
	for k,v in pairs(input_ss_table) do
		local slot = find_yaoqi(v)
		if slot ~= nil then
			join_party:case(slot)
			if_outof_sushi()
			sleepRandomLag(1000)
			accept_quest()
			keepScreen(false)
			
			local refresh_x, refresh_y = myFindColor(组队刷新)  --刷新黄色 如果未找到说明在队伍
			sysLog(refresh_x)
			if refresh_x == -1 then
				my_toast(id, "已加入队伍")
				start_combat(0)
				return true
			else
				sleepRandomLag(200)
				return refresh_yaoqi(input_ss_table)
			end
			
		end
	end
	sleepRandomLag(200)
	return refresh_yaoqi(input_ss_table)
end



