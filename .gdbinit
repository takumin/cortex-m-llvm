target remote | openocd -f "board/stm32f7discovery.cfg" -c "gdb_port pipe"

monitor reset halt
# 20170924 ld.lld-6.0 Segmentation fault (core dumped)
load
monitor reset init

thbreak Reset_Handler
thbreak main

continue
