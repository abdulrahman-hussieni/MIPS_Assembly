.data
temp: .asciiz"enter a num: "
result: .asciiz"sum: "
.text
main:
    # initialize $t1 = 0
    move $t1,$zero

do:
    # ask user for number
    li $v0, 4
    la $a0, temp
    syscall

    # read number from user
    li $v0, 5
    syscall

    # store number in $t0
    move $t0, $v0 

    # $t1 = $t1  + $t0
    add  $t1, $t1, $t0

while:  
    bne $t0,$zero,do

    
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $t1
    syscall

exit:
    li $v0,10
    syscall