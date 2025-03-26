#!/bin/bash
nasm -f elf64 readfile.asm
ld readfile.o -o readfile
./readfile
rm readfile.o readfile

# not helpful chatgpt, claude haiku worked
