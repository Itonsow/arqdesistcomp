.data
nl: .asciiz "\n"

.text
.globl main
.globl fact

main:
    # lê inteiro
    li   $v0, 5
    syscall
    move $a0, $v0

    # chama fact(n)
    jal  fact

    # imprime resultado ($v0)
    move $a0, $v0
    li   $v0, 1
    syscall

    li   $v0, 4
    la   $a0, nl
    syscall

    li   $v0, 10
    syscall
fact:
    addi $sp, $sp, -8
    sw   $ra, 4($sp)
    sw   $a0, 0($sp)

    slti $t0, $a0, 1
    beq  $t0, $zero, L1
    addi $v0, $zero, 1
    addi $sp, $sp, 8
    jr   $ra

L1:
    addi $a0, $a0, -1
    jal  fact
    lw   $a0, 0($sp)
    lw   $ra, 4($sp)
    addi $sp, $sp, 8
    mul  $v0, $a0, $v0
    jr   $ra
