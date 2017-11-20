
######################################################################################################################
### main
########################################################################################################################
.data
asize0:  .word    100, 200, 300, 400, 500, 600
asize1:  .word      700, 800, 900, 1000, 1100, 1200
.text

.globl main

main:
la $s1, asize0        #[s2] = 0x0

# BEGIN FORWARDING TESTS

# forward to lw address
la $t1, asize0          #[t1] = 0x0
addi $t2, $t1, 0        #[t2] = 0x0
lw $t3, 4($t2)          #[t3] = 200

# forward to sw address
addi $t4, $zero, 5      #[t4] = 5
add $t3, $zero, $t1     #[t3] = 0x0
sw $t4, 4($t3)
lw $t2, 4($t3)          #[t2] = 5

# sw after lw rt dependency
lw $t1, 0($s1)          #[t1] = 100
sw $t1, 4($s1)
lw $t2, 4($s1)          #[t2] = 100

# sw after add rt dependency
add $t1, $t1, $t1       #[t1] = 200
sw $t1, 8($s1)
lw $t3, 8($s1)          #[t3] = 200

# sw after unrelated after lw dependency
lw $t3, 12($s1)         #[t3] = 400
addi $s2, $zero, 15     #[s2] = 15
sw $t3, 16($s1)
lw $t4, 16($s1)         #[t4] = 400

# sw after unrelated after add dependency
addi $t5, $zero, 7      #[t5] = 7
add $t6, $t5, $t5       #[t6] = 14
sw $t5, 0($s1)
lw $t6, 0($s1)          #[t6] = 7

# r-type after mfhi
mthi $t5
mfhi $t7                #[t7] = 7
ori $s2, $t7, 8         #[s2] = 15

# r-type after mflo
mtlo $t3
mflo $s2                #[s2] = 400
slt $s3, $t6, $s2       #[s3] = 1

# sw after unrelated after mflo
mflo $s3                #[s3] = 400
addi $s4, $zero, 4      #[s4] = 4
sw $s3, 0($s1)
lw $s4, 0($s1)          #[s4] = 400

# branch after unrelated after r-type
addi $s2, $zero, -1     #[s2] = -1
addi $s4, $zero, 4      #[s4] = 4
bgez $s2, error         # Don't Branch
addi $s5, $zero, 5      #[s5] = 5

# branch after unrelated after r-type 2
add $s6, $zero, $s5    #[s6] = 5
addi $s4, $zero, 3      #[s4] = 3
beq $s5, $s6, branch1   # taken
addi $s5, $zero, -1234

branch1:
addi $s5, $zero, 1      #[s5] = 1
# branch after unrelated after mfhi
mfhi $s4                #[s4] = 7
addi $s5, $zero, 2      #[s5] = 2
bgtz $s4, branch2       # taken
j error

branch2:
addi $s5, $zero, 1      #[s5] = 1

# BEGIN STALLING TESTS
la $s1, asize1
sw $s1, 0($s1)

# sw after lw
lw $s2, 0($s1)
# stall
sw $s5, 4($s2)
lw $s6, 4($s1)          #[s6] = 1

# r-type after lw
# stall
add $s5, $s6, $s6       #[s5] = 2

# branch after r-type
addi $s5, $zero, -3     #[s5] = -3
# stall
bgez $s5, error         # Don't Branch
addi $s2, $zero, -1      #[s2] = -1

# branch after lw
lw $s2, 8($s1)          #[s2] = 900
# stall
# stall
bgez $s2, branch3       # taken
addi $s2, $zero, -1234
addi $s2, $zero, -5678
j error

branch3:
# flush
addi $s2, $zero, 1      #[s2] = 1

done:
j done
error:
j error


