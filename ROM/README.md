## NodeMCU

This ROM was built on 2020-03-15. 

This was built against the master branch and includes the following modules: file, gpio, mqtt, net, node, sntp, tmr, uart, wifi,
ws2812, ws2812_effects.

## Flashing

```esptool.py --port /dev/ttyUSB1 --baud 115200 write_flash -fm dio -fs 8m 0x00000 /nodemcu-master-11-modules-2020-03-15-20-12-32-integer.bin && pyterm /dev/ttyUSB1 115200```

Naturally, substitute whichever serial port you've got.  

Once it's flashed, open up a serial port to it, and then hit reset.  If it's the first NodeMCU install on the ESP, it will then create a filesystem to store your programs on.  If you skip this reset, you will be wondering why it doesn't work, until you unplug and replug it later on.


