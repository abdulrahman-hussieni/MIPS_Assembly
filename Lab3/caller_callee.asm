.data
A:  .word 4
B:  .word 6

.text
# ===========================
# Function: compute(a, b)
# returns (a + b) * 2
# ===========================
compute:
    # --- Callee-save step ---
    addi $sp, $sp, -4       # allocate stack space
    sw   $s0, 0($sp)        # save callee-saved register s0

    add  $s0, $a0, $a1      # s0 = a + b
    sll  $v0, $s0, 1        # v0 = s0 * 2

    # --- Callee-restore step ---
    lw   $s0, 0($sp)        # restore s0
    addi $sp, $sp, 4        # deallocate stack space
    jr   $ra                # return

# ===========================
# main function (caller)
# ===========================
main:
    lw   $t0, A
    lw   $t1, B
    li   $s0, 99             # example value to show s0 is preserved

    # --- Caller-save step ---
    addi $sp, $sp, -4        # save caller-saved register if needed
    sw   $t0, 0($sp)         # save t0 (example, optional)

    move $a0, $t0
    move $a1, $t1
    jal  compute
    move $t3, $v0

    # --- Caller-restore step ---
    lw   $t0, 0($sp)         # restore t0
    addi $sp, $sp, 4         # deallocate stack

    jr $ra                   # return from main
