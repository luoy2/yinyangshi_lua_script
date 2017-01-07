function enter_main_function()
  local current_state = check_current_state()
  if current_state == 1 then
  elseif current_state == 21 then
    my_toast(id, '正在战斗中！等待完成战斗进入主界面。。')
		end_combat(0)
		mSleep(2000)
		return enter_main_function()
  elseif current_state == 22 then
    my_toast(id, '在探索副本')
    tap(80, 100)												--退出探索本
    mSleep(1500)
    tap(1244, 842)
    mSleep(2000)
    tap(1244, 842)
    mSleep(3000)
    enter_party()
    return enter_main_function()
	elseif current_state == 3 then
		my_toast(id, '在探索界面')
		local x, y = myFindColor(顶点退出)
		sysLogLst(x, y)
		tap(x, y)
		mSleep(3000)
		return enter_main_function()
	elseif current_state == 4 then
		local redcross_x, redcross_y = myFindColor(右上红叉)
		tap(redcross_x, redcross_y)
		mSleep(1000)
		return enter_main_function()
	else
		my_toast(id, '请手动进入主界面！')
		mSleep(2000)
		return enter_main_function()
	end
end
        
        
        
        
        
        
        
        
        
-----------------------------------------------------送心--------------------------------------------------
        
        
function give_friend_heart()
	enter_main_function()
	mSleep(1000)
	sub_function:case('friend')
	mSleep(1000)
	local song_t = 0
	local shou_t = 0
	while song_t < 10 or shou_t < 10 do
		local song_x, song_y = myFindColor(送心)
		local shou_x, shou_y = myFindColor(收心)
		if song_x > -1 and song_t < 10 then
			tap(song_x, song_y)
      song_t = song_t +1
      my_toast(id, '送心'..song_t..'/10')
		elseif shou_x > -1 and shou_t < 10 then
			tap(shou_x, shou_y)
			shou_t = shou_t +1
			my_toast(id, '收心'..shou_t..'/10')
		else
			swip(500, 955, 500, 475)
		end
	end
end

function buy_toilet_paper()
	enter_main_function()
	mSleep(1000)
	sub_function:case('shop')
	tap(844, 405)
	mSleep(500)
	local xunzhang_num = dialogInput("请输入兑换勋章的个数(或勋章总数)", "0", "确认");
	local target_num = math.floor(xunzhang_num/20)
	local choice = dialogRet("您想要兑换"..xunzhang_num..'个勋章，共计'..target_num..'厕纸。 确定兑换吗？', "确定", "取消", "", 0);
	sysLog(choice)
	if choice == 1 then 
		lua_exit()
	else
		mSleep(1000)
		local counter = 0
		while counter < target_num do
			tap(821, 651)
			mSleep(1000)
			tap(1037, 938)
			mSleep(1000)
			tap(1000, 1052)
			mSleep(1000)
			counter = counter + 1
			my_toast(id, '厕纸兑换'..counter..'/'..target_num)
		end
	end
end
	
-----------------------------------------------------买厕纸--------------------------------------------------

