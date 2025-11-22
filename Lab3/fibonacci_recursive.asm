###########################################################
# Filename:  fibonacci.asm
# Computes the nth Fibonacci number using recursion    
# How to compute Fibonacci of a number : fibonacci(5) : fib(5) = 5
# fibonacci(n):     
#     if n <= 1:    
#         return n
#     else:
#         return fibonacci(n-1) + fibonacci(n-2)
###########################################################
func:
    addi $sp,$sp,-12       # allocate 12 bytes (not 8)
    sw $ra , 8($sp)        # save return address
    sw $a0 , 4($sp)        # save n
    # $t1 will be saved at 0($sp) before second call

    li $t0,1
    ble $a0 ,$t0,Base

    # First call: fib(n-1)
    addi $a0 , $a0 , -1
    jal func
    move $t1 , $v0         # t1 = fib(n-1)
    
    sw $t1 , 0($sp)        # *** SAVE $t1 before second call ***

    # Second call: fib(n-2)
    lw $a0 , 4($sp)
    addi $a0 , $a0 , -2
    jal func

    # Restore and add
    lw $t1 , 0($sp)        # *** RESTORE $t1 ***
    add $v0 ,$t1 ,$v0      # fib(n-1) + fib(n-2)
    j returnfunc

Base:
    move $v0 , $a0

returnfunc:
    lw $a0 , 4($sp)
    lw $ra , 8($sp)
    addi $sp,$sp, 12
    jr $ra

main:
# alloacate stack
    addi $sp,$sp,-4
    sw $ra , 0($sp)

# args<number from user> / call / return / print
    li $v0, 5              # syscall to read integer
    syscall
    move $a0, $v0          # store input in $a0

    jal func

    move $a0 ,$v0

    li $v0 , 1
    syscall


returnMain:
# DEallocate stack
    lw $ra , 0($sp)
    addi $sp,$sp, 4
    jr $ra
