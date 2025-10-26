.data
num1: .asciiz"plesae enter first number: "
num2: .asciiz"plesae enter second number: "
num3: .asciiz"plesae enter third number: "
num4: .asciiz"plesae enter fourth number: "
result_msg: .asciiz"The average is: "

.text
main:
    # prompt for first number
    li $v0,4                # temp-msg to input 1st num
    la $a0,num1
    syscall

    li $v0,5                # read num1
    syscall                                                
    move $t0, $v0          # store num1 in t0

    # prompt for second number
    li $v0,4                # temp-msg to input 2st num
    la $a0,num2
    syscall

    li $v0,5                # read num2
    syscall                                                
    move $t1, $v0          # store num2 in t1

    # prompt for third number
    li $v0,4                # temp-msg to input 3st num
    la $a0,num3
    syscall

    li $v0,5                # read num3
    syscall                                                
    move $t2, $v0          # store num3 in t2
    
    # prompt for fourth number
    li $v0,4                # temp-msg to input 4st num
    la $a0,num4
    syscall

    li $v0,5                # read num4
    syscall                                                
    move $t3, $v0          # store num4 in t3

    # Calculate average
    add $t4, $t0, $t1      # t4 = num1 + num2
    add $t4, $t4, $t2      # t4 = t4 + num3
    add $t4, $t4, $t3      # t4 = t4 + num4
    
    li $t5, 4              # count of numbers (sum/4)
    div $t4, $t5           # divide sum by 4
    
    mflo $t6               # move quotient to t6

    # Display result message
    li $v0, 4              # print string
    la $a0, result_msg
    syscall

    # Display average
    li $v0, 1              # print integer
    move $a0, $t6
    syscall

    exit_program:
        li $v0,10          # exit program
        syscall