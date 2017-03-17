# Input:  Requests a character string from the user.
# Output: Prints the input string in uppercase.
################################Data segment###################################
.data
	# Uppercase string
u_word:	.asciiz
	"\nAlpha\n", "\nBravo\n", "\nChina\n", "\nDelta\n", "\nEcho\n", "\nFoxtrot\n",
	"\nGolf\n", "\nHotel\n", "\nIndia\n", "\nJuliet\n", "\nKilo\n", "\nLima\n",
	"\nMary\n", "\nNovember\n", "\nOscar\n", "\nPaper\n", "\nQuebec\n", "\nResearch\n",
	"\nSierra\n", "\nTango\n", "\nUniform\n", "\nVictor\n", "\nWhisky\n", "\nX-ray\n",
	"\nYankee\n", "\nZulu\n"
	# String address offset
uw_offset: .word
	0, 8, 16, 24, 32, 39, 
	49, 56, 64, 72, 81, 88, 
	95, 102, 113, 121, 129, 138, 
	149, 158, 166, 176, 185, 194, 
	202, 211
	# Lowercase string
l_word: .asciiz
	"\nalpha\n", "\nbravo\n", "\nchina\n", "\ndelta\n", "\necho\n", "\nfoxtrot\n",
	"\ngolf\n", "\nhotel\n", "\nindia\n", "\njuliet\n", "\nkilo\n", "\nlima\n",
	"\nmary\n", "\nnovember\n", "\noscar\n", "\npaper\n", "\nquebec\n", "\nresearch\n",
	"\nsierra\n", "\ntango\n", "\nuniform\n", "\nvictor\n", "\nwhisky\n", "\nx-ray\n",
	"\nyankee\n", "\nzulu\n"
	# String address offset
lw_offset: .word
	0, 8, 16, 24, 32, 39, 
	49, 56, 64, 72, 81, 88, 
	95, 102, 113, 121, 129, 138, 
	149, 158, 166, 176, 185, 194, 
	202, 211
	# 0-9
number: .asciiz
	"\nzero\n", "\nFirst\n", "\nSecond\n", "\nThird\n", "\nFourth\n",
	"\nFifth\n", "\nSixth\n", "\nSeventh\n", "\nEighth\n", "\nNinth\n"
	# number address offset
n_offset: .word
	0, 7, 15, 24, 32, 41, 49, 57, 67, 76
	# Invalid character
error: .asciiz "\n*\n"
################################CODE segment###################################
.text
.globl main
main:	
	li $v0, 12 #read character
	syscall
	beq $v0, 63, exit # '?' exit
	sub $t1, $v0, 48  # if  v0 < '0', goto others
	blt $t1, 0, others 
	
	# is number?
	blt $t1, 10, getnum # if true, get number
	
	# is capital?
	blt $v0, 65, others
	blt $v0, 91, getuword # if v0 >= 'A' && v0 <= 'Z'
	
	# is lower case?
	blt $v0, 97, others
	blt $v0, 123, getlword # if v0 >= 'a' && v0 <= 'z'
	j others
	
getnum:	
	sll $t1, $t1, 2
	la $s0, n_offset
	add $s0, $s0, $t1
	lw $s1, ($s0)
	la $a0, number
	add $a0, $a0, $s1
	li $v0,4
	syscall
	j main
	
	# upper case word
getuword: 
	  sub $t3, $v0, 65
   	  sll $t3, $t3, 2
   	  la $s0, uw_offset
   	  add $s0, $s0, $t3
   	  lw $s1, ($s0)
   	  la $a0, u_word
   	  add $a0, $s1, $a0
   	  li $v0, 4
   	  syscall
   	  j main
   	  
   	  # lower case word
getlword: 
	  sub $t3, $v0, 97
	  sll $t3, $t3, 2
	  la $s0, lw_offset
	  add $s0, $s0, $t3
	  lw $s1, ($s0)
	  la $a0, l_word
	  add $a0, $s1, $a0
	  li $v0, 4
	  syscall
	  j main
	# Invalid character
others:   
	  la $a0, error
          li $v0, 4
          syscall
	  j main
	  
	  # The end of the program
exit:	  li $v0, 10 # exit
	  syscall
