#!/bin/bash

cp ./src/baresea.h ./include/baresea.h
gcc -c -m64 -o ./src/stdlib/itoa.o ./src/stdlib/itoa.c
gcc -c -m64 -o ./src/stdio/putchar.o ./src/stdio/putchar.c
ld -relocatable -o ./bin/baresea.o ./src/stdio/putchar.o ./src/stdlib/itoa.o

