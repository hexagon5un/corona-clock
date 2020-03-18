LUAFILES:= config.lua init.lua corona_clock.lua
PORT=/dev/ttyUSB1
BAUD=115200

all: flash restart term

flash: $(LUAFILES) 
	# make restart
	nodemcu-uploader -p $(PORT) upload $^

restart:
	echo "node.restart()" | cat > $(PORT)
	sleep 1s

term:
	pyterm $(PORT) $(BAUD)

