.data
    # Variables for a, b, c, perimeter, s, area, and temporary variables
    a:         .word 0
    b:         .word 0
    c:         .word 0
    perimeter: .word 0
    s:         .word 0
    area:      .word 0
    newline:   .asciiz "\n"
	perimeter_msg:   .asciiz "Perimeter: "
    area_msg:        .asciiz "Area: "
    invalid_msg:     .asciiz "Invalid\n"

.text
  
    main:
        # Input: Read integers for a, b, and c
        li $v0, 5
        syscall
        sw $v0, a
        
        li $v0, 5
        syscall
        sw $v0, b
        
        li $v0, 5
        syscall
        sw $v0, c

        # Check validity: a + b <= c || a + c <= b || b + c <= a
        lw $t0, a
        lw $t1, b
        lw $t2, c
        add $t3, $t0, $t1
        add $t4, $t0, $t2
        add $t5, $t1, $t2

        bge $t2, $t3, invalid
        bge $t1, $t4, invalid
        bge $t0, $t5, invalid

        # Calculate perimeter
        add $t6, $t0, $t1
        add $t6, $t6, $t2
        sw $t6, perimeter
		
		
		# Print "Perimeter: "
        li $v0, 4
        la $a0, perimeter_msg
        syscall

		li $v0, 1
        move $a0, $t6
        syscall		
		
        li $v0, 4
        la $a0, newline
        syscall

        # Call the divide_by_two function to divide the perimeter by 2
		lw $a0, perimeter		
        jal divide_by_two

        # Move the result (s) from $v0 to $t6
        move $t6, $v0 # s
        
        ## Print the integer value in $t6 (perimeter / 2)
       	# li $v0, 1
        # move $a0, $t6
        # syscall
		
		# $t6 now contains "s"
		
		sub $t7, $t6, $t0 # s - a
		sub $t8, $t6, $t1 # s - b
		sub $t9, $t6, $t2 # s - c
		
		mult $t6, $t7  # s * (s - a)
		mflo $t6   
        mult $t6, $t8  # (s * (s - a)) * (s - b)
		mflo $t6		
		mult $t6, $t9  # ((s * (s - a)) * (s - b)) * (s - c)
		mflo $t6 	
		
		move $a0, $t6	
        jal  isqrt
		
		move $t6, $v0	
		
		# Print "Area: "
        li $v0, 4
        la $a0, area_msg
        syscall
		
		li $v0, 1
        move $a0, $t6
        syscall
		
		li $v0, 4
        la $a0, newline
        syscall

        j end

    invalid:
        # Output: Print "Invalid" message
        li $v0, 4
        la $a0, invalid_msg
        syscall
		j end
		
	# Function to divide a value by 2 using subtraction loop (floor division)
    # Input: $a0 - Value to be divided by 2
    # Output: $v0 - Result (quotient, which is value / 2)
    divide_by_two:       

        # Initialize quotient to 0
        li $v0, 0

    divide_loop:
        # Subtract 2 from the value
        sub $a0, $a0, 2

        # Increment quotient
        addi $v0, $v0, 1

        # Check if the value is greater than or equal to 2
        bgez $a0, divide_loop
		sub $v0, $v0, 1
        jr $ra  # Return  

    # SQRT function

    isqrt:
    # v0 - return / root
    # t0 - bit
    # t1 - num
    # t2,t3 - temps
    move  $v0, $zero        # initalize return
    move  $t1, $a0          # move a0 to t1

    addi  $t0, $zero, 1
    sll   $t0, $t0, 30      # shift to second-to-top bit

    isqrt_bit:
    slt   $t2, $t1, $t0     # num < bit
    beq   $t2, $zero, isqrt_loop

    srl   $t0, $t0, 2       # bit >> 2
    j     isqrt_bit

    isqrt_loop:
    beq   $t0, $zero, isqrt_return

    add   $t3, $v0, $t0     # t3 = return + bit
    slt   $t2, $t1, $t3
    beq   $t2, $zero, isqrt_else

    srl   $v0, $v0, 1       # return >> 1
    j     isqrt_loop_end

    isqrt_else:
    sub   $t1, $t1, $t3     # num -= return + bit
    srl   $v0, $v0, 1       # return >> 1
    add   $v0, $v0, $t0     # return + bit

    isqrt_loop_end:
    srl   $t0, $t0, 2       # bit >> 2
    j     isqrt_loop

    isqrt_return:
    jr  $ra

    end:
        # Print a newline
        li $v0, 4
        la $a0, newline
        syscall

        # Exit program
        li $v0, 10
        syscall
		