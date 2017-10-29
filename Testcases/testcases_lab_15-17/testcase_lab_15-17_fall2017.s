# 
# Author: Shuai Chang, Nirmal Kumbhare
# Description:
#   * you are supporting memory operations, branches and jumps.
#   * You need to prepare both your InstructionMemory and DataMemory.
#   * Instructions tested: beq, bgez, bgtz, bltz, bne, j, jal, jr, lw, sw
#   * Your can run this program in QtSpim if you are not clear what this program does.
#   * Note: This program is an infinite loop.

# Initialize your DataMemory first as the following:
# Memory[1] <= 32'h00000001;
# Memory[2] <= 32'hffffffff;
# Memory[*] <= 0, where * represents all the other indexes other than 1 and 2

# Initialize your InstructionMemory with the instructions in the program.
# Translation process is similar to that of Lab10-11


# An example instruction translation for a jump instruction is as follow:
# j start (Where "start" is a label that your target to jump to)
# OpCode [31 : 26]      Instruction_Index [25 : 0]
# 000010                0 0000 0000 0000 0000 0000 1100
# The next instruction will be executed is InstructionMemory[12].

# Your target is an index/address to your instruction memory.
# In other word, jump target will update the program counter to a "target" value, and the 
# next instruction executed will be the "target" instead of the default "previous + 4"

# For branch:
# beq       $s0, $zero, branch1 (Where branch1 is a label represents the offset value from current PC)
# OpCode [31 : 26]    rs [25 : 21]     rt[20 : 16]      offset[15 : 0]
# 000100              10000            00000            0000 0000 0000 1000
# if ($s0 == $zero) -> branch to (current_PC + offset)
# The value of offset is determined by how you initialize your InstructionMemory.


.data                       # Put Global Data here
DataMemory:      .word 0, 1, 2, 3, 4 , -1   # 'X' is the address of the 1st element in the array to be added

.text               # Put program here 
.globl main         # globally define 'main' 

main: 
    #lui      $a0, DataMemory     # load the address of DataMemory and stores into register $t0
	la      $a0, DataMemory     # load the address of DataMemory and stores into register $t0
    nop
    nop
    nop
    nop
    nop
    #lui      $a0, 0     # load the address of DataMemory and stores into register $t0
    
    # Instruction to Binary Translation begin
    
    # Test your JUMP (j) instruction first, make sure j works, it will be used for the future debug purpose.
    j       start               # jump to jump1.
    nop
    nop
    nop
    nop
    nop
    addi    $a0, $zero, 10      # if $a0 == 10, jump failed.
    nop
    nop
    nop
    nop
    nop
    addi    $a0, $zero, 10      # if $a0 == 10, jump failed.
    nop
    nop
    nop
    nop
    nop
    start:
    lw      $s0, 4($a0)         # $s0 = Memory[1] = 32'h00000001.
    nop
    nop
    nop
    nop
    nop
    lw      $s0, 8($a0)         # $s0 = Memory[2] = 32'h00000002.
    nop
    nop
    nop
    nop
    nop
    sw      $s0, 0($a0)         # Memory[0] = 32'h00000002.
    nop
    nop
    nop
    nop
    nop
    sw      $s0, 12($a0)        # Memory[2] = 32'h00000002.
    nop
    nop
    nop
    nop
    nop
    lw      $s1, 0($a0)         # $s1 = Memory[0] = 32'h00000002.
    nop
    nop
    nop
    nop
    nop
    lw      $s2, 12($a0)        # $s2 = Memory[1] = 32'h00000002.
    nop
    nop
    nop
    nop
    nop
    beq     $s0, $zero, branch1 # $s0 != 0, the branch1 not taken.
    nop
    nop
    nop
    nop
    nop
    add     $s1, $s0, $zero     # $s1 = 32'h00000002.
    nop
    nop
    nop
    nop
    nop
    beq     $s0, $s1, branch1   # $s0 == $s1, branch1 taken.
    nop
    nop
    nop
    nop
    nop
    j       error               # jump to error if the branch not taken.
    nop
    nop
    nop
    nop
    nop

    branch1:
	addi    $s0, $zero, -1		# $s0 = -1
    
    nop
    nop
    nop
    nop
    nop
    bgez    $s0, start          # $s0 = 32'ffffffff < 0, branch not taken.
    nop
    nop
    nop
    nop
    nop
    addi    $s0, $s0, 1         # $s0 = 0.
    nop
    nop
    nop
    nop
    nop
    bgez    $s0, branch2        # $s0 = 1 >= 0, branch2 taken.
    nop
    nop
    nop
    nop
    nop
    j       error               # jump to error if the branch is not taken.
    nop
    nop
    nop
    nop
    nop

    branch2:
    addi    $s0, $zero, -1      # $s0 = -1.
    nop
    nop
    nop
    nop
    nop
    bgtz    $s0, branch3        # $s0 = -1 < 0, branch3 not taken.
    nop
    nop
    nop
    nop
    nop
    addi    $s0, $zero, 1       # $s0 = 1.
    nop
    nop
    nop
    nop
    nop
    bgtz    $s0, branch3        # $s0 = 1 > 0, branch3 taken.
    nop
    nop
    nop
    nop
    nop
    j       error               # jump to error if the branch is not taken.
    nop
    nop
    nop
    nop
    nop

    branch3:
    bltz    $s0, branch4        # $s0 = 1 >= 0, branch4 not taken.
    nop
    nop
    nop
    nop
    nop
    addi    $s0, $zero, -1      # $s0 = -1.
    nop
    nop
    nop
    nop
    nop
    bltz    $s0, branch4        # $s0 = -1 < 0, branch4 taken.
    nop
    nop
    nop
    nop
    nop
    j       error               # jump to error if the branch is not taken.
    nop
    nop
    nop
    nop
    nop

    branch4:
    addi    $s1, $zero, -1      # $s1 = -1.
    nop
    nop
    nop
    nop
    nop
    bne     $s0, $s1, branch5   # $s0 = - 1 == $s1, branch5 not taken.
    nop
    nop
    nop
    nop
    nop
    bne     $s0, $zero, branch5 # $s0 = -1 != 0, branch5 taken.
    nop
    nop
    nop
    nop
    nop
    j       error               # jump to error if the branch is not taken.
    nop
    nop
    nop
    nop
    nop

    branch5:
	addi $s0, $zero, 128    # $s0 = 0x80
    nop
    nop
    nop
    nop
    nop
	sb   $s0, 0($a0)		 # Memory[0][7:0] = 0x80
    nop
    nop
    nop
    nop
    nop
	lb   $s0, 0($a0)		 # $s0 = 0xffffff80 
    nop
    nop
    nop
    nop
    nop
	blez $s0, branch6	
    nop
    nop
    nop
    nop
    nop
	j       error               # jump to error if the branch is not taken.
    nop
    nop
    nop
    nop
    nop
	
	branch6:
	addi $s0, $zero, -1    # $s0 = -1
    nop
    nop
    nop
    nop
    nop
	sh   $s0, 0($a0)	   # Memory[0][15:0] = -1
    nop
    nop
    nop
    nop
    nop
	addi $s0, $zero, 0		#$s0 = 0x0
    nop
    nop
    nop
    nop
    nop
	lh   $s0, 0($a0)	   # $s0 = 0xffffffff
    nop
    nop
    nop
    nop
    nop
	blez $s0, branch7
    nop
    nop
    nop
    nop
    nop
	j       error               # jump to error if the branch is not taken.
    nop
    nop
    nop
    nop
    nop
	
	branch7:
	addi $s0, $zero, -1    # $s0 = -1
    nop
    nop
    nop
    nop
    nop
	lui $s0, 1             # $s0 = 0x10000 
    nop
    nop
    nop
    nop
    nop
	bgez $s0, branch8
    nop
    nop
    nop
    nop
    nop
	j       error               # jump to error if the branch is not taken.
    nop
    nop
    nop
    nop
    nop
	
	
	
	branch8:
	j       jump1               # jump to jump1.
    nop
    nop
    nop
    nop
    nop
    addi    $s0, $s0, -2        # if $s0 == 2, jump failed.
    nop
    nop
    nop
    nop
    nop

    jump1:
    jal     jal1                # jump to jal1 and $ra should be set to current PC + 1.
    nop
    nop
    nop
    nop
    nop
    j       start               # jump back to start, program restarts when jal1 returns.
    nop
    nop
    nop
    nop
    nop

    jal1:
    jr      $ra                 # jump to return address.
    nop
    nop
    nop
    nop
    nop
    j       error               # jump to error if jr failed.
    nop
    nop
    nop
    nop
    nop

    error:
    jr      $zero    
    nop
    nop
    nop
    nop
    nop
    # Instruction to Binary Translation end
    
    li      $v0, 10         # syscall to exit cleanly from main only 
    nop
    nop
    nop
    nop
    nop
    syscall                 # this ends execution 
    nop
    nop
    nop
    nop
    nop
.end
