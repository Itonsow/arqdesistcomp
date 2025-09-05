# imprime_42.asm

.text
.globl main

main:
    li   $v0, 1      # código da syscall: print int
    li   $a0, 42     # valor que será impresso
    syscall

    li   $v0, 10     # código da syscall: exit
    syscall
