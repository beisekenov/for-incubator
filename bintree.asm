.data


.text
j main

make_node_bst:
	addi $v0, $0, 9
	syscall
	sw $0, 0($v0)
	sw $0, 4($v0)
	#
	jr $ra
insert_node_bst:
	beq $a2, 0, left
	addi $a1, $a1, 4
	left:
	
	sw $a0, 0($a1)
	jr $ra
	
search_bst:
	loop:
	addi $s2, $s2, 1
	lwc1 $f4, 8($a0)
	c.eq.s $f4, $f12
	bc1t equal
	c.lt.s $f12, $f4
	bc1t left_son
	c.lt.s $f4, $f12
	bc1t right_son
	equal:
	addi $v0, $0, -1
	addi $v1, $a0, 0
	jr $ra	
	left_son:
	lw $t0, 0($a0)
	beq $t0, 0, nolson
	addi $a0, $t0, 0
	j loop
	nolson:
	addi $v1, $a0, 0
	addi $v0, $0, 0
	jr $ra
	right_son:
	lw $t0, 4($a0)
	beq $t0, 0, norson
	addi $a0, $t0, 0
	j loop
	norson:
	addi $v1, $a0, 0
	addi $v0, $0, 1
	jr $ra

output:
	bne $a1, 0, nodie
	jr $ra
	nodie:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	addi $sp, $sp, -4
	sw $a1, 0($sp)
	lw $a1, 0($a1)
	jal output
	lw $a1, 0($sp)
	
	lwc1 $f12, 8($a1)
	addi $v0, $0, 2
	syscall
	
	addi $v0, $0, 11
	addi $a0, $0, 12
	syscall

	
	lw $a1, 0($sp)
	lw $a1, 4($a1)
	jal output
	addi $sp, $sp, 4
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4	
	jr $ra

main:
	addi $s0, $0, 0
	woop:
	addi $v0, $0, 6
	syscall
	c.eq.s $f0, $f1
	bc1t dead
	
	beq $s0, 0, empty
	addi $a0, $s0, 0
	mov.s $f12, $f0
	jal search_bst
	
	beq $v0, -1, woop
	addi $a2, $v0, 0
	addi $a1, $v1, 0
	addi $s1, $v1, 0
	
	addi $a0, $0, 12
	jal make_node_bst
	swc1 $f0, 8($v0)
	addi $a0, $v0, 0
	
	jal insert_node_bst
	
	j woop
	
	empty:
	addi $a0, $0, 12
	jal make_node_bst
	swc1 $f0, 8($v0)
	addi $s0, $v0, 0
	j woop
	
	dead:
	
	addi $a1, $s0, 0
	jal output
	