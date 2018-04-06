PRJ=llvm-cortex-m7
SRC=main.c start.c
LDSCRIPT=link.ld

CC=clang-7
LD=ld.lld-7
SIZE=llvm-size-7
COPY=llvm-objcopy-7
READ=llvm-readelf-7
DUMP=llvm-objdump-7
GDB=arm-none-eabi-gdb

CFLAGS=-c
CFLAGS+=--target=thumbv7em-unknown-none-eabi
CFLAGS+=-mthumb
CFLAGS+=-march=armv7e-m
CFLAGS+=-mcpu=cortex-m7
CFLAGS+=-mfloat-abi=hard
CFLAGS+=-mfpu=fpv5-sp-d16
CFLAGS+=-ffreestanding
CFLAGS+=-Og
CFLAGS+=-g
CFLAGS+=-gdwarf-5
CFLAGS+=-gembed-source
CFLAGS+=-gmodules
CFLAGS+=-gz
CFLAGS+=-pg
CFLAGS+=-std=c11
CFLAGS+=-Weverything

LDFLAGS=--Bstatic
LDFLAGS+=--build-id
LDFLAGS+=--gc-sections
LDFLAGS+=--Map $(PRJ).map
LDFLAGS+=--script $(LDSCRIPT)

SZFLAGS=-A
SZFLAGS+=-x

OBJ=$(SRC:.c=.o)

.PHONY: all
all: $(PRJ).elf

%.o: %.c
	@echo " CC $^"
	@$(CC) -o $@ $(CFLAGS) $^

$(PRJ).elf: $(OBJ)
	@echo " LD $@"
	@$(LD) -o $@ $(LDFLAGS) $^
	@echo " READ -> $(PRJ).rd"
	@$(READ) -sections -symbols $(PRJ).elf > $(PRJ).rd
	@echo " LIST -> $(PRJ).lst"
	@$(DUMP) -t $(PRJ).elf > $(PRJ).lst
	@echo " COPY -> $(PRJ).bin"
	@$(COPY) -O binary $(PRJ).elf $(PRJ).bin
	@$(SIZE) $(SZFLAGS) $(PRJ).elf

.PHONY: debug
debug: $(PRJ).elf
	@$(GDB) -x $(PWD)/.gdbinit $(PRJ).elf

.PHONY: clean
clean:
	@echo " CLEAN"
	@rm -fR $(OBJ) $(PRJ).elf $(PRJ).map $(PRJ).rd $(PRJ).lst $(PRJ).bin
