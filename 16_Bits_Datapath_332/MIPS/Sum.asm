.data
ARRAY: .word 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21
N: .word 11
OUTPUT: .asciiz "The total is: "

.text
.global main
main:
	jal sum_array
	add $s5, $zero, $v0
	
	li  $v0, 4
	la  $a0, OUTPUT
	syscall
	
	li  $v0, 1
	add $a0, $zero, $s5
	syscall
	
	j Exit #jump to Exit

	
sum_array:
	la 	$s1, ARRAY			# s1 storing the base address of ARRAY
	lw 	$s2, N				# s2 is N which is 11
	move    $v0, $zero                      # v0 = 0 + 0 
	move    $s3, $zero 			# s3 = 0 (Counter)
	#add 	$v0, $zero, $zero 		# v0 will be the sum. initialized with 0
	
loop:
	sll  $t1, $s3, 2			# left shifted 2 times so s3 * = 2 and stored in t1
	add  $t1, $t1, $s1			# t1 = t1 + s1 .. adding t1 from the base address s1 will point to ARRAY[i], i being the index
	lw   $t1, 0($t1)			# t1 = array[i] 
	
	add  $v0, $v0, $t1			# adding to the result
	addi $s3, $s3, 1			# increment counter
	bne  $s3, $s2, loop			
	
	jr $ra
Exit:
 	li $v0, 10
 	syscall
