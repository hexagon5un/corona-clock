-- This is a boilerplate init that I often use
-- Put secrets and configs in here:
dofile("config.lua")
tryWIFI = 1 -- pre-incremented below

wifi.setmode(wifi.STATION)
wifi.sta.config(WIFI_CONFIG)

-- Which pin are LEDs on?
ws2812b_pin  = 4  -- Pin D4 on my setup
ws2812.init()

-- Debugging convenience function
function print_wifi_status(status)
	if status == wifi.STA_WRONGPWD then
		print("wrong passsword")
	elseif status == wifi.STA_APNOTFOUND then
		print("can't find AP")
	elseif status == wifi.STA_FAIL then
		print("failed")
	elseif status == wifi.STA_GOTIP then 
		print("got IP")
	end
end

-- Loop until WiFi configured, then branch
-- If there's a configuration problem with AP name or PW, 
--   optionally delete the init.lua file and reboot.
counts  = 1
timeout_t=tmr.create()
timeout_t:alarm(1*1000, tmr.ALARM_AUTO, function() 
	status = wifi.sta.status() 
	print_wifi_status(status)
	if (status == wifi.STA_WRONGPWD or status == wifi.STA_APNOTFOUND) then
		print("Wrong PW or ESSID.")
		node.restart()
	end
	if status ~= wifi.STA_GOTIP then	
		-- light LED blue while connecting
		ws2812.write(string.char(0,0,255))
		print("waiting for wifi " .. counts)
		counts = counts + 1
		if counts > timeout then  -- timeout
			timeout_t:unregister()
			print("Timed out.  Restarting.")
			node.restart()
		end
	else
		-- got it. light green and run the main file
		ws2812.write(string.char(255,0,0))
		timeout_t:unregister()
		print(wifi.sta.getip()) 
		print("Go!")
		dofile(EXEC_FILE)
	end 
end
)




