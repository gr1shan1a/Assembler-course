.global _main
.align 2

.data
    A: .quad 0, 0, 2, -7, 4, -56, 6, -7, 8, 9
    B: .quad -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
    size: .quad 10

output_str:
    .asciz "Output value: %d\n"

.text
_main:
    // загружаем адрес массива A
    adrp X1, A@PAGE
    add X1, X1, A@PAGEOFF

    // загружаем адрес массива B
    adrp X2, B@PAGE
    add X2, X2, B@PAGEOFF

    // загружаем размер массива
    adrp X3, size@PAGE
    add X3, X3, size@PAGEOFF

    ldr x9, [x3]
    
    // цикл по элементам массива A
    mov x4, 0 // счетчик элементов

loop:
    cmp x4, x9 // сравниваем счетчик с размером массива
    b.ge end // выходим из цикла, если счетчик больше или равен размеру

    // загружаем текущий элемент массива A
    ldr x5, [x1], #8 // смещение X4 * 8 байт

    // проверяем, является ли индекс элемента его значением
    cmp x4, x5
    add x4, x4, 1
    b.ne loop // переходим к следующему элементу, если индекс не равен значению


    //str x5, [sp]
    
    //adr x0, output_str //загружаем адрес строки в x0
    //adrp X0, output_str@PAGE
    //add X0, X0, output_str@PAGEOFF

    //bl _printf //вызываем С-функцию вывода
    // mov x0, #32

    // копируем текущий элемент массива A в массив B
    str x5, [x2], #8 // смещение X4 * 8 байт
    bl loop

end:


mov x6, 0

loop_print:

adrp X5, B@PAGE
add X5, X5, B@PAGEOFF

str x6, [sp, #-16]!

ldr x3, [x5, x6, lsl 3]


//stp x5, x6, [sp, #-16]
//stp x29, x30, [sp, #-16]
//sub sp, sp, #16

str x3, [sp, #-16]!


adrp X0, output_str@PAGE
add X0, X0, output_str@PAGEOFF

bl _printf //вызываем С-функцию вывода

//add sp, sp, #16
//ldp x29, x30, [sp], #16

ldr x6, [sp, #16]

//stp x29, x30, [sp, #16]

adrp X3, size@PAGE
add X3, X3, size@PAGEOFF
ldr x9, [x3]



add x6, x6, #1
//add x5, x5, #8

cmp x9, x6
b.ne loop_print

end_print:
    // выводим перевод строки
    
    mov X16, #1
    svc #0x80

