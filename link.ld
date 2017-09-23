/* vim: set noet : */

/* 20170827 ld.lld 5.0.0 segfault */
/* MEMORY {                                        */
/* FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 1M   */
/* RAM  (rwx) : ORIGIN = 0x20000000, LENGTH = 320K */
/* }                                               */

FLASH_ORIGIN = 0x08000000;
FLASH_LENGTH = 1M;
RAM_ORIGIN = 0x20000000;
RAM_LENGTH = 320K;

ENTRY(Reset_Handler)

SECTIONS {
	. = FLASH_ORIGIN;

	.text : {
		KEEP(*(.vectors))
		*(.text*)
		*(.rodata*)
	}

	.ARM.extab : {
		*(.ARM.extab* .gnu.linkonce.armextab.*)
	}

	.ARM.exidx : {
		*(.ARM.exidx* .gnu.linkonce.armexidx.*)
	}

	__text_end__ = .;

	. = RAM_ORIGIN;

	.data : AT (__text_end__) {
		. = ALIGN(4);
		__data_top__ = .;
		*(.data*)
		. = ALIGN(4);
		__data_end__ = .;
	}

	.bss :
	{
		. = ALIGN(4);
		__bss_top__ = .;
		*(.bss*)
		*(COMMON)
		. = ALIGN(4);
		__bss_end__ = .;
	}

	__stack_top__ = RAM_ORIGIN + RAM_LENGTH;
}
