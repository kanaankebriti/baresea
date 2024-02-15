#!/bin/bash

as -o ./src/math/sqrt.o ./src/math/sqrt.s
as -o ./src/math/pow2.o ./src/math/pow2.s
as -o ./src/math/pow10i.o ./src/math/pow10i.s
as -o ./src/stdlib/abs.o ./src/stdlib/abs.s
as -o ./src/stdlib/itoa.o ./src/stdlib/itoa.s
gcc -c -m64 -o ./src/stdlib/ftoa.o ./src/stdlib/ftoa.c
as -o ./src/stdio/putchar.o ./src/stdio/putchar.s
as -o ./src/stdio/puts.o ./src/stdio/puts.s
as -o ./src/string/strlen.o ./src/string/strlen.s
ld -relocatable -o ./bin/baresea.o ./src/stdio/putchar.o ./src/stdlib/itoa.o ./src/stdlib/ftoa.o ./src/math/pow10i.o ./src/math/pow2.o ./src/math/sqrt.o ./src/stdlib/abs.o ./src/stdio/puts.o ./src/string/strlen.o
rm ./src/stdio/putchar.o ./src/stdlib/itoa.o ./src/stdlib/ftoa.o ./src/math/pow10i.o ./src/math/pow2.o ./src/math/sqrt.o ./src/stdlib/abs.o ./src/stdio/puts.o ./src/string/strlen.o
