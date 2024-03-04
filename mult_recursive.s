.text
main:
    # pass the first argument to a0
    # pass the sencond argument to a1
    addi a0, x0, 110 # add value A = 110 into a0
    addi a1, x0, 50  # add value B = 50 into a1
    jal mult

#print_int
    mv a1, a0 # by convention the return value is alway in a0
    addi a0, x0, 1
    ecall

#exit cleanly
    addi a0, x0, 10
    ecall

mult:
    # base case
    # compare a1 with 1, if the two are equal you exit the mult function
    addi t0, x0, 1              # set value of t0 = 1
    beq a1, t0, exit_base_case  # check if b == 1 go to exit_base_case

#recursive case
#save ra on the stack
    addi sp, sp, -4
    sw ra, 0(sp)

#mult(a, b-1)
#save a0 on the stack
    addi sp, sp, -4
    sw a0, 0(sp)
    addi a1, a1, -1
    jal mult

#move result of mult(a, b-1) to t1
    mv t1, a0 

#restoring a0 their origin value before the call to mult
    lw a0, 0(sp)
    addi sp, sp, 4

#a + mult(a, b-1)
    add a0, a0, t1

#restoring ra their origin value
    lw ra, 0(sp)
    addi sp, sp, 4
    jr ra

exit_base_case: 
    jr ra