
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

# stall then forward r-type from mem to jr
la $t1, asize0          #[t1] = 0x0
addi $t2, $zero, 20      #[t2] = 20
# stall
jr  $t2                 # should jump to addi $s3, $zero, 1
addi $s3, $zero, 1234
addi $s3, $zero, 5678
# flush
addi $s3, $zero, 1

# forward r-type from wb to jr
addi $t2, $zero, 48
addi $s3, $zero, 5
addi $s2, $zero, 6
jr $t2              # should jump to addi $s3, $zero, 2


addi $s3, $zero, 9123
addi $s3, $zero, 4567
# flush
addi $s3, $zero, 2
addi $t1, $zero, 76
sw $t1, 0($s1)

# stall twice then forward lw from wb to jr
lw $t2, 0($s1)
# stall
# stall
jr $t2          # should jump to addi $s3, $zero, 3
addi $s3, $zero, 8912
addi $s3, $zero, 3456
# flush
addi $s3, $zero, 3

# forward jal in mem to jr
jal jump1
# flush
addi $s3, $s3, 2     # [s3] = 5

# forward jal in wb to jr
jal jump2
# flush
addi $s3, $s3, 4    # [s3] = 12
j done

jump1:
# flush
jr $ra

jump2:
# flush
addi $s3, $s3, 3    # [s3] = 8
jr $ra

done:
j done
