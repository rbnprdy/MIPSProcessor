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
addi    $s1, $zero, 1       # $s1 = 1
and     $s0, $s0, $s1       # $s0 = 1
and     $s0, $s0, $zero     # $s0 = 0
sub     $s0, $s1, $s0       # $s0 = 1
nor     $s0, $s0, $zero     # $s0 = -2
nor     $s0, $s0, $zero     # $s0 = 1
or      $s0, $zero, $zero   # $s0 = 0
or      $s0, $s1, $zero     # $s0 = 1
sll     $s0, $s0, 2         # $s0 = 4
sllv    $s0, $s0, $s1       # $s0 = 8
slt     $s0, $s0, $zero     # $s0 = 0
slt     $s0, $s0, $s1       # $s0 = 1
sra     $s0, $s1, 1         # $s0 = 0
srav    $s0, $s1, $zero     # $s0 = 1
srl     $s0, $s1, 1         # $s0 = 0
sll     $s0, $s1, 3         # $s0 = 8
srl     $s0, $s0, 3         # $s0 = 1
sllv    $s0, $s0, $s1       # $s0 = 2
srlv    $s0, $s0, $s1       # $s0 = 1
xor     $s0, $s0, $s1       # $s0 = 0
xor     $s0, $s0, $s1       # $s0 = 1
addi	$s2, $zero, 4		# $s2 = 4
mul     $s0, $s0, $s2       # $s0 = 4
addi    $s0, $s0, 4         # $s0 = 8
andi    $s0, $s0, 0         # $s0 = 0
ori     $s0, $s0, 1         # $s0 = 1
slti    $s0, $s0, 0         # $s0 =
slti    $s0, $s0, 1         # $s0 = 1
xori    $s0, $s0, 1         # $s0 = 0
xori    $s0, $s0, 1         # $s0 = 1
addi    $s0, $zero, -2      # $s0 = -2
addi    $s1, $zero, 2       # $s1 = 2
sltu    $s2, $s1, $s0       #$s2 = 1
sltiu   $s0, $s1, -2        #$s0 = 1
movz    $s0, $s1, $zero     #$s0 = 2
movn    $s0, $zero, $s1     #$s0 = 0
add     $s0, $s1, $s2       #$s0 = 3
addi    $s0, $zero, -2      # $s0 = -2
addu    $s1, $s1, $s0       #s1 = 0
addiu  $s1, $zero, -1
addi   $s2, $zero, 32       # $s2 = 32
mult   $s1, $s2 #HI = -1  LO = -32
mfhi   $s4  # $s4 = -1
mflo   $s5 #s5 = -32
multu  $s1, $s2 #HI = 31(0x1f)  LO = -32 (0xffffffe0)
mfhi   $s4  # $s4 = 31
mflo   $s5 #s5 = -32
madd   $s1, $s2 #HI = 31(0x1f)  LO = -64 (0xffffffc0)
mfhi   $s4  # $s4 = 31
mflo   $s5 #s5 = -64
mthi   $s2 #HI = 32
mtlo   $s1 #LO = -1
mfhi   $s4  # $s4 = 32
mflo   $s5 #s5 = -1
andi   $s1 , $s1, 65535  #s1= 65535
msub   $s4 , $s2     #HI = 32 LO = -1025
mfhi   $s4  # $s4 = 32
mflo   $s5 #s5 = -1025
addi   $s2, $zero, 1
rotr   $s1, $s2, 31   #s1 = 2
addi   $s4, $zero, 31
rotrv   $s1, $s1, $s4 # s1 = 4
ori    $s1 , $zero, 0x0FF0
seb    $s4, $s1   #s4 = -16
seh    $s4 , $s1  #s4 = 4080
