module(...,package.seeall)
require"pins"
require"common"

CHAR_WIDTH = 8

BL = pins.setup(4,0)
BL(0)

isSleep = true
function sleep()
    if isSleep then return end
    pm.sleep("lcd_up")
    isSleep = true
    disp.sleep(1)
    BL(0)
end
function wake(f)
    if not isSleep then return end
    pm.wake("lcd_up")
    isSleep = nil
    disp.sleep(0)
    if not f then
        page.update()
    end
    BL(1)
    io.unmount(io.SDCARD)
    io.mount(io.SDCARD)
end


--rgb值转rgb565
function rgb(r,g,b)
    return (r-r%8)/8*2048 + (g-g%4)/4*32 + (b-b%8)/8
end

--放置文字，自动转码
function text(s,x,y,r,g,b)
    if r and g and b then
        disp.setcolor(rgb(r,g,b))
    end
    disp.puttext(common.utf8ToGb2312(s),x,y)
end
--居中显示文字
function putStringCenter(s,x,y,r,g,b)
    local str = common.utf8ToGb2312(s)
    text(s,x-str:len()*((CHAR_WIDTH-CHAR_WIDTH%2)/2),y,r,g,b)
end
--靠右显示文字
function putStringRight(s,x,y,r,g,b)
    local str = common.utf8ToGb2312(s)
    text(s,x-str:len()*CHAR_WIDTH,y,r,g,b)
end

--快速计算y
function gety(l)
    return l*CHAR_WIDTH*2
end

--快速计算x
function getx(l)
    return l*CHAR_WIDTH
end

sys.taskInit(function()
    --sys.waitUntil("LCD_INIT")
    sys.wait(200)
    wake(1)
    CHAR_WIDTH = 16
    disp.setfontheight(32)
    disp.clear()
    for i=1,51 do
        local c = i*5
        putStringCenter("BinWin",120,90,c,c,c)
        putStringCenter("GPS轨迹记录",120,130,c,c,c)
        disp.update()
    end
	
    CHAR_WIDTH = 16
    disp.setfontheight(16)

end)

