-- Basic config for ESP266
WIFI_CONFIG    = {}
WIFI_CONFIG.ssid=""
WIFI_CONFIG.pwd= ""
WIFI_CONFIG.save=true

EXEC_FILE     = "corona_clock.lua"
timeout       = 15

-- Debug mode nukes the init.lua file if something goes wrong, 
--   which makes loading further firmware easier.
-- You probably want to disable this in production.
-- debugMode     = true 
debugMode     = false 

-- Serial parameters
baudrate      = 115200




