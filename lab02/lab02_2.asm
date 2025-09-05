.data
spc:    .asciiz " "
nl:     .asciiz "\n"
ARR:    .space  5*4

.text
.globl main
.globl sort
.globl swap

main:
    #leitura 5 inteiros para ARR
    la   $t0, ARR
    li   $t1, 0
read_loop:
    li   $v0, 5
    syscall
    sw   $v0, 0($t0)
    addi $t0, $t0, 4
    addi $t1, $t1, 1
    slti $t2, $t1, 5
    bne  $t2, $zero, read_loop

    #sort(ARR, 5)
    la   $a0, ARR
    li   $a1, 5
    jal  sort

    #imprime vetor ordenado
    la   $t0, ARR
    li   $t1, 0
print_loop:
    lw   $a0, 0($t0)
    li   $v0, 1
    syscall

    # espaco entre num
    li   $v0, 4
    la   $a0, spc
    syscall

    addi $t0, $t0, 4
    addi $t1, $t1, 1
    slti $t2, $t1, 5
    bne  $t2, $zero, print_loop

    # newline sair
    li   $v0, 4
    la   $a0, nl
    syscall

    li   $v0, 10
    syscall

sort:
    #salvar(ra e s-registers)
    addi $sp, $sp, -20
    sw   $ra, 16($sp)
    sw   $s0, 12($sp)
    sw   $s1, 8($sp)
    sw   $s2, 4($sp)
    sw   $s3, 0($sp)

    move $s2, $a0
    move $s3, $a1
    li   $s0, 0

for1tst:
    addi $t5, $s3, -1
    slt  $t0, $s0, $t5
    beq  $t0, $zero, exit1

    addi $s1, $s3, -2

for2tst:
    slt  $t0, $s1, $s0         # se j < i sai
    bne  $t0, $zero, exit2

    sll  $t1, $s1, 2
    add  $t2, $s2, $t1
    lw   $t3, 0($t2)
    lw   $t4, 4($t2)
    slt  $t0, $t4, $t3
    beq  $t0, $zero, noswap
    move $a0, $s2
    move $a1, $s1
    jal  swap
noswap:
    addi $s1, $s1, -1
    j    for2tst

exit2:
    addi $s0, $s0, 1
    j    for1tst

exit1:
    # restaura retorna
    lw   $s3, 0($sp)
    lw   $s2, 4($sp)
    lw   $s1, 8($sp)
    lw   $s0, 12($sp)
    lw   $ra, 16($sp)
    addi $sp, $sp, 20
    jr   $ra

swap:
    sll  $t1, $a1, 2           # offset = idx*4
    add  $t2, $a0, $t1         # &ARR[idx]
    lw   $t3, 0($t2)           # a = ARR[idx]
    lw   $t4, 4($t2)           # b = ARR[idx+1]
    sw   $t4, 0($t2)           # ARR[idx]   = b
    sw   $t3, 4($t2)           # ARR[idx+1] = a
    jr   $ra
