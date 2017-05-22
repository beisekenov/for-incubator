.data
string:.asciiz "Qqwerty1"
num: .word 8
.text
addi $t0, $t0, 58
addi $t1, $t1, 91
addi $t2, $t2, 123
addi $t5, $t5, 30

main:
la $t6, string
lw $s1, num
jal count

count:
lb $t3,0($t6)
addi $t6,$t6,1

addi $s1, $s1, -1

slt $t4,$t3,$t0
beq $t4, 1, decimal

slt $t4,$t3,$t1
beq $t4, 1, upper

slt $t4,$t3,$t2
beq $t4, 1, lower



decimal:
addi $a0,$a0,1
beqz $s1, exit
j count
lower:
addi $a1,$a1,1
beqz $s1, exit
j count

upper:
addi $a2,$a2,1
beqz $s1, exit
j count

exit:
   li $v0, 1
   add $a0, $zero, $a0
   syscall
   
   li $v0, 1
   add $a0, $zero, $a1
   syscall
   
      li $v0, 1
   add $a0, $zero, $a2
   syscall
