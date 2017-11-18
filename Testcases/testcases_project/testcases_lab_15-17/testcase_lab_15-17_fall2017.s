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
	la      $a0, DataMemory     # load the address of DataMemory and stores into register $t0

    # Instruction to Binary Translation begin

    j       start               # jump to jump1.
    addi    $a0, $zero, 10      # if $a0 == 10, jump failed.
    addi    $a0, $zero, 10      # if $a0 == 10, jump failed.
    start:
    lw      $s0, 4($a0)         # $s0 = 0x00000001
    lw      $s0, 8($a0)         # $s0 = 0x00000002
    sw      $s0, 0($a0)         # 
    sw      $s0, 12($a0)        # 
    lw      $s1, 0($a0)         # $s1 = 0x00000002
    lw      $s2, 12($a0)        # $s2 = 0x00000002
    beq     $s0, $zero, branch1 # don't branch
    add     $s1, $s0, $zero     # $s1 = 0x00000002
    beq     $s0, $s1, branch1   # taken
    # flush
    j       error               # jump to error if the branch not taken.

    branch1:
	addi    $s0, $zero, -1	# $s0 = -1
    bgez    $s0, start          # don't branch
    addi    $s0, $s0, 1         # $s0 = 0
    bgez    $s0, branch2        # taken
    j       error               # jump to error if the branch is not taken.

    branch2:
    addi    $s0, $zero, -1      # $s0 = -1
    bgtz    $s0, branch3        # don't branch
    addi    $s0, $zero, 1       # $s0 = 1
    bgtz    $s0, branch3        # taken
    j       error               # jump to error if the branch is not taken.

    branch3:
    bltz    $s0, branch4        # don't branch
    addi    $s0, $zero, -1      # $s0 = -1
    bltz    $s0, branch4        # taken
    j       error               # jump to error if the branch is not taken.

    branch4:
    addi    $s1, $zero, -1      # $s1 = -1
    bne     $s0, $s1, branch5   # don't branch
    bne     $s0, $zero, branch5 # taken
    j       error               # jump to error if the branch is not taken.

    branch5:
	addi $s0, $zero, 128        # $s0 = 0x80
	sb   $s0, 0($a0)		    # 
	lb   $s0, 0($a0)		    # $s0 = 0xffffff80
    blez $s0, branch6           # taken
	j       error               # jump to error if the branch is not taken.
	
	branch6:
	addi $s0, $zero, -1         # $s0 = -1
	sh   $s0, 0($a0)	        # 
	addi $s0, $zero, 0		    #$s0 = 0x0
	lh   $s0, 0($a0)	        # $s0 = 0xffffffff
    blez $s0, branch7           # taken
	j       error               # jump to error if the branch is not taken.
	
	branch7:
	addi $s0, $zero, -1         # $s0 = -1
	lui $s0, 1                  # $s0 = 0x10000
    bgez $s0, branch8           # taken
	j       error               # jump to error if the branch is not taken.
	
	
	
	branch8:
	j       jump1               # jump to jump1.
    addi    $s0, $s0, -2        # if $s0 == 2, jump failed.

    jump1:
    jal     jal1                # jump to jal1 and $ra should be set to current PC + 1.
    j       start               # jump back to start, program restarts when jal1 returns.

    jal1:
    jr      $ra                 # jump to return address.
    j       error               # jump to error if jr failed.

    error:
    jr      $zero
    # Instruction to Binary Translation end
    
    li      $v0, 10         # syscall to exit cleanly from main only
    syscall                 # this ends execution 
.end
