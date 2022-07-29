# $a1 : add of str, $a3 : add of pat.
# $a0 : len of str, $a2 : len of pat.
addi $t0, $zero, 0 
addi $t1, $zero, 0 
addi $t5, $zero, 0 
addi $t2, $zero, 0
add $t6, $a1, $zero
len_str:
lw $t4, 0($t6)
beqz $t4, EOlen_str
addi $t2, $t2, 1
addi $t6, $t6, 4
j len_str
EOlen_str:
add $a0, $t2, $zero
addi $t2, $zero, 0
add $t6, $a3, $zero
len_pat:
lw $t4, 0($t6)
beqz $t4, EOlen_pat
addi $t2, $t2, 1
addi $t6, $t6, 4
j len_pat
EOlen_pat:
add $a2, $t2, $zero
addi $s0, $s0, -36

move $s0, $t0
move $s1, $t1
move $s2, $t3
move $s3, $t5
move $s4, $a0
move $s5, $a1
move $s6, $a2
move $s7, $a3
move $t8, $ra
add $a0, $t3, $zero
add $a1, $a2, $zero
add $a2, $a3, $zero
jal generateNext
move $t0, $s0
move $t1, $s1
move $t3, $s2
move $t5, $s3
move $a0, $s4
move $a1, $s5
move $a2, $s6
move $a3, $s7
move $ra, $t8
# addi $s0, $s0, 36
kwhile:
bge $t0, $a0, free
sll $t2, $t1, 2
add $t2, $t2, $a3
lw $t2, 0($t2)
sll $t6, $t0, 2
add $t6, $t6, $a1
lw $t6, 0($t6)
sub $t2, $t2, $t6
bne $t2, $zero, kneq
sub $t2, $t1, $a2
addi $t2, $t2, 1
bne $t2, $zero, innerelse1
addi $t5, $t5, 1
addi $t6, $a2, -1
sll $t6, $t6, 2 
add $t6, $t6, $t3
lw $t1, 0($t6)
addi $t0, $t0, 1
j endinnerif1
innerelse1:
addi $t0, $t0, 1
addi $t1, $t1, 1
endinnerif1:
j endouterif
kneq:
ble $t1, $zero, innerelse2
addi $t6, $t1, -1
sll $t6, $t6, 2
add $t6, $t6, $t3
lw $t1, 0($t6)
j endouterif
innerelse2:
addi $t0, $t0, 1
endouterif:
j kwhile
free:
add $v0, $t5, $zero
j deadloop


generateNext:
addi $t0, $zero, 1
addi $t1, $zero, 0
beqz $a1, empty_pattern
addi $t5, $zero, 0
sw $t5, 0($a0)
gwhile:
slt $t5, $t0, $a1
beq $t5, $zero, endgwhile
sll $t3, $t0, 2
add $t3, $t3, $a2
lw $t3, 0($t3)
sll $t4, $t1, 2
add $t4, $t4, $a2
lw $t4, 0($t4)
sub $t3, $t3, $t4
bne $t3, $zero, neq
sll $t3, $t0, 2
add $t3, $t3, $a0
addi $t4, $t1, 1
sw $t4, 0($t3) 
addi $t0, $t0, 1
addi $t1, $t1, 1
j nxt
neq:
ble $t1, $zero, getz
addi $t4, $t1, -1
sll $t4, $t4, 2
add $t4, $t4, $a0
lw $t1, 0($t4)
j nxt
getz:
sll $t3, $t0, 2
add $t3, $t3, $a0
sw $zero, 0($t3)
addi $t0, $t0, 1
nxt:
j gwhile
endgwhile:
addi $v0, $zero, 0
jr $ra
empty_pattern:
addi $v0, $zero, 1
jr $ra
deadloop:
j deadloop