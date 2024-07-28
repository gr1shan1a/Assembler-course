.global _main
.align 2
_main:
    mov x0, #-6 //ввод A

    mov x1, #2
    mul x2, x1, x0 // 2*A
    mul x2, x2, x0 // 2*A*A

    mul x0, x2, x0 // 2*Aˆ3
    mul x1, x1, x2 // 4Aˆ2

    sub x0, x0, x1 // 2*Aˆ3 - 4Aˆ2
    

    mov x1, #-3    // ввод B
    mul x1, x1, x1 // B^2

    udiv x2, x0, x1 //y = (A + B)/C^2

    mul x3, x1, x2 //C^2 * X2
    sub x3, x0, x3 //A+B - X3

    str x2, [sp] //сохраняем (store) число в стековый регистр
    str x3, [sp, #8] //сохраняем (store) число в стековый регистр + 8 байт смещение
    adr x0, output_str //загружаем адрес строки в x0
    bl _printf //вызываем С-функцию вывода

    mov x0, #0
    mov X16, #1 //системный вызов 1 завершает программу
    svc #0x80 //вызываем системную функцию с номером 1

output_str:
    .asciz "Output value: %d, %d\n"
