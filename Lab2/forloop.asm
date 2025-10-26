.data 
temp:   .asciiz "enter num: "
result: .asciiz "result: "
brk:    .asciiz "\n"

.text
main:
    # ask user to input n
    li $v0, 4
    la $a0, temp
    syscall

    # read n
    li $v0, 5
    syscall

    # store n
    move $t0, $v0      # end (n)

    # for parameters
    move $t1, $zero    # i = 0
    move $t2, $zero    # sum = 0   

for:
    bgt $t1, $t0, end  # if i > n, exit loop

    add $t2, $t2, $t1  # sum += i

    addi $t1, $t1, 1   # i++

    j for              # jump to next iteration

end:
    # print "result: "
    li $v0, 4
    la $a0, result
    syscall

    # print the sum value
    li $v0, 1
    move $a0, $t2
    syscall

    # print new line
    li $v0, 4
    la $a0, brk
    syscall

exit:
    li $v0, 10
    syscall
