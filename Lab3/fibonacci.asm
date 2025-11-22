###########################################################
# Filename:  fibonacci_iterative.asm
# Computes the nth Fibonacci number using iteration (loop)
# Algorithm:
#     if n <= 1:
#         return n
#     fib_prev = 0
#     fib_curr = 1
#     for i = 2 to n:
#         fib_next = fib_prev + fib_curr
#         fib_prev = fib_curr
#         fib_curr = fib_next
#     return fib_curr
###########################################################

func:
    # No stack needed - no recursion!
    # $a0 = n (input)
    # $v0 = result (output)
    
    # Base case: if n <= 1, return n
    li $t0, 1
    ble $a0, $t0, Base
    
    # n > 1: use iterative approach
    # $t1 = fib_prev (starts at 0)
    # $t2 = fib_curr (starts at 1)
    # $t3 = fib_next (temporary)
    # $t4 = counter i (starts at 2)
    
    li $t1, 0              # fib_prev = 0
    li $t2, 1              # fib_curr = 1
    li $t4, 2              # i = 2
    
Loop:
    bgt $t4, $a0, EndLoop  # if i > n, exit loop
    
    add $t3, $t1, $t2      # fib_next = fib_prev + fib_curr
    move $t1, $t2          # fib_prev = fib_curr
    move $t2, $t3          # fib_curr = fib_next
    
    addi $t4, $t4, 1       # i++
    j Loop
    
EndLoop:
    move $v0, $t2          # return fib_curr
    j returnfunc

Base:
    move $v0, $a0          # return n
    j returnfunc

returnfunc:
    jr $ra


main:
    # Allocate stack
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    # Read integer from user
    li $v0, 5              # syscall to read integer
    syscall
    move $a0, $v0          # store input in $a0
    
    # Call func
    jal func
    
    # Print result
    move $a0, $v0
    li $v0, 1              # syscall to print integer
    syscall
    
    # Deallocate stack
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra