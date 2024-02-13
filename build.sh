#!/bin/bash

gcc -c -m64 -o ./src/math/pow2.o ./src/math/pow2.s
gcc -c -m64 -o ./src/math/pow10i.o ./src/math/pow10i.s
gcc -c -m64 -o ./src/stdlib/itoa.o ./src/stdlib/itoa.s
gcc -c -m64 -o ./src/stdlib/ftoa.o ./src/stdlib/ftoa.c
gcc -c -m64 -o ./src/stdio/putchar.o ./src/stdio/putchar.s
ld -relocatable -o ./bin/baresea.o ./src/stdio/putchar.o ./src/stdlib/itoa.o ./src/stdlib/ftoa.o ./src/math/pow10i.o ./src/math/pow2.o
