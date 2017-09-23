/* vim: set noet : */

MEMORY {
	LMAROM (rx)  : ORIGIN = 0x00200000, LENGTH = 1024K
	VMAROM (rx)  : ORIGIN = 0x08000000, LENGTH = 1024K
	RAM    (rwx) : ORIGIN = 0x20000000, LENGTH = 320K
}

ENTRY(Reset_Handler)

SECTIONS {
	.text : AT(ORIGIN(VMAROM)) {
		. = ALIGN(4);
		__vector_top__ = .;
		KEEP(*(.vectors))
		. = ALIGN(4);
		__vector_end__ = .;

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
	} > LMAROM

	.ARM.extab ALIGN(4) : {
		*(.ARM.extab* .gnu.linkonce.armextab.*)
	} > LMAROM

	.ARM.exidx ALIGN(4) : {
		*(.ARM.exidx* .gnu.linkonce.armexidx.*)
	} > LMAROM

	. = ALIGN(4);
	__data_start__ = .;

	.data : AT(ORIGIN(VMAROM) + SIZEOF(.text) + SIZEOF(.ARM.extab) + SIZEOF(.ARM.exidx)) {
		. = ALIGN(4);
		__data_top__ = .;
		*(.data*)
		. = ALIGN(4);
		__data_end__ = .;
	} > RAM

	.bss (NOLOAD) :
	{
		. = ALIGN(4);
		__bss_top__ = .;
		*(.bss*)
		*(COMMON)
		. = ALIGN(4);
		__bss_end__ = .;
	} > RAM

	__stack_top__ = ORIGIN(RAM) + LENGTH(RAM);
}
