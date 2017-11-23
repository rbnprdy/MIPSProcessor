data
asize0:  .word    100, 200, 300, 400, 500, 600
asize1:  .word      700, 800, 900, 1000, 1100, 1200
.text

.globl main

main:
la $a1, asize0        #[s2] = 0x0

# BEGIN FORWARDING TESTS

# Forward from addi to mthi
addi $s1, $zero, 4    #[s1] = 4
mthi $s1
mfhi $s2              #[s2] = 4

# Forward from lw to mthi
lw $s3, 0($a1)        #[s3] = 100
# stall
mthi $s3
mfhi $s1              #[s1] = 100

# Forward from lw to addi
lw $s4, 0($a1)        #[s4] = 100
lw $s4, 4($a1)        #[s4] = 200
lw $s4, 8($a1)        #[s4] = 300
# stall
add $s4, $s4, $s1     #[s4] = 400
# stall
bgez $s4, branch1     # taken
blez $s4, error
j error

branch1:
# flush
bgez $s4, branch2     # taken
bgez $s4, error
j error

branch2:
# flush
bgez $s1, branch3     # taken
j error
j error

branch3:
j done

done:
j done

error:
addi $t1, $zero, 365
j error
