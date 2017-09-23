/* vim: set noet : */

/* 20170827 ld.lld 5.0.0 segfault */
/* MEMORY {                                        */
/* FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 1M   */
/* RAM  (rwx) : ORIGIN = 0x20000000, LENGTH = 320K */
/* }                                               */

ROM_ORIGIN = 0x08000000;
ROM_LENGTH = 1024K;
RAM_ORIGIN = 0x20000000;
RAM_LENGTH = 320K;

ENTRY(Reset_Handler)

SECTIONS {
	. = ROM_ORIGIN;

	.vector : {
		. = ALIGN(4);
		__vector_top__ = .;
		KEEP(*(.vectors))
		. = ALIGN(4);
		__vector_end__ = .;
	}

	.text : {
		. = ALIGN(4);
		__text_top__ = .;
		*(.text*)
		. = ALIGN(4);
		__text_end__ = .;

		. = ALIGN(4);
		__rodata_top__ = .;
		*(.rodata*)
		. = ALIGN(4);
		__rodata_end__ = .;

		. = ALIGN(4);
		__buildid_top__ = .;
		*(.note.gnu.build-id)
		. = ALIGN(4);
		__buildid_end__ = .;
	}

	.ARM.extab : {
		*(.ARM.extab* .gnu.linkonce.armextab.*)
	}

	.ARM.exidx : {
		*(.ARM.exidx* .gnu.linkonce.armexidx.*)
	}

	__data_start__ = .;
	. = RAM_ORIGIN;

	.data : {
		. = ALIGN(4);
		__data_top__ = .;
		*(.data*)
		. = ALIGN(4);
		__data_end__ = .;
	}

	.bss (NOLOAD) :
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
