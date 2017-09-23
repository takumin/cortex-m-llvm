target remote | openocd -f "board/stm32f7discovery.cfg" -c "gdb_port pipe"

monitor reset halt
load
monitor reset init

thbreak Reset_Handler

continue
