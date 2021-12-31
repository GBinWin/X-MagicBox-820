
module(...,package.seeall)

local gps = require"gpsZkw"
--agps功能模块只能配合Air800或者Air530使用；如果不是这两款模块，不要打开agps功能
require "agpsZkw"
require "misc"
local sig = true

local function printGps()
    if gps.isOpen() then
        
        log.info("gps.info",
            gps.isOpen(),gps.isFix(),
            gps.getLocation(),
            gps.getAltitude(),
            gps.getSpeed(),
            gps.getCourse(),
            gps.getViewedSateCnt(),
            gps.getUsedSateCnt())
    end
end


local function openmsg(tag)
    log.info("gps open ok",tag)
end

sys.taskInit(function()

	sys.wait(5000)
	gps.open(gps.DEFAULT,{tag="gps",cb=openmsg})
	
	while true 
	do
		printGps()
		
		disp.setfontheight(16)
		disp.setcolor(0xffff)
		
		disp.puttext(common.utf8ToGb2312("定位功能-------"),0,1)	
		disp.puttext(common.utf8ToGb2312("定位状态-------"),0,20)
		disp.puttext(common.utf8ToGb2312("经度信息-------"),0,40)
		disp.puttext(common.utf8ToGb2312("纬度信息-------"),0,60)
		disp.puttext(common.utf8ToGb2312("海拔高度-------"),0,80)
		disp.puttext(common.utf8ToGb2312("当前速度-------"),0,100)
		disp.puttext(common.utf8ToGb2312("当前角度-------"),0,120)
		disp.puttext(common.utf8ToGb2312("可见卫星-------"),0,140)
		disp.puttext(common.utf8ToGb2312("定位卫星-------"),0,160)
		
		disp.setcolor(0x07E0)
		if gps.isOpen() then
			disp.puttext(common.utf8ToGb2312("打开"),130,1)	
		else 
			disp.puttext(common.utf8ToGb2312("关闭"),130,1)	
		end
		
		if gps.isFix() then
			disp.puttext(common.utf8ToGb2312("成功"),130,20)
		else
			disp.puttext(common.utf8ToGb2312("失败"),130,20)
		end
		
		
		disp.puttext(gps.getLocation().lngType..":"..gps.getLocation().lng,130,40)		
		disp.puttext(gps.getLocation().latType..":"..gps.getLocation().lat,130,60)
		disp.puttext(tostring(gps.getAltitude())..common.utf8ToGb2312("米"),130,80)
		disp.puttext(tostring(gps.getSpeed())..common.utf8ToGb2312("千米/时"),130,100)		
		disp.puttext(tostring(gps.getCourse())..common.utf8ToGb2312("度"),130,120)
		disp.puttext(tostring(gps.getViewedSateCnt())..common.utf8ToGb2312("个"),130,140)
		disp.puttext(tostring(gps.getUsedSateCnt())..common.utf8ToGb2312("个"),130,160)
		
		if sig then
			disp.puttext("--",210,0)
			sig = false
		else
			disp.puttext("|",210,0)
			sig = true
		end
		
		local tm = misc.getClock()		
		local datestr = string.format("%04d",tm.year).."-"..string.format("%02d",tm.month).."-"..string.format("%02d",tm.day)
		local timestr = string.format("%02d",tm.hour)..":"..string.format("%02d",tm.min)..":"..string.format("%02d",tm.sec)	
		disp.setfontheight(24)
		disp.setcolor(0x001F)
		disp.puttext(datestr,50,180)
		disp.puttext(timestr,55,210)
		
		disp.update()
		sys.wait(500)
		disp.clear()
    end
end)

