.text
.globl main
main:
move $s0,$gp
addi $s0,$s0,5000
move $s2,$s0
addi $s2,$s2,400
li $t0,9
dados:
sw $t0,0($s0)
addi $s0,$s0,4
addi $t0,$t0,9
bne $s0,$s2,dados