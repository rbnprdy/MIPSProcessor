# 
# Author: Shuai Chang, Nirmal Kumbhare
#
# Prepare your instruction memory with the following instructions.
# You need to translate instructions into binary.
# Then hardcode the binary number into instruction memory.
# for example, the instruction: 
# and $s0, $s0, $s1 will be translated into 
# opcode(6)    rs(5)      rt(5)      rd(5)      sa(5)      function      
# 000000       10000      10000      10001      00000      100100
# In Verilog, memory[0] = 32'b00000010000100001000100000100100
# In Verilog, hex format, memory[0] = 32'h02108824  // and $s0, $s0, $s1
.text               # Put program here
.globl main         # globally define 'main'


main:
addi    $s0, $zero, 1       # $s0 = 1
nop
nop
nop
nop
nop
addi    $s1, $zero, 1       # $s1 = 1
nop
nop
nop
nop
nop
and     $s0, $s0, $s1       # $s0 = 1
nop
nop
nop
nop
nop
and     $s0, $s0, $zero     # $s0 = 0
nop
nop
nop
nop
nop
sub     $s0, $s1, $s0       # $s0 = 1
nop
nop
nop
nop
nop
nor     $s0, $s0, $zero     # $s0 = -2
nop
nop
nop
nop
nop
nor     $s0, $s0, $zero     # $s0 = 1
nop
nop
nop
nop
nop
or      $s0, $zero, $zero   # $s0 = 0
nop
nop
nop
nop
nop
or      $s0, $s1, $zero     # $s0 = 1
nop
nop
nop
nop
nop
sll     $s0, $s0, 2         # $s0 = 4
nop
nop
nop
nop
nop
sllv    $s0, $s0, $s1       # $s0 = 8
nop
nop
nop
nop
nop
slt     $s0, $s0, $zero     # $s0 = 0
nop
nop
nop
nop
nop
slt     $s0, $s0, $s1       # $s0 = 1
nop
nop
nop
nop
nop
sra     $s0, $s1, 1         # $s0 = 0
nop
nop
nop
nop
nop
srav    $s0, $s1, $zero     # $s0 = 1
nop
nop
nop
nop
nop
srl     $s0, $s1, 1         # $s0 = 0
nop
nop
nop
nop
nop
sll     $s0, $s1, 3         # $s0 = 8
nop
nop
nop
nop
nop
srl     $s0, $s0, 3         # $s0 = 1
nop
nop
nop
nop
nop
sllv    $s0, $s0, $s1       # $s0 = 2
nop
nop
nop
nop
nop
srlv    $s0, $s0, $s1       # $s0 = 1
nop
nop
nop
nop
nop
xor     $s0, $s0, $s1       # $s0 = 0
nop
nop
nop
nop
nop
xor     $s0, $s0, $s1       # $s0 = 1
nop
nop
nop
nop
nop
addi	$s2, $zero, 4		# $s2 = 4	
nop
nop
nop
nop
nop
mul     $s0, $s0, $s2       # $s0 = 4
nop
nop
nop
nop
nop
addi    $s0, $s0, 4         # $s0 = 8
nop
nop
nop
nop
nop
andi    $s0, $s0, 0         # $s0 = 0
nop
nop
nop
nop
nop
ori     $s0, $s0, 1         # $s0 = 1
nop
nop
nop
nop
nop
slti    $s0, $s0, 0         # $s0 = 0
nop
nop
nop
nop
nop
slti    $s0, $s0, 1         # $s0 = 1
nop
nop
nop
nop
nop
xori    $s0, $s0, 1         # $s0 = 0
nop
nop
nop
nop
nop
xori    $s0, $s0, 1         # $s0 = 1
nop
nop
nop
nop
nop
addi    $s0, $zero, -2      # $s0 = -2
nop
nop
nop
nop
nop
addi    $s1, $zero, 2       # $s1 = 2
nop
nop
nop
nop
nop
sltu    $s2, $s1, $s0       #$s2 = 1
nop
nop
nop
nop
nop
sltiu   $s0, $s1, -2        #$s0 = 1
nop
nop
nop
nop
nop
movz    $s0, $s1, $zero     #$s0 = 2
nop
nop
nop
nop
nop
movn    $s0, $zero, $s1     #$s0 = 0
nop
nop
nop
nop
nop
add     $s0, $s1, $s2       #$s0 = 3
nop
nop
nop
nop
nop
addi    $s0, $zero, -2      # $s0 = -2
nop
nop
nop
nop
nop
addu    $s1, $s1, $s0       #s1 = 0
nop
nop
nop
nop
nop
addiu  $s1, $zero, -1 		#s1 = -1
nop
nop
nop
nop
nop
addi   $s2, $zero, 32       # $s2 = 32
nop
nop
nop
nop
nop
mult   $s1, $s2 #HI = -1  LO = -32
nop
nop
nop
nop
nop
mfhi   $s4  # $s4 = -1
nop
nop
nop
nop
nop
mflo   $s5 #s5 = -32
nop
nop
nop
nop
nop
multu  $s1, $s2 #HI = 31(0x1f)  LO = -32 (0xffffffe0)
nop
nop
nop
nop
nop
mfhi   $s4  # $s4 = 31
nop
nop
nop
nop
nop
mflo   $s5 #s5 = -32
nop
nop
nop
nop
nop
madd   $s1, $s2 #HI = 31(0x1f)  LO = -64 (0xffffffc0)
nop
nop
nop
nop
nop
mfhi   $s4  # $s4 = 31
nop
nop
nop
nop
nop
mflo   $s5 #s5 = -64
nop
nop
nop
nop
nop
mthi   $s2 #HI = 32 // Now a nop
nop
nop
nop
nop
nop
mtlo   $s1 #LO = -1 // Now a nop
nop
nop
nop
nop
nop
mfhi   $s4  # $s4 = 32
nop
nop
nop
nop
nop
mflo   $s5 #s5 = -1
nop
nop
nop
nop
nop
andi   $s1 , $s1, 65535  #s1= 65535 
nop
nop
nop
nop
nop
msub   $s4 , $s2     #HI = 32 LO = -1025 // Now HI = 31,LO = -1088
nop
nop
nop
nop	
nop
mfhi   $s4  # $s4 = 32
nop
nop
nop
nop
nop
mflo   $s5 #s5 = -1025
nop
nop
nop
nop
nop
addi   $s2, $zero, 1
nop
nop
nop
nop
nop
rotr   $s1, $s2, 31   #s1 = 2
nop
nop
nop
nop
nop
addi   $s4, $zero, 31
nop
nop
nop
nop
nop
rotrv   $s1, $s1, $s4 # s1 = 4
nop
nop
nop
nop
nop
ori    $s1 , $zero, 0x0FF0 #s1 = 4080
nop
nop
nop
nop
nop
seb    $s4, $s1   #s4 = -16
nop
nop
nop
nop
nop
seh    $s4 , $s1  #s4 = 4080
nop
nop
nop
nop
nop
