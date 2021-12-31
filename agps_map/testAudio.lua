--- 模块功能：音频功能测试.
-- @author openLuat
-- @module audio.testAudio
-- @license MIT
-- @copyright openLuat
-- @release 2018.03.19

module(...,package.seeall)
--require"record"
require"audio"
require"common"



--播放tts测试接口，每次打开一行代码进行测试
--audio.play接口要求TTS数据为UTF8编码，因为本文件编辑时采用的是UTF8编码，所以可以直接使用ttsStr，不用做编码转换
--如果用户自己编辑脚本时，采用的不是UTF8编码，需要调用common.XXX2utf8接口进行转换
local ttsStr = "支付宝到账2022元。老王， 新年快乐！祝大家，新年快乐"
local function testPlayTts()
	
	audio.setVolume(7)
    --循环播放，音量等级7，循环间隔为2000毫秒
    audio.play(TTS,"TTS",ttsStr,1,nil,true,5000)
end



--audio.setChannel(1)

--每次打开下面的一种分支进行测试


    --if string.match(rtos.get_version(),"TTS") then
        sys.timerStart(testPlayTts,5000)

    --end




