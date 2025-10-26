.data
enter_count: .asciiz "How many numbers do you want to average? "
enter_num: .asciiz "Please enter a number: "
result_msg: .asciiz "The average is: "
.text
main:
    # prompt for count of numbers
    li $v0, 4
    la $a0, enter_count
    syscall

    # read count
    li $v0, 5
    syscall
    move $t0, $v0          # store count in t0

    move $t1, $zero        # i = 0
    move $t2, $zero        # sum = 0

for:
    bge $t1, $t0, end      # if i >= count, exit loop

    # prompt for number
    li $v0, 4
    la $a0, enter_num
    syscall

    # read number
    li $v0, 5
    syscall

    add $t2, $t2, $v0      # sum += number

    addi $t1, $t1, 1       # i++
    
    j for                   # jump to next iteration


end:
    # calculate average
    move $t3, $t0          # move count to t3 for division
    div $t2, $t3           # divide sum by count
    mflo $t4               # move quotient (average) to t4

    # display result message
    li $v0, 4
    la $a0, result_msg
    syscall

    # display average
    li $v0, 1
    move $a0, $t4
    syscall

exit:
    li $v0, 10
    syscall