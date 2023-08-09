ENTRY(_start)

PHDRS {
    text PT_LOAD FLAGS((1 << 0) | (1 << 2)); /* r-x */
    rodata PT_LOAD FLAGS((1 << 2)); /* r-- */
    data PT_LOAD FLAGS((1 << 1) | (1 << 2)); /* rw- */
    dynamic PT_DYNAMIC FLAGS((1 << 1) | (1 << 2)); /* rw- */
}

SECTIONS {
    . = 0xffffffff80000000;

    .text : {
        *(.text .text.*)
    } :text

    . += CONSTANT(MAXPAGESIZE);

    .rodata : {
        *(.rodata .rodata.*)
    } :rodata

    .data : {
        *(.data .data.*)
    } :data

    .dynamic : {
        *(.dynamic .dynamic.*)
    } :dynamic

    .bss : {
        *(.bss .bss.*)
        *(COMMON)
    } :data

    /DISCARD/ : {
        *(.eh_frame)
        *(.note .note.*)
    }
}
