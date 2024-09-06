.data
name: .space 50       
len_prompt: .asciiz "Enter the length of your first and last name: "
name_prompt: .asciiz "Enter your first and last name: "
max_prompt: .asciiz "Maximum ASCII value: "
min_prompt: .asciiz "Minimum ASCII value: "
newline:    .asciiz "\n"

.text
.globl main
main:
 
  li $v0, 4          
  la $a0, len_prompt  
  syscall             

  # Read length of first and last name
  li $v0, 5          
  syscall              
  move $t0, $v0       
 
  
  li $v0, 4           
  la $a0, name_prompt  
  syscall              

  addi $t0, $t0, 1     #(+1 for null-terminator) ****
  
  # Read name
  li $v0, 8            
  la $a0, name       
  move $a1, $t0    
  syscall       
  
  # Initialize max and min values
  li $t1, 0            # Initialize max value to 0
  li $t2, 256          # Initialize min value to 256

  # Loop to calculate max and min ASCII values
  la $a0, name       
  addi $t3, $a0, 0     
  add $t4, $a0, $t0    
  loop:
    lb $t5, 0($t3)    
    addi $t3, $t3, 1   
    beq $t3, $t4, done 


    beq $t5, 32, loop  # continue


    bgt $t5, $t1, UPD_MAX 
    here:
    blt $t5, $t2, UPD_MIN 
 	
    j loop

UPD_MAX:
  move $t1, $t5 
  j here

UPD_MIN:
  move $t2, $t5 
  j loop

done:
   
    li $v0, 4         
    la $a0, newline    
    syscall            
    

    li $v0, 4        
    la $a0, max_prompt  
    syscall            

    move $a0, $t1       
    li $v0, 1          
    syscall            


    li $v0, 4          
    la $a0, newline   
    syscall            

   
    li $v0, 4        
    la $a0, min_prompt  
    syscall            

    move $a0, $t2      
    li $v0, 1          
    syscall            

    # Exit 
    li $v0, 10         
    syscall
