.data
    .align 2
ARR: .space 12*4
msg: .asciiz "Fibonacci (12): "
spc: .asciiz " "
nl:  .asciiz "\n"

.text
.globl main
.globl fib

main:
    li   $v0, 4
    la   $a0, msg
    syscall

    la   $s0, ARR
    li   $s1, 0
fill_loop:
    move $a0, $s1
    jal  fib
    sw   $v0, 0($s0)

    addi $s0, $s0, 4
    addi $s1, $s1, 1
    slti $t0, $s1, 12
    bne  $t0, $zero, fill_loop

    #Imprime ARR
    la   $t0, ARR
    li   $t1, 0
print_loop:
    lw   $a0, 0($t0)
    li   $v0, 1
    syscall

    li   $v0, 4
    la   $a0, spc
    syscall

    addi $t0, $t0, 4
    addi $t1, $t1, 1
    slti $t2, $t1, 12
    bne  $t2, $zero, print_loop

    # newline e sair
    li   $v0, 4
    la   $a0, nl
    syscall

    li   $v0, 10
    syscall

#fib(n) recursivo:
#  if n < 2 -> n
#  else     -> fib(n-1) + fib(n-2)
#usa pilha p/ salvar $ra, n e fib(n-1)

fib:
    addi $sp, $sp, -12
    sw   $ra, 8($sp)
    sw   $a0, 4($sp)        # salva n

    slti $t0, $a0, 2
    beq  $t0, $zero, fib_rec
    move $v0, $a0
    addi $sp, $sp, 12
    jr   $ra

fib_rec:
    addi $a0, $a0, -1
    jal  fib
    sw   $v0, 0($sp)

    lw   $a0, 4($sp)
    addi $a0, $a0, -2
    jal  fib

    lw   $t1, 0($sp)
    add  $v0, $v0, $t1

    lw   $a0, 4($sp)
    lw   $ra, 8($sp)
    addi $sp, $sp, 12
    jr   $ra
