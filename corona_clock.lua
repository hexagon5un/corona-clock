-- get time
sntp.sync()

buffer = ws2812.newBuffer(60,3)
buffer:fill(0, 0, 0)

-- this is the timestamp of any midnight
-- in the past in your time zone
-- does _not_ handle daylight savings time
-- unix time, in seconds
midnight = 1541372400
-- on and off times, in seconds elapsed
six_am = 6 * 60 * 60
nine_pm = 21 * 60 * 60

-- how many seconds have elapsed today?
function get_modulo_seconds()
	sec, usec = rtctime.get()
	sec = sec - midnight
	sec = sec % 86400 
	return sec
end

-- update display buffer
-- ten-second resolution is silly, but I'm not saving power anyway.
-- why not 1 second?  why not 10 minutes?  meh.
t=tmr.create()
t:alarm(10*1000, tmr.ALARM_AUTO, function() update_buffer(); ws2812.write(buffer); end)

-- light the lights that need to be lit
function update_buffer()
	timenow = get_modulo_seconds() 
	buffer:fill(0, 0, 0)
	if timenow > six_am and timenow < nine_pm then
		whichlight = (timenow - six_am) / (15*60) + 1
		buffer:set(whichlight, 0, 0, 255)
		-- 0, 0, 255 is blue.  Do fancy things with color here?
	end
end


