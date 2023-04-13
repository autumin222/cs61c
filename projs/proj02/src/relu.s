.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
#
# If the length of the vector is less than 1, 
# this function exits with error code 8.
# ==============================================================================
relu:
    # Prologue
    addi sp sp -8
    sw ra 0(sp)
    sw t0 4(sp)
    # check length
    slti t0 a1 1
    beq t0 x0 loop_start # length more than 1 , enter loop
    addi a0 x0 8 # error code 8
    jar exit


loop_start:
    mv s0 a0 # the address
    mv s1 a1 # the length
    lw t0 0(s0)
    addi t1 x0 1 # counter
    blt t0, x0, loop_continue # if t0 < 0 then loop_continue
    







loop_continue:
    sw x0 0(s0)
    addi t1 t1 1 # counter++
    addi s0 s0 4 # move to the next position
    beq t1 length loop_end # get to the end of the matrix, stop the loop


loop_end:


    # Epilogue

    
	ret