--- testMqtt

require "mqtt"
require "agpsZkw"
local mqtt_gps = require"gpsZkw"

module(..., package.seeall)

-- 这里请填写修改为自己的IP和端口
--local host, port = "lbsmqtt.airm2m.com", 1884
local host, port = "mq.tongxinmao.com", 18830

-- 测试MQTT的任务代码
sys.taskInit(function()
    while true do
        while not socket.isReady() do sys.wait(1000) end
        local mqttc = mqtt.client(misc.getImei(), 300, "", "")
        while not mqttc:connect(host, port) do sys.wait(2000) end
       
            while true do
       
                --mqttc:publish("/820msg", "test publish" .. os.time())
				--mqttc:publish("/820msg", "test publish")
				
				mqttc:publish("820/gps", mqtt_gps.getLocation().lngType..mqtt_gps.getLocation().lng..","..mqtt_gps.getLocation().latType..mqtt_gps.getLocation().lat)
				sys.wait(5000)
                   
            end
    end
end)

