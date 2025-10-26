.data
temp_msg: .asciiz "enter number: "
zero: .asciiz "zero.\n"
positive: .asciiz "positive.\n"
negative: .asciiz "negative.\n"

.text
main:   
    # ask user for number
    li $v0, 4
    la $a0, temp_msg
    syscall

    # read number from user
    li $v0, 5
    syscall
    
    # store number in $t0
    move $t0, $v0      

if:
    bne	 $t0, $zero, elseif	    # if t0 != 0 -> go to elseif
    la $a0, zero
    j endif

elseif:
    blez $t0, else              # if t0 <= 0 -> go to else
    la $a0, positive
    j endif

else:
    la $a0, negative

endif:
    li $v0, 4
    syscall

exit:
    li $v0, 10
    syscall
# end of program