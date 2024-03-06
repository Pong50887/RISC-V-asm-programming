.data
array_a: .word 1, 2, 3, 4, 5
array_b: .word 6, 7, 8, 9, 10
text: .string "The dot product is: "
newline: .string "\n"

.text
main:
    la a0, array_a    # Load the address of array_a into a0
    la a1, array_b    # Load the address of array_b into a1
    addi a2, x0, 5    # Set the size of arrays into a2
    addi s1, x0, 0    # Initialize the result of dot_product_recursive to 0
    jal dot_product_recursive
    
    mv s1, a0         # Move the result of dot_product_recursive function to s1
 
    # Print the text character; using the print_string syscall
    addi a0, x0, 4
    la a1, text
    ecall
    
    # Print the result; using the print_int syscall
    addi a0, x0, 1
    add a1, x0, s1
    ecall
   
    # Print a newline character; using the print_string syscall
    addi a0, x0, 4
    la a1, newline
    ecall
   
    # Exit cleanly
    addi a0, x0, 10
    ecall

dot_product_recursive:
    # Base case
    # Check if the size of the array equals 1, go to exit_base_case
    addi t0, x0, 1          
    beq a2, t0, exit_base_case 
    
    # Recursive case 
    # Save ra on the stack
    addi sp, sp, -4             
    sw ra, 0(sp)    
    
    # Save a0 and a1 on the stack
    addi sp, sp, -8
    sw a0, 0(sp)
    sw a1, 4(sp)
    
    # Recursive call: dot_product_recursive(a+1, b+1, size-1)
    addi a0, a0, 4  # Increment the address of array_a by 4
    addi a1, a1, 4  # Increment the address of array_b by 4
    addi a2, a2, -1 # Decrement the size of the array by 1
    jal dot_product_recursive
    mv t1, a0 # Move the result of dot_product_recursive(a+1, b+1, size-1) to t1
    
    # Restore a0 and a1 to their original values
    lw a0, 0(sp)
    lw a1, 4(sp)
    addi sp, sp, 8
    
    lw a3, 0(a0)  # Load the value of array_a[0]
    lw a4, 0(a1)  # Load the value of array_b[0]
    mul t2, a3, a4  # t2 = array_a[0] * array_b[0]
    add a0, t2, t1  # a0 = array_a[0] * array_b[0] + dot_product_recursive(a+1, b+1, size-1)

    lw ra, 0(sp)
    addi sp, sp, 4
    
    jr ra   
    
exit_base_case:
    lw a3, 0(a0)   # Load the value of array_a[0]
    lw a4, 0(a1)   # Load the value of array_b[0]
    mul a0, a3, a4 # a0 = array_a[0] * array_b[0]
    jr ra
