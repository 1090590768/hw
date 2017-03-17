# Input:  Requests a string from user.
# Output: Prints if the character is in the string.
#######################Data segment##################### 
.data
msg_success:	.asciiz "\r\nSuccess! Location: "
msg_fail:       .asciiz "\r\nFail!\r\n"
s_end:      	.asciiz "\r\n"
buf:        	.space 100    # The longest length is 99 characters
#######################Code segment#####################
.text
.globl main
main:       
	la $a0, buf # address of input buffer
        la $a1, 100 # maximum number of characters to read
        li $v0, 8   # read string
        syscall

inputchar:  
        li $v0, 12  # read character
        syscall
        beq $v0, 63, exit # '?' exit
        add $t0, $0, $0
        la $s1, buf

find_loop:  
	lb $s0, 0($s1)
        beq $v0, $s0, success # find
        addi $t0, $t0, 1
        beq $t0, $a1, fail    # not find
        addi $s1 $s1, 1
        j find_loop           # Loop comparison

success:    
	la $a0, msg_success
        li $v0, 4 # print string
        syscall
        addi $a0, $t0, 1
        li $v0, 1 # print integer
        syscall
        la $a0, s_end
        li $v0, 4
        syscall
        j inputchar

fail:      
	la $a0, msg_fail
        li $v0, 4 # print string
        syscall
        j inputchar

exit:       
	li $v0, 10
        syscall
