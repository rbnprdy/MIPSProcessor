
########################################################################################################################
### main
########################################################################################################################
.data
asize0:  .word    100, 200, 300, 400, 500, 600
asize1:  .word	  700, 800, 900, 1000, 1100, 1200
.text

.globl main

main: 
la $s2, asize0		#[s2] = 0x10010000
lw $s2, 0($s2)		#[s2] = 0x64

la $s3, asize0
lw $s3, 4($s3)		#[s3] = 0xc8





#Read After Write(RAW) case 1
# stall
add $s1, $s2, $s3		#[s1] = 0x12c
sub $s4, $s1, $s3		#[s4] = 0x64
sub $s1, $s1, $s4		#[s1] = 0xc8
mul $s4, $s1, $s3		#[s4] = 0x9c40

#Write after read case 2
sub $s4, $s1, $s3		#[s4] = 0x0
add $s1, $s2,$s3		#[s1] = 0x12c
mul $s6, $s1, $s4		#[s6] = 0x0



#write after write case 3
sub $s1, $s4, $s6		#[s1] = 0x0
add $s1, $s2, $s6		#[s1] = 0x64
ori $s1, $s1, 0xaaaa	#[s1] = 0xaaee
sll $s1, $s1, 10		#[s1] = 0x2abb800

#Stall case 4
addi $s5, $s1, 0		#[s5] = 0x2abb800
addi $s7, $s5, 0		#[s7] = 0x2abb800
la $s2, asize1			#
lw $s1, 0($s2)			#[s1] = 0x2bc
# stall
sub $s4, $s1, $s5		#[s4] = 0xfd544abc
and $s6, $s1, $s7		#[s6] = 0x0
or $s7, $s1, $s6		#[s7] = 0x2bc


#text book example case 5
sub $s2, $s1, $s3		#[s2] = 0x1f4
and $t0, $s2, $s5		#[t0] = 0x0
or $t1, $s6, $s2		#[t1] = 0x1f4
add $t2, $s2, $s2		#[t2] = 0x3e8
la $s1 , asize0			#
sw $t1, 4($s1)			#
lw $t2, 4($s1)			#[t2] =  0x1f4



#case 6 
sub   $s2,    $s1,   $s3    #[s2] = 0xffffff38
or    $t3,  $s2,   $s5        #[t3] = 0xffffff38
add   $t4,  $s2,   $s2        #[t4] = 0xfffffe70
or    $t2, $s2, $s2        #[t2] = 0xffffff38
add   $s4,   $s7,    $t2    #[s4] = 0x000001f4

#case 7
la $t1, asize0				#
lw $t0, 0($t1)				#[t0] = 0x64
lw $t2, 4($t1)				#[t2] = 0x1f4
sw $t2, 0($t1)				#
sw $t0, 4($t1)				#
lw $t0, 0($t1)				#[t0] = 0x1f4
lw $t2, 4($t1)				#[t2] = 0x64


#branch  cases 8,9,10
la      $a0, asize1			#
j       start               # jump to jump1.
# stall
addi    $a0, $zero, -1      # if $a0 == -1, jump failed.
addi    $a0, $zero, -1      # if $a0 == -1, jump failed.
start:
lw      $s0, 4($a0)	# [s0] = 0x320
sw      $s0, 0($a0)

branch1:
# stall
bgez    $s0, branch2 	# taken
# stall
addi    $s0, $s0, 1
bgez    $s0, branch1    
j       error         

branch2:
addi    $s0, $zero, -1  # [s0] = -1
# stall
bltz    $s0, branch3    # taken
addi    $s0, $zero, 1   
bgtz    $s0, branch2    
j       error           

branch3:
bltz    $s0, done		# taken
addi    $s0, $zero, -1  # should be flushed
bltz    $s0, branch3    
j       error 
	
done:
j done
error:
j error
	          
