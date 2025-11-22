###############################################################
#  factorial.asm
#  Computes the factorial of a number using loop and leaf function 
# How to compute factorial of a number : factorial(5) : 5! = 5*4*3*2*1 = 120
# factorial(n):
#     if n == 0:    
#         return 1
#     result = 1
#     for i from 1 to n:
#         result = result * i
#     return result
#  t0: counter // t1: result
###############################################################

func:
    li $t0 ,1 # counter
    li $t1, 1 # result
loop:
#  condition / job / counter / jump
    bgt $t0, $a0, endloop      # if counter > n → exit

    mul $t1,$t1,$t0         # mul: pesudo function

    addi $t0 , $t0 , 1      # counter ++

    j loop

endloop:
    # $t1 : result >> $v0
    move $v0 ,$t1

returnfunc:
# MUST: 
    jr $ra

main:
#1. allocate stack
    addi $sp , $sp, -4
    sw $ra ,0($sp)
# args / call / return / print
    li $a0 , 5
    
    jal  func

    move $a0 ,$v0

    li $v0 , 1
    syscall

returnMain:
#1. Deallocate stack
    lw $ra ,0($sp)
    addi $sp , $sp, 4
    
