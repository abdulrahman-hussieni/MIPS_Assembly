# --------------------------------------------------------------------
# Approuch 1 : main + leaf function
#--------------------------------------------------------------------

add_func:
    # 1. function job
    add $v0 ,$a0,$a1
    
    # 2. must call jr
    jr $ra

main:
    # setup stack frame 
    addi $sp, $sp, -4
    sw $ra, 0($sp)  # save return address
   
    # 1. Arguments: $a0 , $a1
    li $a0 , 12
    li $a1 , 10

    #2. call function using jal
    jal add_func

    #3. return: $v0
    move $a0, $v0

    #4. print
    li $v0, 1
    syscall

return_main:
    # restore stack frame
    lw $ra, 0($sp)  # restore return address
    addi $sp, $sp, 4
    jr $ra # like return 0;

#If we use return 0 normally, we face a problem with the RA (return address) register. The RA register stores the address where the program should return after finishing a function.

# However, when we call a function inside another function, the RA register gets overwritten:

# First function call → RA stores return address of the first function

# Second function call → RA is overwritten with the new return address

# This means when the second function finishes, the original return address is lost, and the program cannot return correctly to the first function.

# Solution:
# We must save the old RA value on the stack before calling another function, and restore it when the function ends. This ensures that each function keeps its own correct return address.

#--------------------------------------------------------------------
# Approuch 2 : main + non-leaf function
#--------------------------------------------------------------------

add_func:
    # 1. setup stack frame        
    addi $sp, $sp, -4
    sw $ra, 0($sp)  # save return address
    # 2. function job
    add $v0 ,$a0,$a1
    # 3. restore stack frame
    lw $ra, 0($sp)  # restore return address
    addi $sp, $sp, 4
    # 4. must call jr 
    jr $ra
main:
    # setup stack frame
    addi $sp, $sp, -4
    sw $ra, 0($sp)  # save return address 
    # 1. Arguments: $a0 , $a1
    li $a0 , 12
    li $a1 , 10
    #2. call function using jal
    jal add_func
    #3. return: $v0
    move $a0, $v0
    #4. print
    li $v0, 1
    syscall
return_main:
    # restore stack frame
    lw $ra, 0($sp)  # restore return address
    addi $sp, $sp, 4
    jr $ra # like return 0;