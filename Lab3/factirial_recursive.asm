###########################################################
# Filename: factirial_recursive.asm
# Computes the factorial of a number using recursion    
# How to compute factorial of a number : factorial(5) : 5! = 5*4*3*2*1 = 120
# factorial(n): 
#     if n <= 1:    
#         return 1  
#     else:
#         return n * factorial(n-1) 
###########################################################

func:
# T0DO: recursive function : setup stack and caller save

    # allocate stack
    addi $sp,$sp,-4         # allocate 4 bytes for ra
    sw $ra , 0($sp)         # save return address

    addi $sp,$sp,-4         # allocate 4 bytes for n
    sw $a0 , 0($sp)         # save n

    # Base case n <= 1
    li $t0 ,1
    ble $a0 ,$t0 , Base

    # n > 1
    addi $a0,$a0,-1
    jal func                # call recursive func

    lw $a0 , 0($sp)         # restore original n
    mul $v0,$v0,$a0         # n * factorial(n-1)
    j returnfunc

Base: 
    li $v0, 1               # return 1    

returnfunc:
    # deallocate stack / jr $ra
    lw $a0 , 0($sp)         # restore n
    addi $sp,$sp,4

    lw $ra , 0($sp)         # restore return address
    addi $sp,$sp,4
    jr $ra


main:
    # allocate stack
    addi $sp,$sp,-4
    sw $ra , 0($sp)
    
    # args / call / return / print
    li $a0 , 5

    jal func

    move $a0 ,$v0

    li $v0 , 1
    syscall

returnMain:
    # deallocate stack / jr $ra
    lw $ra , 0($sp)
    addi $sp,$sp,4
    jr $ra
