.global _main
.align 2

_main:
    mov x0, #0xFF        // 11110000

    mov x1, #0xAA         // 10101010
    and x2, x0, x1        // x2 = 11110000 AND 10101010 = 10100000
    lsr x2, x2, #1        // x2 = 01000001

    mov x3, #0x55         // 01010101
    and x4, x0, x3        // x4 = 11110000 AND 01010101 = 01010000
    lsl x4, x4, #1        // x4 = 10100000

    orr x0, x2, x4        // x0 = 10100000 OR 01010000 = 11110000 = 240

    mov X16, #1
    svc #0x80

.end
