.global _main
.align 2
_main:

    //Если сумма целых чисел А, В и С меньше единицы, то наименьшее из этих трех чисел заменить суммой двух других.
    mov x0, #-298 //ввод A
    mov x1, #400 //ввод B
    mov x2, #-100 //ввод C

    mov x3, #0

    add x3, x0, x1 // A + B
    add x3, x3, x2 // A + B + C

    cmp x3, #1
    blt delta
    b skip

delta:
    cmp x0, x1
    b.le to_x0_x2
    b to_x1_x2

to_x0_x2:
    cmp x0, x2
    b.le _x0
    b _x2

to_x1_x2:
    cmp x1, x2
    b.lt _x1
    b _x2

_x0:
    add x0, x1, x2
    b skip

_x1:
    add x1, x0, x2
    b skip

_x2:
    add x2, x0, x1
    b skip

skip:
    mov x3, x0
    mov x4, x1
    mov x5, x2

    str x3, [sp] //сохраняем (store) число в стековый регистр
    str x4, [sp, #8] //сохраняем (store) число в стековый регистр + 8 байт смещение
    str x5, [sp, #16] //сохраняем (store) число в стековый регистр + 16 байт смещение
    adr x0, output_str //загружаем адрес строки в x0
    bl _printf //вызываем С-функцию вывода

    mov x0, #0
    mov X16, #1 //системный вызов 1 завершает программу
    svc #0x80 //вызываем системную функцию с номером 1

output_str:
    .asciz "Output value: %d, %d, %d\n"
