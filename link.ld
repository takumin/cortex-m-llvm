/* vim: set noet : */

MEMORY {
	ITCM   (rwx) : ORIGIN = 0x00000000, LENGTH = 16K
	LMAROM (rx)  : ORIGIN = 0x00200000, LENGTH = 1024K
	VMAROM (rx)  : ORIGIN = 0x08000000, LENGTH = 1024K
	DTCM   (rwx) : ORIGIN = 0x20000000, LENGTH = 64K
	SRAM1  (rwx) : ORIGIN = 0x20010000, LENGTH = 240K
	SRAM2  (rwx) : ORIGIN = 0x2004C000, LENGTH = 16K
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

	.ARM.extab : {
		*(.ARM.extab* .gnu.linkonce.armextab.*)
	} > LMAROM

	.ARM.exidx : {
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
	} > SRAM1

	. = ALIGN(4);
	__itcm_start__ = .;

	.itcm : AT(ORIGIN(VMAROM) + SIZEOF(.text) + SIZEOF(.ARM.extab) + SIZEOF(.ARM.exidx) + SIZEOF(.data)) {
		. = ALIGN(4);
		__itcm_top__ = .;
		*(.itcm*)
		. = ALIGN(4);
		__itcm_end__ = .;
	} > ITCM

	.bss (NOLOAD) : {
		. = ALIGN(4);
		__bss_top__ = .;
		*(.bss*)
		*(COMMON)
		. = ALIGN(4);
		__bss_end__ = .;
	} > SRAM1

	.dtcm (NOLOAD) : {
		. = ALIGN(4);
		__dtcm_top__ = .;
		*(.dtcm*)
		. = ALIGN(4);
		__dtcm_end__ = .;
	} > DTCM

	__stack_top__ = ORIGIN(SRAM1) + LENGTH(SRAM1);
	__stack_limit__ = __stack_top__ - 0x2000;
	ASSERT(__stack_limit__ >= __bss_end__, "Region SRAM Overflowed with Stack")

	/* Stabs debugging sections. */
	.stab          0 : { *(.stab) }
	.stabstr       0 : { *(.stabstr) }
	.stab.excl     0 : { *(.stab.excl) }
	.stab.exclstr  0 : { *(.stab.exclstr) }
	.stab.index    0 : { *(.stab.index) }
	.stab.indexstr 0 : { *(.stab.indexstr) }
	.comment       0 : { *(.comment) }
	/* DWARF debug sections. */
	/* DWARF 1 */
	.debug          0 : { *(.debug) }
	.line           0 : { *(.line) }
	/* GNU DWARF 1 extensions */
	.debug_srcinfo  0 : { *(.debug_srcinfo) }
	.debug_sfnames  0 : { *(.debug_sfnames) }
	/* DWARF 1.1 and DWARF 2 */
	.debug_aranges  0 : { *(.debug_aranges) }
	.debug_pubnames 0 : { *(.debug_pubnames) }
	/* DWARF 2 */
	.debug_info     0 : { *(.debug_info .gnu.linkonce.wi.*) }
	.debug_abbrev   0 : { *(.debug_abbrev) }
	.debug_line     0 : { *(.debug_line .debug_line.* .debug_line_end ) }
	.debug_frame    0 : { *(.debug_frame) }
	.debug_str      0 : { *(.debug_str) }
	.debug_loc      0 : { *(.debug_loc) }
	.debug_macinfo  0 : { *(.debug_macinfo) }
	/* SGI/MIPS DWARF 2 extensions */
	.debug_weaknames 0 : { *(.debug_weaknames) }
	.debug_funcnames 0 : { *(.debug_funcnames) }
	.debug_typenames 0 : { *(.debug_typenames) }
	.debug_varnames  0 : { *(.debug_varnames) }
	/* DWARF 3 */
	.debug_pubtypes 0 : { *(.debug_pubtypes) }
	.debug_ranges   0 : { *(.debug_ranges) }
	/* DWARF Extension. */
	.debug_macro    0 : { *(.debug_macro) }
	.debug_addr     0 : { *(.debug_addr) }

	.ARM.attributes 0 : { KEEP (*(.ARM.attributes)) KEEP (*(.gnu.attributes)) }
	.note.gnu.arm.ident 0 : { KEEP (*(.note.gnu.arm.ident)) }

	/DISCARD/ : { *(.note.GNU-stack) *(.gnu_debuglink) *(.gnu.lto_*) }
}
