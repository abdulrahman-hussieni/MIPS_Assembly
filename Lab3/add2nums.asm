##########################################################
#   File: lab3/add2nums.asm <func is a leaf> we solve as not leaf 
##########################################################

func:
    addi $sp , $sp , -4
    sw $ra ,0($sp)

    add $v0,$a0,$a1


returnfunc:
    lw $ra ,0($sp)
    addi $sp , $sp , 4
    jr $ra


main:
#1. allocate stack 
    addi $sp , $sp , -4
    sw $ra ,0($sp)

    #args /call /return/ print
    li $a0,10
    li $a1,12

    jal func

    move $a0,$v0

    li $v0 , 1
    syscall

returnMain:
#1. Deallocate stack and call jr $ra
    lw $ra ,0($sp)
    addi $sp , $sp , 4
    jr $ra
    