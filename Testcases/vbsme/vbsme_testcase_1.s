#  Team Members:   Ruben Purdy, Kray Althaus
#  % Effort    :   50/50
#
# ECE369A,  
# 

########################################################################################################################
### data
########################################################################################################################
.data
# test input
# asize : dimensions of the frame [i, j] and window [k, l]
#         i: number of rows,  j: number of cols
#         k: number of rows,  l: number of cols  
# frame : frame data with i*j number of pixel values
# window: search window with k*l number of pixel values
#
# $v0 is for row / $v1 is for column

# test 1 For the 16X16 frame size and 4X4 window size
# The result should be 12, 12 instead of 1, 0 because of the spiral search pattern.
asize1: .word    16, 16, 4, 4    #i, j, k, l
frame1: .word    0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
         .word    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 
         .word    1, 2, 3, 4, 2, 3, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 
         .word    2, 3, 4, 5, 3, 4, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 
         .word    3, 4, 5, 6, 4, 5, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 
         .word    0, 5, 3, 4, 5, 6, 30, 35, 40, 45, 50, 55, 60, 65, 70,  75, 
         .word    0, 6, 12, 18, 24, 30, 36, 42, 48, 54, 60, 66, 72, 78, 84, 90, 
         .word    0, 4, 14, 21, 28, 35, 42, 49, 56, 63, 70, 77, 84, 91, 98, 105, 
         .word    0, 8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 88, 96, 104, 112, 120, 
         .word    0, 9, 18, 27, 36, 45, 54, 63, 72, 81, 90, 99, 108, 117, 126, 135, 
         .word    0, 1, 2, 3, 4, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 
         .word    1, 2, 3, 4, 44, 55, 66, 77, 88, 99, 110, 121, 132, 143, 154, 165, 
         .word    2, 3, 4, 5, 48, 60, 72, 84, 96, 108, 120, 132, 0, 1, 2, 3, 
         .word    3, 4, 5, 6, 52, 65, 78, 91, 104, 114, 130, 143, 1, 2, 3, 4, 
         .word    0, 14, 28, 42, 56, 70, 84, 98, 112, 126, 140, 154, 2, 3, 4, 5, 
         .word    0, 15, 30, 45, 60, 75, 90, 105, 120, 135, 150, 165, 3, 4, 5, 6 
window1:   .word    0, 1, 2, 3,
            .word    1, 2, 3, 4, 
            .word    2, 3, 4, 5, 
            .word    3, 4, 5, 6
         
newline: .asciiz     "\n" 


########################################################################################################################
### main
########################################################################################################################

.text

.globl main

main:
         
    # Start test 1 
    ############################################################
    la      $a0, asize1     # 1st parameter: address of asize1[0]
    la      $a1, frame1     # 2nd parameter: address of frame1[0]
    la      $a2, window1    # 3rd parameter: address of window1[0] 
   
    jal     vbsme           # call function
    nop
    j       end
    
    ############################################################
    # End of test 1

end:
    j       end

#####################################################################
### vbsme
#####################################################################


# vbsme.s 
# motion estimation is a routine in h.264 video codec that 
# takes about 80% of the execution time of the whole code
# given a frame(2d array, x and y dimensions can be any integer 
# between 16 and 64) where "frame data" is stored under "frame"  
# and a window (2d array of size 4x4, 4x8, 8x4, 8x8, 8x16, 16x8 or 16x16) 
# where "window data" is stored under "window" 
# and size of "window" and "frame" arrays are stored under "asize"

# - initially current sum of difference is set to a very large value
# - move "window" over the "frame" one cell at a time starting with location (0,0)
# - moves are based spiral pattern 
# - for each move, function calculates  the sum of absolute difference (SAD) 
#   between the window and the overlapping block on the frame.
# - if the calculated sum of difference is less than the current sum of difference
#   then the current sum of difference is updated and the coordinate of the top left corner 
#   for that matching block in the frame is recorded. 

# for example SAD of two 4x4 arrays "window" and "block" shown below is 3  
# window         block
# -------       --------
# 1 2 2 3       1 4 2 3  
# 0 0 3 2       0 0 3 2
# 0 0 0 0       0 0 0 0 
# 1 0 0 5       1 0 0 4

# program keeps track of the window position that results 
# with the minimum sum of absolute difference. 
# after scannig the whole frame
# program returns the coordinates of the block with the minimum SAD
# in $v0 (row) and $v1 (col) 


# Sample Inputs and Output shown below:
# Frame:
#
#  0   1   2   3   0   0   0   0   0   0   0   0   0   0   0   0 
#  1   2   3   4   4   5   6   7   8   9  10  11  12  13  14  15 
#  2   3  32   1   2   3  12  14  16  18  20  22  24  26  28  30 
#  3   4   1   2   3   4  18  21  24  27  30  33  36  39  42  45 
#  0   4   2   3   4   5  24  28  32  36  40  44  48  52  56  60 
#  0   5   3   4   5   6  30  35  40  45  50  55  60  65  70  75 
#  0   6  12  18  24  30  36  42  48  54  60  66  72  78  84  90 
#  0   7  14  21  28  35  42  49  56  63  70  77  84  91  98 105 
#  0   8  16  24  32  40  48  56  64  72  80  88  96 104 112 120 
#  0   9  18  27  36  45  54  63  72  81  90  99 108 117 126 135 
#  0  10  20  30  40  50  60  70  80  90 100 110 120 130 140 150 
#  0  11  22  33  44  55  66  77  88  99 110 121 132 143 154 165 
#  0  12  24  36  48  60  72  84  96 108 120 132   0   1   2   3 
#  0  13  26  39  52  65  78  91 104 117 130 143   1   2   3   4 
#  0  14  28  42  56  70  84  98 112 126 140 154   2   3   4   5 
#  0  15  30  45  60  75  90 105 120 135 150 165   3   4   5   6 

# Window:
#  0   1   2   3 
#  1   2   3   4 
#  2   3   4   5 
#  3   4   5   6 

# cord x = 12, cord y = 12 returned in $v0 and $v1 registers

.text
.globl  vbsme

# Your program must follow spiral pattern.  

# Preconditions:
#   1st parameter (a0) address of the first element of the dimension info (address of asize[0])
#   2nd parameter (a1) address of the first element of the frame array (address of frame[0][0])
#   3rd parameter (a2) address of the first element of the window array (address of window[0][0])
# Postconditions:	
#   result (v0) x coordinate of the block in the frame with the minimum SAD
#          (v1) y coordinate of the block in the frame with the minimum SAD


# Begin subroutine
vbsme:  
    li      $v0, 0              # reset $v0 and $V1
    li      $v1, 0

    # insert your code here
    addi    $sp, $sp, -4        # make space on the stack
    sw      $ra, 0($sp)         # store the return address

    lw      $s0, 0($a0)         # s0 = frameHeight
    lw      $s1, 4($a0)         # s1 = frameLength
    lw      $s2, 8($a0)         # s2 = windowHeight
    lw      $s3, 12($a0)        # s3 = windowLength

    add		$s4, $zero, $zero   # s4 = top = 0
    sub     $s5, $s0, $s2       # s5 = bottom = frameHeight - windowHeight
    add     $s6, $zero, $zero   # s6 = left = 0
    sub     $s7, $s1, $s3       # s7 = right = frameLength - windowLength

    addi    $t0, $zero, 255
    mult    $t0, $s2            # minSum starts at maximum possible value (windowHeight*windowLength*255)
    mflo    $t0
    mult    $t0, $s3
    mflo    $t0
    li      $t1, 0              # set direction to 0
	
mainLoop:
    blt     $s5, $s4, exit      # if bottom < top, exit
    blt     $s7, $s6, exit      # if right < left, exit

    beq     $t1, $zero, right   # if dir == 0, go to right
    addi    $t2, $zero, 1       # t2 = 1
    beq     $t1, $t2, down      # if dir == 1, go to down
    addi    $t2, $t2, 1         # t2 = 2
    beq     $t1, $t2, left      # if dir == 2, go to left. Else, go to up.

up:
    add     $t2, $zero, $s5     # t2 = i = bottom
loopUp:
    blt     $t2, $s4, exitUp    # if i < top, exit
    add     $t3, $zero, $t2     # t3 = i
    add     $t4, $zero, $s6     # t4 = left
    jal     sad                 # take sad
    bge     $t9, $t0, skipUp    # if tempSum >= minSum, branch
    add     $t0, $t9, $zero     # minSum = tempSum
    add     $v0, $t2, $zero     # v0 = i
    add     $v1, $s6, $zero     # v1 = left
skipUp:
    addi    $t2, $t2, -1        # i--
    j       loopUp              # loop
exitUp:
    addi    $s6, $s6, 1         # left++
    addi    $t1, $zero, 0       # dir = 0
    j       mainLoop

right:
    add     $t2, $zero, $s6     # t2 = i = left
loopRight:
    blt     $s7, $t2, exitRight # if right < i, exit
    add     $t3, $zero, $s4     # t3 = top
    add     $t4, $zero, $t2     # t4 = i
    jal     sad                 # take sad
    bge     $t9, $t0, skipRight # if tempSum >= minSum, branch
    add     $t0, $t9, $zero     # minSum = tempSum
    add     $v0, $s4, $zero     # v0 = top
    add     $v1, $t2, $zero     # v1 = i
skipRight:
    addi    $t2, $t2, 1         # i++
    j       loopRight           # loop
exitRight:
    addi    $s4, $s4, 1         # top++
    addi    $t1, $zero, 1       # dir = 2
    j       mainLoop

down:
    add     $t2, $zero, $s4     # t2 = i = top
loopDown:
    blt     $s5, $t2, exitDown  # if bottom < i, exit
    add     $t3, $zero, $t2     # t3 = i
    add     $t4, $zero, $s7     # t4 = right
    jal     sad                 # Assume SAD will be in $t9 after returning
    bge     $t9, $t0, skipDown  # if tempSum >= minSum, branch
    add     $t0, $t9, $zero     # minSum = tempSum
    add     $v0, $t2, $zero     # v0 = i
    add     $v1, $s7, $zero     # v1 = right
skipDown:
    addi    $t2, $t2, 1         # i++
    j       loopDown            # loop
exitDown:
    addi    $s7, $s7, -1        # right--
    addi    $t1, $zero, 2       # dir = 2
    j       mainLoop

left:
    add     $t2, $zero, $s7     # t2 = i = right
loopLeft:
    blt     $t2, $s6, exitLeft  # if i < left, exit
    add     $t3, $zero, $s5     # t3 = bottom
    add     $t4, $zero, $t2     # t4 = i
    jal     sad                 # Assume SAD will be in $t9 after returning
    bge     $t9, $t0, skipLeft  # if tempSum >= minSum, branch
    add     $t0, $t9, $zero     # minSum = tempSum
    add     $v0, $s5, $zero     # v0 = bottom
    add     $v1, $t2, $zero     # v1 = i
skipLeft:
    addi    $t2, $t2, -1        # i++
    j       loopLeft            # loop
exitLeft:
    addi    $s5, $s5, -1        # bottom--
    addi    $t1, $zero, 3       # dir = 3
    j       mainLoop

exit:
    lw      $ra, 0($sp)         # load the original return address
    addi    $sp, $sp, 4         # return the stack
    jr      $ra                 # return


# Before calling this subroutine, place yPos in t3 and xPos in t4.
# The sum of absolute differences will be returned in t9.
# This function modifies all temp registers besides t0 and t2.
sad:

    sll     $t3, $t3, 2         # multiply yPos by 4 to get byte index
    sll     $t4, $t4, 2         # multiply xPos by 4 to get byte index
    li      $t1, 0              # initialize the sum to 0
    mul     $t5, $t3, $s1       # store yPos*frameLength in t3
    add     $t5, $t5, $t4       # t5 = yPos*frameLength + xPos
    add     $t5, $t5, $a1       # t5 is the desired index of frame
    add     $t6, $a2, $zero     # t6 is the desired index of window
    li      $t3, 0              # i = 0
loopi:
    slt     $t7, $t3, $s2       # t7 = i < windowHeight
    beq     $t7, $zero, exiti   # if i >= windowLength, exit loop
    li      $t4, 0              # j = 0
loopj:
    slt     $t7, $t4, $s3       # t7 = j < windowLength
    beq     $t7, $zero, exitj   # if j >= windowLength, exit loop
    lw      $t8, 0($t5)         # t8 contains the frame pixel
    lw      $t9, 0($t6)         # t9 contains the window pixel
    bge     $t8, $t9, absV
    sub     $t8, $t9, $t8
    j       endAbs
absV:
    sub     $t8, $t8, $t9       # t8 contains the difference between frame pixel and window pixel
endAbs:
    add     $t1, $t1, $t8       # add absolute difference to sum
    addi    $t5, $t5, 4         # increment frame index
    addi    $t6, $t6, 4         # increment window index
    addi    $t4, $t4, 1         # increment j
    j       loopj               # return to loopj start
exitj:
    sub     $t7, $s1, $s3       # t7 = frameLength - windowLength
    sll     $t7, $t7, 2         # multiply t7 by 4 to get byte index
    add     $t5, $t5, $t7       # increment frame index
    addi    $t3, $t3, 1         # increment i
    j       loopi               # return to loopi start

exiti:
    add     $t9, $t1, $zero     # store sum in t9
    jr      $ra
