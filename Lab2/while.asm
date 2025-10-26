.data
brk: .asciiz "\n"

.text
main:
    # initialize counter
    li $t0, 1          # counter = 1
    li $t1, 10         # final condition = 10

while:
    bgt $t0, $t1, end  # if counter > 10, exit loop

    # print current number
    li $v0, 1
    move $a0, $t0
    syscall

    # print newline
    li $v0, 4
    la $a0, brk
    syscall

    # increment counter
    addi $t0, $t0, 1
    j while

end:
    li $v0, 10
    syscall
