
.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10

.text
main:
# Registers NOT to be used x0 to x4 and x10 to x17; reason to be explained later
# Registers that we can use x5 to x9 and x18 to x31; reason to be explained later
    addi x5, x0, 5 # let x5 be size and set it to 5
    addi x6, x0, 0 # let x6 be sob that = 0
#    for (i = 0; i < 5; i++) {
#        sop += a[i] * b[i];
#    }
    addi x7, x0, 0 # let x7 be i and set it to 0
    la x8, a # loading the address of a to x8
    la x9, b # loading the address of b to x9
    
loop1:
    bge x7, x5, exit1 # check if i >= size, if so goto exit1
    slli x18, x7, 2 # set x18 to i*4
    add x19, x18, x8 # add i*4 to the base address off arr1 and put it to x19 
    lw x20, 0(x19) # a[i]
    add x21, x18, x9 # add i*4 to the base address off arr1 and put it to x20
    lw x22, 0(x21)
    mul x23, x20, x22 
    add x6, x6, x23
    addi x7, x7, 1 # i++
    j loop1
    
exit1:
    addi a0, x0, 1
    add a1, x0, x6
    ecall
    
    # exit cleanly
    addi a0, x0, 10
    ecall
    