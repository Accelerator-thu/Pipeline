#fopen
la $a0, filename #load filename
li $a1, 0 #flag
li $a2, 0 #mode
li $v0, 13 #open file syscall index
syscall

#read str
move $a0, $v0 #load file description to $a0
la $a1, str
li $a2, 1
li $s0, 0 #len_pattern = 0
read_str_entry:
slti $t0, $s0, 512
beqz $t0, read_str_exit
li $v0, 14 #read file syscall index
syscall
lb $t0, 0($a1)
addi $t1, $zero, '\n'
beq $t0, $t1, read_str_exit
addi $a1, $a1, 1
addi $s0, $s0, 1
j read_str_entry
read_str_exit:

#read pattern
la $a1, pattern
li $a2, 1
li $s1, 0 #len_pattern = 0
read_pattern_entry:
slti $t0, $s1, 512
beqz $t0, read_pattern_exit
li $v0, 14 #read file syscall index
syscall
lb $t0, 0($a1)
addi $t1, $zero, '\n'
beq $t0, $t1, read_pattern_exit
addi $a1, $a1, 1
addi $s1, $s1, 1
j read_pattern_entry
read_pattern_exit:

#close file
li $v0, 16 #close file syscall index
syscall

#call brute_force
move $a0, $s0
la $a1, str
move $a2, $s1
la $a3, pattern
jal kmp

#printf
move $a0, $v0
li $v0, 1
syscall
#return 0
li $a0, 0
li $v0, 17
syscall


kmp:
##### your code here #####
li $t5, 0
move $t0, $a0
sll $a0, $a2, 2
li $v0, 9
syscall
move $a0, $t0
move $s3, $v0 # $t2: int* next
move $s1, $ra
move $s2, $a1
move $a1, $v0
jal generateNext
move $a1, $s2
li $t0, 0
li $t1, 0
kwhile:
bge $t0, $a0, free
add $t2, $a3, $t1
add $t3, $a1, $t0
lb $t2, 0($t2)
lb $t3, 0($t3)
bne $t2, $t3, kneq
sub $t4, $a2, 1
bne $t1, $t4, innerelse1
addi $t5, $t5, 1
sll $t4, $t4, 2
add $t4, $s3, $t4
lw $t1, 0($t4)
addi $t0, $t0, 1
j endinnerif1
innerelse1:
addi $t0, $t0, 1
addi $t1, $t1, 1
endinnerif1:
j endouterif
kneq:
ble $t1, $zero, innerelse2
subi $t3, $t1, 1
sll $t3, $t3, 2
add $t3, $t3, $s3
lw $t1, 0($t3)
j endouterif
innerelse2:
addi $t0, $t0, 1
endouterif:
j kwhile
free:
move $v0, $t5
jr $s1


generateNext:
# $a1: *next, $a2: len_pattern, $a3: *pattern
li $t0, 1
li $t1, 0
beq $a2, 0, empty_pattern
sw $zero, 0($a1)
gwhile:
slt $t2, $t0, $a2
beq $t2, 0, endgwhile
add $t3, $t0, $a3
add $t4, $t1, $a3
lb $t3, 0($t3)
lb $t4, 0($t4)
bne $t3, $t4, neq
sll $t2, $t0, 2
add $t3, $a1, $t2
addi $t0, $t0, 1
addi $t1, $t1, 1
sw $t1, 0($t3)
j nxt
neq:
ble $t1, $zero, getz
subi $t1, $t1, 1
sll $t1, $t1, 2
add $t1, $a1, $t1
lw $t1, 0($t1)
j nxt
getz:
sll $t2, $t0, 2
add $t2, $a1, $t2
sw $zero, 0($t2)
addi $t0, $t0, 1
nxt:
j gwhile
endgwhile:
li $v0, 0
jr $ra
empty_pattern:
li $v0, 1
jr $ra
